//
//  APIService.swift
//  GithubAPI
//
//  Created by Ramazan Ceylan on 13.01.2023.
//

import Foundation

class APIService {
    
    private var dataTask: URLSessionDataTask?
    
    func getRepositories(completion: @escaping (Result<[Repository], Error>) -> Void) {
        
        guard let url = URL(string: "https://api.github.com/orgs/google/repos") else { return}
        
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Repository].self, from: data)
                
                // Back to the main thread
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
}
