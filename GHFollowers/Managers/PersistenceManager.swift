//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 3/1/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import Foundation

enum Key {
    static let favorites = "favorites"
}

enum PersistenceActionType {
    case add, remove
}

struct PersistenceManager {
    private static let defaults = UserDefaults.standard
    
    static func updateData(for favorite: Follower, with actionType: PersistenceActionType, completion: @escaping (GFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites) :
                var savedFavorites = favorites
                
                switch actionType {
                case .add:
                    if savedFavorites.contains(favorite) {
                        completion(.alreadySaved)
                        return
                    }
                    
                    savedFavorites.append(favorite)
                    
                case .remove:
                    savedFavorites.removeAll { $0.login == favorite.login }
                }
                
                completion(save(favorites: savedFavorites))
                
            case .failure(let error) :
                completion(error)
            }
        }
    }
    
    static func retrieveFavorites(completion: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Key.favorites) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completion(.success(favorites))
        } catch {
            completion(.failure(.corruptData))
        }
    }
    
    static func save(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let favoritesData = try encoder.encode(favorites)
            defaults.set(favoritesData, forKey: Key.favorites)
        } catch {
            return .saveError
        }
        
        return nil
    }
}
