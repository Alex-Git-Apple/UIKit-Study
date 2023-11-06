//
//  ViewController.swift
//  CustomView
//
//  Created by Pin Lu on 11/3/23.
//

import UIKit

class ViewController: UIViewController {
    
    var child: CustomView!
    var banner: CustomView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUp()
        style()
        layout()
    }
    
    func setUp() {
        child = CustomView(height: 200, width: 200)
        view.addSubview(child)
        banner = CustomView(height: 100, width: 200)
        view.addSubview(banner)
    }
    
    func style() {
        child.layer.borderWidth = 1
    }
    
    func layout() {
        child.translatesAutoresizingMaskIntoConstraints = false
        banner.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            child.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            child.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            banner.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            banner.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

