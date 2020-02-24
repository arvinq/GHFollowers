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
    
    var followers: [Follower] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        getFollowers()
        configureDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeItemCollectionView(on: view))
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
        view.addSubview(collectionView)
        
    }
    
    func getFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] result in //capture list
            guard let self = self else { return }
            
            switch result {
            case .success(let followers):
                self.followers = followers
                self.updateData()
            case .failure(let errorMessage):
                self.presentGFAlertOnMainThread(title: "Bad Request", message: errorMessage.rawValue, buttonTitle: "Ok")
            }
            
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
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
