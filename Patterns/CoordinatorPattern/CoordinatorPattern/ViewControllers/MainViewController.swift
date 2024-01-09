//
//  ViewController.swift
//  CoordinatorPattern
//
//  Created by Pin Lu on 11/13/23.
//

import UIKit

protocol MainViewControllerDelegate: AnyObject {
    
    func buySubscription()
    
    func createAccount()
    
}

class MainViewController: UIViewController {
    
    weak var delegate: MainViewControllerDelegate?
    
    let creatAccountButton = UIButton(type: .contactAdd)
    let buyButton = UIButton(type: .detailDisclosure)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        style()
        layout()
    }
    
    func setup() {
        title = "The Main View"
        
        view.addSubview(buyButton)
        view.addSubview(creatAccountButton)
    }
    
    func style() {
        view.backgroundColor = .systemBackground
        
        var config = UIButton.Configuration.filled()
        config.title = "Create Account"
        creatAccountButton.configuration = config
        creatAccountButton.addTarget(self, action: #selector(createAccount), for: .primaryActionTriggered)
        
        
        config = UIButton.Configuration.bordered()
        config.title = "Buy"
        buyButton.configuration = config
        buyButton.addTarget(self, action: #selector(buyTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        creatAccountButton.translatesAutoresizingMaskIntoConstraints = false
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            creatAccountButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            creatAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            buyButton.topAnchor.constraint(equalTo: creatAccountButton.topAnchor, constant: 100),
            buyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func buyTapped(_ sender: Any) {
        delegate?.buySubscription()
    }

    @objc func createAccount(_ sender: Any) {
        delegate?.createAccount()
    }

}

