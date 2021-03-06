//
//  FollowerListViewController.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 2/16/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class FollowerListViewController: UIViewController {

    enum Section { case main }
    
    var username: String!
    var pageNumber: Int = 1
    var hasMoreFollowers: Bool = true
    var isSearching: Bool = false
    var isLoadingMoreFollowers: Bool = false
    
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    
    var addBarButton: UIBarButtonItem!
    var searchController: UISearchController!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    convenience init(user: User) {
        self.init()
        self.username = user.login
    }
    
    convenience init(username: String) {
        self.init()
        self.username = username
        title = username
    }
    
    init() { super.init(nibName: nil, bundle: nil) }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        getFollowers(forUsername: username, pageNumber: pageNumber)
        configureDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.setRightBarButton(addBarButton, animated: true)
        
        searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false //making search bar always appear
        navigationItem.searchController = searchController
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeItemCollectionView(on: view))
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
        collectionView.delegate = self
        view.addSubview(collectionView)
        
    }
    
    func getFollowers(forUsername username: String, pageNumber: Int) {
        showLoadingScreen()
        isLoadingMoreFollowers = true
        
        NetworkManager.shared.getFollowers(for: username, page: pageNumber) { [weak self] result in //capture list
            guard let self = self else { return }
            self.dismissLoadingScreen()
            
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false}
                self.followers.append(contentsOf: followers)
                
                // if followers is empty, we load the emptyState
                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers. Go follow them. 😊"
                    DispatchQueue.main.async { self.showEmptyStateView(withMessage: message, in: self.view) }
                    return
                }
                
                // call our search, in cases where the user has typed something, else,
                // it will just update the cv using followers in return part
                DispatchQueue.main.async { self.updateSearchResults(for: self.searchController) }
                
            case .failure(let errorMessage):
                self.presentGFAlertOnMainThread(title: "Bad Request", message: errorMessage.rawValue, buttonTitle: "Ok")
            }
            
            self.isLoadingMoreFollowers = false
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: {
            (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    @objc func addButtonTapped() {
        showLoadingScreen()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingScreen()
            
            switch result {
            case .success(let user) :
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                PersistenceManager.updateData(for: favorite, with: .add) { error in
                    guard error == nil else {
                        self.presentGFAlertOnMainThread(title: "Error saving user", message: error!.rawValue, buttonTitle: "Ok")
                        return
                    }
                    
                    self.presentGFAlertOnMainThread(title: "Successfully saved!", message: "Please view favorites tab to see your list of favorite profiles", buttonTitle: "Ok")
                }
                
            case .failure(let error) :
                self.presentGFAlertOnMainThread(title: "Error getting user", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

extension FollowerListViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.bounds.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            pageNumber += 1
            getFollowers(forUsername: username, pageNumber: pageNumber)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentFollowers = isSearching ? filteredFollowers : followers
        let follower = currentFollowers[indexPath.item]
        
        let userInfoVC = UserInfoViewController()
        userInfoVC.username = follower.login
        
        let tempNavigationController = UINavigationController(rootViewController: userInfoVC)
        present(tempNavigationController, animated: true)
    }
}

extension FollowerListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            return
        }
        
        isSearching = true
        filteredFollowers = followers.filter{ $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        filteredFollowers.removeAll()
        updateData(on: followers)
    }
}
