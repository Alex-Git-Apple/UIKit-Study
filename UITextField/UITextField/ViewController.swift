//
//  ViewController.swift
//  UITextField
//
//  Created by Pin Lu on 10/26/23.
//

import UIKit

class ViewController: UIViewController {
    
    let textField = UITextField(frame: .zero)
    let textField2 = UITextField(frame: .zero)
    let button = UIButton(type: .system)
    
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        style()
    }
    
    func style() {
        view.addSubview(textField)
        view.addSubview(textField2)
        view.addSubview(button)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Text Field 1."
        textField.borderStyle = .bezel
        textField.delegate = self
        textField.addTarget(self, action: #selector(contentDidChange), for: .editingChanged)
        
        textField2.translatesAutoresizingMaskIntoConstraints = false
        textField2.placeholder = "Text Field 2."
        textField2.borderStyle = .line
        textField2.delegate = self
        
        button.setTitle("Button", for: .normal)
        button.layer.borderWidth = 1.0
        button.backgroundColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        layout()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier:2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 2),
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            textField2.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier:2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: textField2.trailingAnchor, multiplier: 2),
            textField2.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 50),
            textField2.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: textField2.bottomAnchor, constant: 50),
            button.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    @objc func contentDidChange(_ sender: UITextField) {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { timer in
            print(sender.text ?? "Empty")
            timer.invalidate()
        })
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        print("A button tap would not change the first responder status.")
    }
}

extension ViewController: UITextFieldDelegate {
    // Invoked after resigning fisrt responder status.
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing.")
        print(textField.text ?? "Nothing")
    }
    
    // Called before 'textFieldDidEndEditing'. Defualt is YES.
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("Should end editing.")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
}

