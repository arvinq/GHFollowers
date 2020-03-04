//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 3/5/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

extension UITableView {
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
