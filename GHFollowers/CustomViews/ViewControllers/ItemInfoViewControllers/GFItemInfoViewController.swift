//
//  GFItemInfoViewController.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 3/1/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

protocol GFItemInfoVcDelegate: class {
    func didTappedGitHubProfile(on user: User)
    func didTappedGetFollowers(on user: User)
}

class GFItemInfoViewController: UIViewController {

    var stackView: UIStackView!
    var itemInfoViewOne: GFItemInfoView!
    var itemInfoViewTwo: GFItemInfoView!
    var actionButton: GFButton!
    
    var user: User!
    weak var itemInfoDelegate: GFItemInfoVcDelegate!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        configureConstraints()
    }

    
    private func configureViews() {
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 18
        
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        itemInfoViewOne = GFItemInfoView()
        stackView.addArrangedSubview(itemInfoViewOne)
        
        itemInfoViewTwo = GFItemInfoView()
        stackView.addArrangedSubview(itemInfoViewTwo)
        
        actionButton = GFButton()
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        view.addSubview(actionButton)
    }
    
    private func configureConstraints() {
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    // actionButtonTapped is being overriden by subclasses for own implementation hence empty
    @objc func actionButtonTapped() { }
}
