//
//  CreateAccountViewController.swift
//  CoordinatorPattern
//
//  Created by Pin Lu on 11/13/23.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Create Account View"
        view.backgroundColor = .systemBackground
    }

}
