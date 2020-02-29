//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 2/27/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {

    var username: String!
    var doneButton: UIBarButtonItem!
    
    // ChildVC containers
    private var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        getUserInfo()
    }

    func configureViews() {
        view.backgroundColor = .systemBackground
        
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        navigationItem.setRightBarButton(doneButton, animated: true)
        
        headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderViewController(user: user), to: self.headerView)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Request", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    @objc func donePressed() {
        dismiss(animated: true)
    }
}
