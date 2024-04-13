//
//  NetworkManager.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 1/30/24.
//

import Foundation
import SwiftUI

enum DDError: String, Error {
    case BadResponseError
    case DecodingError
    case BADURL
    case BADImage
}

final class NetworkManager: Sendable {
    
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com"
    let imageCache = ImageCache()
    
    private init() { }
    
    func getFollowers(for username: String, page: Int) async throws -> [Follower] {
        let endpoint = baseURL + "/users/\(username)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else {
            throw DDError.BADURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw DDError.BadResponseError
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        if let followers = try? decoder.decode([Follower].self, from: data) {
            return followers
        } else {
            throw DDError.DecodingError
        }
        
    }
    
    func getUserInfo(for username: String) async throws -> User {
        let endpoint = baseURL + "/users/\(username)"
        guard let url = URL(string: endpoint) else {
            throw DDError.BADURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw DDError.BadResponseError
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        if let user = try? decoder.decode(User.self, from: data) {
            return user
        } else {
            throw DDError.DecodingError
        }
    }
    
    func image(url urlString: String) async throws -> UIImage {
        if let cachedEntry = await imageCache.cachedEntry(for: urlString) {
            switch cachedEntry {
            case .finished(let image):
                return image
            case .inProgress(let task):
                return try await task.value
            }
        }
        
        let task = Task {
            return try await self.downloadImage(url: urlString)
        }
        
        await imageCache.addTask(for: urlString, task: task)
        
        do {
            let image = try await task.value
            await imageCache.addImage(for: urlString, image: image)
            return image
        } catch {
            await imageCache.removeFailedTask(for: urlString)
            throw DDError.BadResponseError
        }
    }
    
    private func downloadImage(url urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw DDError.BADURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        if let image = UIImage(data: data) {
            return image
        } else {
            throw DDError.BADImage
        }
    }
    
}

actor ImageCache {
    
    enum CachedEntry {
        case finished(UIImage)
        case inProgress(Task<UIImage, Error>)
    }
    
    private var cache = [String: CachedEntry]()
    
    func cachedEntry(for url: String) -> CachedEntry? {
        return cache[url]
    }
    
    func addTask(for url: String, task: Task<UIImage, Error>) {
        cache[url] = .inProgress(task)
    }
    
    func addImage(for url: String, image: UIImage) {
        cache[url] = .finished(image)
    }
    
    func removeFailedTask(for url: String) {
        cache[url] = nil
    }
}
