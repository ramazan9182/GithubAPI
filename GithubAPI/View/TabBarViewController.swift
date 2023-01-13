//
//  TabBarViewController.swift
//  GithubAPI
//
//  Created by Ramazan Ceylan on 13.01.2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupVCs()
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
    
    @available(iOS 13.0, *)
    func setupVCs() {
        viewControllers = [
            createNavController(for: RepositoryListViewController(), title: NSLocalizedString("FavouriteList", comment: ""), image: UIImage(systemName: "magnifyingglass")!),
            createNavController(for: FavouriteRepositoryListViewController(), title: NSLocalizedString("RepositoryList", comment: ""), image: UIImage(systemName: "house")!),
            createNavController(for: SearchRepositoryViewController(), title: NSLocalizedString("Search", comment: ""), image: UIImage(systemName: "magnifyingglass")!)
        ]
    }
}
