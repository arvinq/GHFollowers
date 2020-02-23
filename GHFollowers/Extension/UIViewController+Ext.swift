//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 2/16/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertViewController(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
