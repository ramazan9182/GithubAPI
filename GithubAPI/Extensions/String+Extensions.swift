//
//  String+Extensions.swift
//  GithubAPI
//
//  Created by Ramazan Ceylan on 14.01.2023.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
