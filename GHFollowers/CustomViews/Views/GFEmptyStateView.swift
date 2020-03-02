//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 2/26/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView {

    var messageLabel: GFTitleLabel!
    var imageContainer: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    func configure() {
        backgroundColor = .systemBackground
        
        messageLabel                = GFTitleLabel(textAlignment: .center, fontSize: 28)
        messageLabel.textColor      = .secondaryLabel
        messageLabel.numberOfLines  = 3
        addSubview(messageLabel)
        
        imageContainer          = UIImageView()
        imageContainer.image    = Images.emptyStateLogo
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageContainer)
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            imageContainer.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            imageContainer.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            imageContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 180),
            imageContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
        ])
    }
}
