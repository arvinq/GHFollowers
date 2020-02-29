//
//  GFRepoItemInfoVC.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 3/1/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import Foundation

class GFRepoItemInfoVC: GFItemInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
}
