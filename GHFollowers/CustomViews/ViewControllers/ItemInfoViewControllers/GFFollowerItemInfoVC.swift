//
//  GFFollowerItemInfoVC.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 3/1/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import Foundation

protocol GitHubFollowersTappable: class {
    func didTappedGetFollowers(on user: User)
}
class GFFollowerItemInfoVC: GFItemInfoViewController {
    
    weak var delegate: GitHubFollowersTappable?
    
    init(user: User, delegate: GitHubFollowersTappable? = nil) {
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
        itemInfoViewOne.set(itemInfoType: .following, withCount: user.following)
        itemInfoViewTwo.set(itemInfoType: .follower, withCount: user.followers)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate?.didTappedGetFollowers(on: user)
    }
}
