//
//  FavoritesListViewController.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 2/10/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class FavoritesListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBlue
        
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case .success(let followers):
                print(followers)
            case .failure(let error):
                break
            }
        }
    }

}
