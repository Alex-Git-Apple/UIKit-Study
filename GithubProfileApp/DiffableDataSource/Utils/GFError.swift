//
//  GFError.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 4/16/24.
//

import Foundation

enum GFError: String, Error {
    case invalidData = "The data received from server ws invalid"
    case unableToFavorite = "There was an error favoriting this user."
    case unableToDecode = "There was an error decoding the data."
    case alreadyInFavortes = "You've already favorited this user."
}
