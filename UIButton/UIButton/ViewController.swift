//
//  ViewController.swift
//  UIButton
//
//  Created by Pin Lu on 11/8/23.
//

import UIKit

class ViewController: UIViewController {
    
    var button1: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        style()
        layout()
    }
    
    func setup() {
        let refreshAction = UIAction() { (action) in
            print("Refresh the data.")
        }
        button1 = UIButton(primaryAction: refreshAction)
        view.addSubview(button1)
    }
    
    func style() {
        var config = UIButton.Configuration.borderedTinted()
        config.titlePadding = 10
        config.cornerStyle = .capsule
        config.title = "Car"
        config.titleAlignment = .center
        config.subtitle = "A good subtitle"
        config.image = UIImage(systemName: "car", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        config.imagePlacement = .trailing
        config.buttonSize = .large
        
        button1.configuration = config
        
        button1.configurationUpdateHandler = { button in
          var config = button.configuration
          config?.image = button.isHighlighted ?
            UIImage(systemName: "car.fill") :
            UIImage(systemName: "car")
        
            config?.title = button.isHighlighted ?
            "Highlighted": "Car"
          button.configuration = config
        }
    }
    
    func layout() {
        button1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button1.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            button1.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}

