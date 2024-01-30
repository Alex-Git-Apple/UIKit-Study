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

class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com"
    
    private init() { }
    
    func getFollowers(for username: String, page: Int) async throws -> [Follower] {
        let endpoint = baseURL + "/users/\(username)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else {
            throw DDError.BADURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
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
    
    func downloadImage(url urlSring: String) async throws -> UIImage {
        guard let url = URL(string: urlSring) else {
            throw DDError.BADURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw DDError.BADImage
            }
        } catch {
            throw DDError.BadResponseError
        }
    }
    
}
