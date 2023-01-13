//
//  RepositoryViewModel.swift
//  GithubAPI
//
//  Created by Ramazan Ceylan on 13.01.2023.
//

import Foundation

public final class RepositoryViewModel {
    
    private var apiService = APIService()
    private(set) var repositories = [Repository]()
    
    func fetchRepositories(completion: @escaping () -> ()) {
            
            // weak self - prevent retain cycles
        apiService.getRepositories { [weak self] (result) in
                
                switch result {
                case .success(let response):
                    self?.repositories = response
                    completion()
                case .failure(let error):
                    // Something is wrong with the JSON file or the model
                    print("Error processing json data: \(error)")
                }
            }
        }
}
