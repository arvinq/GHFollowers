//
//  SearchViewController.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 2/10/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    private var logoImageView           : UIImageView!
    private var usernameTextField       : GFTextField!
    private var fetchFollowersButton    : GFButton!
    
    private var logoImageViewTopConstraint: NSLayoutConstraint!
    
    private var isUsernameEntered: Bool { return !usernameTextField.text!.isEmpty }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureViews()
        configureConstraints()
        configureGestureKeyboardDismiss()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func configureGestureKeyboardDismiss() {
        // we use self.view as target instead of self because the view has the method and not the viewController.
        // if we have an @objc function called in our action, we can have a target of self
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func pushToFollowerListViewController() {
        usernameTextField.resignFirstResponder()
        
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for. 😀", buttonTitle: "Ok")
            return
        }
        
        let followerListVC      = FollowerListViewController()
        followerListVC.username = usernameTextField.text
        followerListVC.title    = usernameTextField.text
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    private func configureViews() {
        logoImageView = UIImageView()
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        usernameTextField = GFTextField()
        usernameTextField.delegate = self
        view.addSubview(usernameTextField)
        
        fetchFollowersButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
        fetchFollowersButton.addTarget(self, action: #selector(pushToFollowerListViewController), for: .touchUpInside)
        view.addSubview(fetchFollowersButton)
    }
    
    private func configureConstraints() {
        logoImageViewTopConstraint = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        logoImageViewTopConstraint.constant = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        
        NSLayoutConstraint.activate([
            // logoImageView
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageViewTopConstraint,
            
            // usernameTextField
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // fetchFollowersButton
            fetchFollowersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            fetchFollowersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            fetchFollowersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            fetchFollowersButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushToFollowerListViewController()
        return true
    }
}
