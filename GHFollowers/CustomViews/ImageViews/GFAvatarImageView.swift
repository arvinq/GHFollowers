//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 2/22/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {

    private var placeholderImage = Images.placeholder
        
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

    func downloadImage(from urlString: String) {
        NetworkManager.shared.downloadImage(from: urlString) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
}

