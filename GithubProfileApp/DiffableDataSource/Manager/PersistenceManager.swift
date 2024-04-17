//
//  PersistentManager.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 4/16/24.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

actor PersistenceManager {
    
    static private let defualts = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func retrieveFavorites() throws -> [Follower] {
        guard let favoritesData = defualts.object(forKey: Keys.favorites) as? Data else {
            return []
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Follower].self, from: favoritesData)
        } catch {
            throw GFError.unableToDecode
        }
    }
    
    static func saveFavorites(favorites: [Follower]) throws {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defualts.setValue(encodedFavorites, forKey: Keys.favorites)
        } catch {
            throw GFError.unableToFavorite
        }
    }
    
    static func update(with favorite: Follower, actionType: PersistenceActionType) throws {
        var favorites = try retrieveFavorites()
        switch actionType {
        case .add:
            guard !favorites.contains(favorite) else {
                throw GFError.alreadyInFavortes
            }
            favorites.append(favorite)
        case .remove:
            favorites.removeAll { $0.login == favorite.login }
        }
        
        try saveFavorites(favorites: favorites)
    }
    
}
