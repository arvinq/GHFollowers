//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 2/19/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    let baseUrl = "https://api.github.com"
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void) {
        let followersPerPage = 100
        let endPoint = baseUrl + "/users/\(username)/followers?per_page=\(followersPerPage)&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                    return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                // decoder because we're receiving a data from the server
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let followers = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
