//
//  GFAlertViewController.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 2/16/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class GFAlertViewController: UIViewController {

    private var containerView: UIView!
    private var titleLabel: GFTitleLabel!
    private var bodyLabel: GFBodyLabel!
    private var actionButton: GFButton!
    
    private var alertTitle: String?
    private var bodyMessage: String?
    private var buttonTitle: String?
    
    private let subviewPadding: CGFloat = 20
    
    init(alertTitle: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle     = alertTitle
        self.bodyMessage    = message
        self.buttonTitle    = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        configureViews()
        configureConstraints()
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
    
    private func configureViews() {
        containerView                    = UIView()
        containerView.backgroundColor    = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth  = 2.0
        containerView.layer.borderColor  = UIColor.label.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        titleLabel      = GFTitleLabel(textAlignment: .center, fontSize: 20)
        titleLabel.text = alertTitle ?? "No Alert Title"
        containerView.addSubview(titleLabel)
        
        bodyLabel               = GFBodyLabel(textAlignment: .center)
        bodyLabel.text          = bodyMessage ?? "No message"
        bodyLabel.numberOfLines = 4
        containerView.addSubview(bodyLabel)
        
        actionButton = GFButton(backgroundColor: .systemPink, title: "Ok")
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        containerView.addSubview(actionButton)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            // containerView
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280.0),
            containerView.heightAnchor.constraint(equalToConstant: 220.0),
            
            // titleLabel
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: subviewPadding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: subviewPadding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -subviewPadding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            // bodyLabel
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: subviewPadding),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -subviewPadding),
            bodyLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -8),
            
            // actionButton
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -subviewPadding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: subviewPadding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -subviewPadding),
            actionButton.heightAnchor.constraint(equalToConstant: 44.0)
        ])
    }
}
