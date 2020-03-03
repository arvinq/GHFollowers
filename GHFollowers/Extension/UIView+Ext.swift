//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 3/3/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

extension UIView {
    
    // implement convenience method of adding subviews to parent
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
}
