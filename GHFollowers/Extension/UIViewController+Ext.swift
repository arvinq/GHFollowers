//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 2/16/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit
import SafariServices

fileprivate var loadingContainerView: UIView!

extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertViewController(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func showLoadingScreen() {
        loadingContainerView = UIView(frame: view.bounds)
        loadingContainerView.backgroundColor = .systemBackground
        loadingContainerView.alpha = 0
        view.addSubview(loadingContainerView)
        
        UIView.animate(withDuration: 0.35) { loadingContainerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingContainerView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: loadingContainerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loadingContainerView.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingScreen() {
        DispatchQueue.main.async {
            loadingContainerView.removeFromSuperview()
            loadingContainerView = nil
        }
    }
    
    func showEmptyStateView(withMessage message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
    func showSafariWebView(on url: URL) {
        let safariWebView = SFSafariViewController(url: url)
        safariWebView.preferredControlTintColor = .systemGreen
        present(safariWebView, animated: true)
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}
