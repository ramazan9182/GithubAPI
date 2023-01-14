//
//  RepositoryListViewController.swift
//  GithubAPI
//
//  Created by Ramazan Ceylan on 13.01.2023.
//

import UIKit

class RepositoryListViewController: UIViewController {
    
    private var viewModel = RepositoryViewModel()
    private let searchController = UISearchController()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 60
        return tableView
    }()
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.mainPink, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pc
    }()
    
    private var bottomControlsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(bottomControlsStackView)
        previousButton.addTarget(self, action: #selector(previousButtonAction), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        configureSortButton()
        configureTableView()
        setupBottomControls()
        loadRepositoriesDta()
        
    }
    
    private func loadRepositoriesDta() {
        viewModel.fetchRepositories { [weak self] in
            self?.initSearchController()
            self?.pageControl.currentPage = self?.viewModel.currentPage ?? 0
            self?.pageControl.numberOfPages = self?.viewModel.numberOfPages ?? 0
            self?.tableView.reloadData()
        }
    }
    
    private func configureSortButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "A-Z", style: .plain, target: self, action: #selector(sortButtonTapped))
    }
    
    private func initSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.scopeButtonTitles = viewModel.scopeButtonTitles
        searchController.searchBar.delegate = self
    }
    
    func configureTableView() {
        setTableViewDelegates()
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: RepositoryCell.identifier)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomControlsStackView.topAnchor).isActive = true
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupBottomControls() {
        bottomControlsStackView.addArrangedSubview(previousButton)
        bottomControlsStackView.addArrangedSubview(pageControl)
        bottomControlsStackView.addArrangedSubview(nextButton)
        bottomControlsStackView.distribution = .fillEqually
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    @objc private func previousButtonAction(sender: UIButton!) {
        guard viewModel.currentPage != 0 else {return}
        viewModel.previousButtonClicked()
        updateSearchResults(for: searchController)
        searchController.searchBar.scopeButtonTitles = viewModel.scopeButtonTitles
        pageControl.currentPage = viewModel.currentPage
        tableView.reloadData()
    }
    
    @objc private func nextButtonAction(sender: UIButton!) {
        guard viewModel.currentPage != (viewModel.chunkedListArray.count - 1) else {return}
        viewModel.nextButtonClicked()
        updateSearchResults(for: searchController)
        searchController.searchBar.scopeButtonTitles = viewModel.scopeButtonTitles
        pageControl.currentPage = viewModel.currentPage
        tableView.reloadData()
    }
    
    @objc private func sortButtonTapped(sender: UIButton!) {
        viewModel.resultList = viewModel.resultList.sorted(by: {$0.name.map({$0.trimmingCharacters(in: .whitespaces)}) ?? "" < $1.name ?? ""})
        viewModel.filteredList = viewModel.filteredList.sorted(by: {$0.name.map({$0.trimmingCharacters(in: .whitespaces)}) ?? "" < $1.name ?? ""})
        tableView.reloadData()
    }
    
}

extension RepositoryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searchController.isActive)
        {
            return viewModel.filteredList.count
        }
        return viewModel.resultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.identifier, for: indexPath) as! RepositoryCell
        
        let thisShape: Repository!
        if(searchController.isActive)
        {
            thisShape = viewModel.filteredList[indexPath.row]
        }
        else
        {
            thisShape = viewModel.resultList[indexPath.row]
        }
        cell.configure(item: RepositoryCell.Item(name: thisShape.name ?? "",
                                                 description: thisShape.description ?? ""))
        return cell
    }
}

extension RepositoryListViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        filterForSearchTextAndScopeButton(searchText: searchText, scopeButton: scopeButton)
    }
    
    func filterForSearchTextAndScopeButton(searchText: String, scopeButton : String = "All") {
        var tempArray = viewModel.resultList.filter{($0.language == scopeButton)}
        
        tempArray = tempArray.isEmpty ? viewModel.resultList : tempArray
        
        viewModel.filteredList = tempArray.filter({ repository in
            if(searchController.searchBar.text != "") {
                guard let name = repository.name else {return false}
                let searchTextMatch = name.lowercased().contains(searchText.lowercased())
                return searchTextMatch
            } else {
                return true
            }
        })
        tableView.reloadData()
    }
    
}

