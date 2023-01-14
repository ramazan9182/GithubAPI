//
//  RepositoryViewModel.swift
//  GithubAPI
//
//  Created by Ramazan Ceylan on 13.01.2023.
//

import Foundation

public final class RepositoryViewModel {
    
    private var apiService = APIService()
    private var repositoryArray = [Repository]()
    private(set) var chunkedListArray = [[Repository]]()
    public var currentPage : Int = 0
    private var listLimit : Int = 10
    public var numberOfPages : Int?
    private(set) var resultList = [Repository]()
    
    func fetchRepositories(completion: @escaping () -> ()) {
        apiService.getRepositories { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.repositoryArray = response
                self?.setupPage(repositories: response)
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func setupPage(repositories: [Repository]) {
        chunkedListArray =  repositories.chunked(into: listLimit)
        numberOfPages = chunkedListArray.count
        resultList = chunkedListArray[0]
    }
    
    func previousButtonClicked() {
        currentPage -= 1
        resultList = chunkedListArray[currentPage]
    }
    
    func nextButtonClicked() {
        currentPage += 1
        resultList = chunkedListArray[currentPage]
    }
}
