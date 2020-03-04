//
//  GFBodyLabel.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 2/16/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class GFBodyLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    private func configure() {
        textColor                         = .secondaryLabel
        adjustsFontSizeToFitWidth         = true
        minimumScaleFactor                = 0.75
        lineBreakMode                     = .byWordWrapping
        font                              = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true // this and preferredFont combines for a successful dynamic type implementation
        translatesAutoresizingMaskIntoConstraints = false
    }
}
