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
        decoder.dateDecodingStrategy = .iso8601
        if let user = try? decoder.decode(User.self, from: data) {
            return user
        } else {
            throw DDError.DecodingError
        }
    }
    
    
    func downloadImage(_ urlString: String) async throws -> UIImage {
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
