//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 3/1/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit


class GFItemInfoView: UIView {
    
    var symbolImageView: UIImageView!
    var titleLabel: GFTitleLabel!
    var countLabel: GFTitleLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        symbolImageView = UIImageView()
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.tintColor = .label
        self.addSubview(symbolImageView)
        
        titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
        self.addSubview(titleLabel)
        
        countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
        self.addSubview(countLabel)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
            case .repos:
                symbolImageView.image = SFSymbols.repos
            case .gists:
                symbolImageView.image = SFSymbols.gists
            case .follower:
                symbolImageView.image = SFSymbols.follower
            case .following:
                symbolImageView.image = SFSymbols.following
        }
        
        titleLabel.text = itemInfoType.rawValue
        countLabel.text = String(count)
    }
}
