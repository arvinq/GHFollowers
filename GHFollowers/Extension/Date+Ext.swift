//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 3/1/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import Foundation

extension Date {
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
