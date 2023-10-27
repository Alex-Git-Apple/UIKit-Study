//
//  ViewController.swift
//  UITextField
//
//  Created by Pin Lu on 10/26/23.
//

import UIKit

class ViewController: UIViewController {
    
    let textField = UITextField(frame: .zero)
    
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUp()
    }
    
    func setUp() {
        view.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Welcome to type."
        textField.delegate = self
        textField.addTarget(self, action: #selector(contentDidChange), for: .editingChanged)
        
        layout()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier:2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 2),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 1)
        ])
    }
    
    @objc func contentDidChange(_ sender: UITextField) {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { timer in
            print(sender.text ?? "Empty")
            timer.invalidate()
        })
    }
}

extension ViewController: UITextFieldDelegate {
    // Invoked after resigning fisrt responder status.
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text ?? "Nothing")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

