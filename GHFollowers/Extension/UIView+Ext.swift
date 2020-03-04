//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 3/3/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

extension UIView {
    
    /// implement convenience method of adding subviews to parent
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    /// pinning the edges of the implementing view to its superview
    func pinToEdges(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        ])
    }
    
}
