//
//  ViewController.swift
//  UIButton
//
//  Created by Pin Lu on 11/8/23.
//

import UIKit

class ViewController: UIViewController {
    
    var button1: UIButton!
    
    var button2: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupButton1()
        setupButton2()
        layout()
    }
    
    func setupButton1() {
        setup()
        style()
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
    
    // Button with UIMenu
    func setupButton2() {
        button2 = UIButton(type: .system)
        var config = UIButton.Configuration.bordered()
        config.title = "Menu Button"
        config.buttonSize = .large
        
        button2.configuration = config
        
        view.addSubview(button2)
        
        // Create the menu items
        let shareAction = UIAction(title: "Share", handler: { _ in
          // Share functionality here
            self.button2.configuration?.title = "Share"
        })
        let deleteAction = UIAction(title: "Delete") { action in
          // Delete functionality here
            self.button2.configuration?.title = "Delete"
        }

        // Create the menu
        let menu = UIMenu(title: "Options", options: .displayInline, children: [shareAction, deleteAction])

        // Set the menu on the button and enable primary action
        button2.menu = menu
        button2.showsMenuAsPrimaryAction = true
    }
    
    func layout() {
        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button1.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            button1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button2.topAnchor.constraint(equalToSystemSpacingBelow: button1.bottomAnchor, multiplier: 5),
            button2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

}

