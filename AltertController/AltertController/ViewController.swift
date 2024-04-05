//
//  ViewController.swift
//  AltertController
//
//  Created by Pin Lu on 4/5/24.
//

import UIKit

class ViewController: UIViewController {
    let name = "VC"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let showSheetAction = UIAction(title: "Alert") { _ in
            self.showAlert()
        }
        let button = UIButton(primaryAction: showSheetAction)
        var configuration = UIButton.Configuration.borderedProminent()
        configuration.buttonSize = .large
        configuration.title = "Alert"
        button.configuration = configuration
        
        button.frame = CGRect(x: 130, y: 200, width: 150, height: 50)
        

        print(self.name)
        view.addSubview(button)
    }
    
    func showAlert() {
        let ac = UIAlertController()
        
        let option1Action = UIAlertAction(title: "Option 1", style: .default) { _ in
            // Handle Option 1 action
        }
        ac.addAction(option1Action)
        
        let option2Action = UIAlertAction(title: "Option 2", style: .default) { _ in
            // Handle Option 2 action
        }
        ac.addAction(option2Action)
        
        let option3Action = UIAlertAction(title: "Option 3", style: .destructive) { _ in
            // Handle Option 3 action
        }
        ac.addAction(option3Action)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cancelAction)

        
        present(ac, animated: true, completion: nil)
        
    }


}

@available(iOS 17.0, *)
#Preview {
    let vc = ViewController()
    return vc
}

