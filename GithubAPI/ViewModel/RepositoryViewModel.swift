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
    public var resultList = [Repository]()
    public var filteredList = [Repository]()
    public var languageArray = [String]()
    
    public var scopeButtonTitles: [String] {
        languageArray.insert("All", at: 0)
        return languageArray
    }
    
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
        setupLanguageArray()
    }
    
    func setupLanguageArray() {
        languageArray = []
        for repository in resultList {
            guard let language = repository.language else {return}
            languageArray.append(language)
            languageArray = languageArray.unique(source: languageArray)
        }
    }
    
    func previousButtonClicked() {
        currentPage -= 1
        resultList = []
        filteredList = []
        resultList = chunkedListArray[currentPage]
        setupLanguageArray()
    }
    
    func nextButtonClicked() {
        currentPage += 1
        resultList = []
        filteredList = []
        resultList = chunkedListArray[currentPage]
        setupLanguageArray()
    }
}
