//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 2/22/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {

    private var placeholderImage = UIImage(named: "avatar-placeholder")!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        layer.cornerRadius = 10
        clipsToBounds      = true
        image              = placeholderImage
        
        translatesAutoresizingMaskIntoConstraints = false
    }

}

