//
//  BuyViewController.swift
//  CoordinatorPattern
//
//  Created by Pin Lu on 11/13/23.
//

import UIKit

class BuyViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Buy View"
        view.backgroundColor = .systemBackground
    }

}
