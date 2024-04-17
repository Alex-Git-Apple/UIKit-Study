//
//  ViewController.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 1/30/24.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addItems()
    }
    
    func addItems() {
        let searchVC = SearchVC()
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let nv1 = UINavigationController(rootViewController: searchVC)
        
        let favoriteVC = FavoriteListVC()
        favoriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let nv2 = UINavigationController(rootViewController: favoriteVC)
        
        viewControllers = [nv1, nv2]
    }
    
}

