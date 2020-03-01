//
//  GFRepoItemInfoVC.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 3/1/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import Foundation

protocol GitHubProfileTappable: class {
    func didTappedGitHubProfile(on user: User)
}

class GFRepoItemInfoVC: GFItemInfoViewController {
    
    weak var delegate: GitHubProfileTappable?
    
    init(user: User, delegate: GitHubProfileTappable? = nil) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    override func actionButtonTapped() {
        delegate?.didTappedGitHubProfile(on: user)
    }
}
