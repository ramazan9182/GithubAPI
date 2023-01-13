//
//  RepositoryListViewController.swift
//  GithubAPI
//
//  Created by Ramazan Ceylan on 13.01.2023.
//

import UIKit

class RepositoryListViewController: UIViewController {
    
    private var viewModel = RepositoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        viewModel.fetchRepositories {
            print("deneme")
        }
    }
    
}

