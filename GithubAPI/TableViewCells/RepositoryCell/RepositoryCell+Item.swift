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
        
        public init(name: String,
                    description: String) {
            self.name = name
            self.description = description
        }
    }
}
