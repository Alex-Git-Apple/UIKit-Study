//
//  NetworkManager.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 1/30/24.
//

import Foundation

enum DDError: String, Error {
    case BadResponseError
    case DecodingError
    case BADURL
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
    
}
