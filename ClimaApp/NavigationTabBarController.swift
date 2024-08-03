//
//  NavigationTabBarController.swift
//  ClimaApp
//
//  Created by Diplomado on 03/08/24.
//

import UIKit
import SwiftUI

class NavigationTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        // Vista 1 - Banderas
        let locationsTableViewController = UIHostingController(rootView: ContentView())
        
        locationsTableViewController.tabBarItem.title = "Cities"
        locationsTableViewController.tabBarItem.image = UIImage(systemName: "mappin.circle")
        let locationNavigationController = UINavigationController(rootViewController: locationsTableViewController)
        
        // Vista 2 - Favoritos
        let favoriteCollectionViewController = FavoritesViewController()
        favoriteCollectionViewController.tabBarItem.title = "Favorites"
        favoriteCollectionViewController.tabBarItem.image = UIImage(systemName: "star")
        let favoriteNavigationController = UINavigationController(rootViewController: favoriteCollectionViewController)
        
        viewControllers = [
            locationNavigationController,
            favoriteNavigationController,
        ]
    }
}
