//
//  Repository.swift
//  GithubAPI
//
//  Created by Ramazan Ceylan on 13.01.2023.
//

import Foundation

public struct Repository: Codable {
    public let name: String?
    public let description: String?
    public let favoriteCount: Int?
    public let language: String?
    public let openIssuesCount: Int?
    public let updatedDate: String?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case description
        case favoriteCount = "stargazers_count"
        case language
        case openIssuesCount = "open_issues_count"
        case updatedDate = "updated_at"
    }
}
