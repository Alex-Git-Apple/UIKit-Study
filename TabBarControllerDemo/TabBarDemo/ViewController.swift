//
//  ViewController.swift
//  TabBarDemo
//
//  Created by Pin Lu on 11/9/23.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .systemBackground
        
        let vc1 = SearchViewController()
        let vc2 = ContactsViewController()
        let vc3 = FavoritesViewController()
        let vc4 = CarViewController()
        
//        vc1.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
//        vc2.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
//        vc3.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
//        vc4.tabBarItem = UITabBarItem(title: "car", image: UIImage(systemName: "car"), tag: 4)
        
        let nc1 = UINavigationController(rootViewController: vc1)
        let nc2 = UINavigationController(rootViewController: vc2)
        let nc3 = UINavigationController(rootViewController: vc3)
        let nc4 = UINavigationController(rootViewController: vc4)
        
        // Assigning the tabBarItem to vc or nc makes no difference.
        nc1.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        nc2.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        nc3.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        nc4.tabBarItem = UITabBarItem(title: "car", image: UIImage(systemName: "car"), tag: 4)
        
        self.viewControllers = [nc1, nc2, nc3, nc4]
    }

}

class SearchViewController: UIViewController {
    let button = UIButton(type: .system)
    
    override func viewDidLoad() {
        title = "Search"
        setup()
        style()
        layout()
    }
    
    func setup() {
        view.addSubview(button)
        button.addTarget(self, action: #selector(pushAVC), for: .primaryActionTriggered)
    }
    
    func style() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.title = "Push"
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func pushAVC() {
        navigationController?.pushViewController(ColorViewController(), animated: true)
    }
}

class ContactsViewController: UIViewController {
    override func viewDidLoad() {
        title = "Contacts"
    }
}

class FavoritesViewController: UIViewController {
    override func viewDidLoad() {
        title = "Favorites"
    }
}

class CarViewController: UIViewController {
    override func viewDidLoad() {
        title = "Car"
    }
}

class ColorViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .orange
    }
}

