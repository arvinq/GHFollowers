//
//  GFUserInfoHeaderViewController.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 2/29/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class GFUserInfoHeaderViewController: UIViewController {

    var user: User!
    var avatarImageView: GFAvatarImageView!
    var usernameLabel: GFTitleLabel!
    var nameLabel: GFSecondaryTitleLabel!
    var locationImageView: UIImageView!
    var locationLabel: GFSecondaryTitleLabel!
    var bioLabel: GFBodyLabel!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
    }
    
    func configureViews() {
        avatarImageView = GFAvatarImageView(frame: .zero)
        avatarImageView.downloadImage(from: user.avatarUrl)
        view.addSubview(avatarImageView)
        
        usernameLabel       = GFTitleLabel(textAlignment: .left, fontSize: 34)
        usernameLabel.text  = user.login
        view.addSubview(usernameLabel)
        
        nameLabel       = GFSecondaryTitleLabel(fontSize: 18)
        nameLabel.text  = user.name ?? ""
        view.addSubview(nameLabel)
        
        locationImageView           = UIImageView()
        locationImageView.image     = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationImageView)
        
        locationLabel       = GFSecondaryTitleLabel(fontSize: 18)
        locationLabel.text  = user.location ?? "Not location included"
        view.addSubview(locationLabel)
        
        bioLabel                = GFBodyLabel(textAlignment: .left)
        bioLabel.numberOfLines  = 3
        bioLabel.text           = user.bio ?? "No bio available"
        view.addSubview(bioLabel)
    }

    func configureConstraints() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}