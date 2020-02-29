//
//  GFFollowerItemInfoVC.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 3/1/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import Foundation

class GFFollowerItemInfoVC: GFItemInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        itemInfoViewOne.set(itemInfoType: .following, withCount: user.following)
        itemInfoViewTwo.set(itemInfoType: .follower, withCount: user.followers)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
}
