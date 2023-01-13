//
//  RepositoryCell+Item.swift
//  GithubAPI
//
//  Created by Ramazan Ceylan on 13.01.2023.
//

import Foundation

public extension RepositoryCell {
    struct Item {
        public let name : String
        public let description : String
        public let favoriteCount : String
        public let language : String
        public let openIssuesCount : String
        public let updatedDate : String
        
        public init(name: String,
                    description: String,
                    favoriteCount: String,
                    language: String,
                    openIssuesCount: String,
                    updatedDate: String) {
            self.name = name
            self.description = description
            self.favoriteCount = favoriteCount
            self.language = language
            self.openIssuesCount = openIssuesCount
            self.updatedDate = updatedDate
        }
    }
}
