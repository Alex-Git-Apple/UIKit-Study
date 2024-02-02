//
//  User.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 1/30/24.
//

import Foundation

struct User: Codable {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var createdAt: String
}
