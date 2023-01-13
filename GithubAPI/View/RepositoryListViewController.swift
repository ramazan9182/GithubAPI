//
//  RepositoryListViewController.swift
//  GithubAPI
//
//  Created by Ramazan Ceylan on 13.01.2023.
//

import UIKit

class RepositoryListViewController: UIViewController {
    
    private var viewModel = RepositoryViewModel()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        loadRepositoriesDta()
    }
    
    private func loadRepositoriesDta() {
        viewModel.fetchRepositories { [weak self] in
            self?.configureTableView()
            self?.tableView.reloadData()
        }
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: RepositoryCell.identifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension RepositoryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.identifier, for: indexPath) as! RepositoryCell
        cell.configure(item: RepositoryCell.Item(name: viewModel.repositories[indexPath.row].name ?? "",
                                                 description: viewModel.repositories[indexPath.row].description ?? "",
                                                 favoriteCount: String(viewModel.repositories[indexPath.row].favoriteCount ?? 1),
                                                 language: viewModel.repositories[indexPath.row].language ?? "",
                                                 openIssuesCount: String(viewModel.repositories[indexPath.row].openIssuesCount ?? 1),
                                                 updatedDate: viewModel.repositories[indexPath.row].updatedDate ?? ""))
        return cell
    }
}

