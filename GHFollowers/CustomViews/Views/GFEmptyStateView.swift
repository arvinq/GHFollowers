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
    var messageLabelCenterYConstraint: NSLayoutConstraint!
    var imageContainerBottomConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    func configureViews() {
        backgroundColor = .systemBackground
        
        messageLabel                = GFTitleLabel(textAlignment: .center, fontSize: 28)
        messageLabel.textColor      = .secondaryLabel
        messageLabel.numberOfLines  = 3
        
        imageContainer          = UIImageView()
        imageContainer.image    = Images.emptyStateLogo
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(messageLabel, imageContainer)
    }
    
    func configureConstraints() {
        messageLabelCenterYConstraint = messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        messageLabelCenterYConstraint.constant = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -80 : -150
        
        imageContainerBottomConstraint = imageContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        imageContainerBottomConstraint.constant = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 80 : 40
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            messageLabelCenterYConstraint,
            
            imageContainer.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            imageContainer.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            imageContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 180),
            imageContainerBottomConstraint
            
        ])
    }
    
}
