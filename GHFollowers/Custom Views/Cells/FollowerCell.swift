//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 2/22/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let reuseId = "FollowerCall"
    
    private var avatarImage: GFAvatarImageView!
    private var usernameLabel: GFTitleLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
    }
    
    func configure() {
        avatarImage = GFAvatarImageView(frame: .zero)
        addSubview(avatarImage)
        
        usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
        addSubview(usernameLabel)
    }
    
    func configureConstraints() {
        
        let padding: CGFloat = 8.0
        
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImage.heightAnchor.constraint(equalTo: avatarImage.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

