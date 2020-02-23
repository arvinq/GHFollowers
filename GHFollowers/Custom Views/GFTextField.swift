//
//  GFTextField.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 2/11/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius          = 10
        layer.borderWidth           = 2
        layer.borderColor           = UIColor.systemGray4.cgColor
        
        font                        = UIFont.preferredFont(forTextStyle: .title2)
        textColor                   = .label
        tintColor                   = .label
        textAlignment               = .center
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 12
        
        backgroundColor             = .tertiarySystemBackground
        autocorrectionType          = .no
        keyboardType                = .default
        returnKeyType               = .go
        placeholder                 = "Enter username"
        
    }

}
