//
//  GFAlertContainerView.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 3/3/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class GFAlertContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor    = .systemBackground
        layer.cornerRadius = 16
        layer.borderWidth  = 2.0
        layer.borderColor  = UIColor.label.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
