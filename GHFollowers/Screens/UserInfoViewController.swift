//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 2/27/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {

    var username: String!
    var doneButton: UIBarButtonItem!
    
    //scrollView and contentView
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
    // ChildVC containers
    private var headerView: UIView          = UIView()
    private var itemViewProfile: UIView     = UIView()
    private var itemViewFollower: UIView    = UIView()
    private var dateLabel: GFBodyLabel      = GFBodyLabel(textAlignment: .center)
    private var itemViews: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        getUserInfo()
    }

    func configureViews() {
        view.backgroundColor = .systemBackground
        
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        navigationItem.setLeftBarButton(doneButton, animated: true)
        
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        contentView = UIView()
        scrollView.addSubview(contentView)
        
        itemViews.append(contentsOf: [headerView, itemViewProfile, itemViewFollower, dateLabel])
        for itemView in itemViews {
            itemView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(itemView)
        }
    }
    
    func configureConstraints() {
        let padding: CGFloat = 20.0
        let itemHeight: CGFloat = 140.0
        
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        // Configuring the leading and trailing constraints of the itemViews
        for itemView in itemViews {
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            // we need to set contentView's width and height in addition to pinning it
            // to scrollView's edges so that we can make it movable inside scrollView.
            // This will greatly take into effect should our content becomes large enough.
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 650),
            
            headerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewProfile.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewProfile.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewFollower.topAnchor.constraint(equalTo: itemViewProfile.bottomAnchor, constant: padding),
            itemViewFollower.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewFollower.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureItemInfo(for: user) }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Request", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureItemInfo(for user: User) {
        self.add(childVC: GFUserInfoHeaderViewController(user: user), to: self.headerView)
        self.add(childVC: GFRepoItemInfoVC(user: user, delegate: self), to: self.itemViewProfile)
        self.add(childVC: GFFollowerItemInfoVC(user: user, delegate: self), to: self.itemViewFollower)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToString())"
        //since we have now changed createdAt to Date we are just converting the date to string
    }
    
    @objc func donePressed() {
        dismiss(animated: true)
    }
}

extension UserInfoViewController: GitHubProfileTappable {
    func didTappedGitHubProfile(on user: User) {
       guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "URL Issue", message: "User doesn't have a valid viewable profile", buttonTitle: "Ok")
            return
        }
        
        showSafariWebView(on: url)
    }
}

extension UserInfoViewController: GitHubFollowersTappable {
    func didTappedGetFollowers(on user: User) {
        let followerListVC = FollowerListViewController(user: user)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        followerListVC.navigationItem.setLeftBarButton(doneButton, animated: true)
        followerListVC.navigationItem.title = user.login
        
        let navigationController = UINavigationController(rootViewController: followerListVC)
        
        present(navigationController, animated: true)
    }
}
