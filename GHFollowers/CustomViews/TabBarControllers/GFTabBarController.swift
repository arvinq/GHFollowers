//
//  GFTabBarController.swift
//  GHFollowers
//
//  Created by Arvin Quiliza on 3/2/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //handle every tabBar in our whole app
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNavigationController(), createFavoritesNavigationController()]
    }

    func createSearchNavigationController() -> UINavigationController {
        let searchVC = SearchViewController()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoritesNavigationController() -> UINavigationController {
        let favoritesListVC = FavoritesListViewController()
        favoritesListVC.title = "Favorites"
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesListVC)
    }

}
