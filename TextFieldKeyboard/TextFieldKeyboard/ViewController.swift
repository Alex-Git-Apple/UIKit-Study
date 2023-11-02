//
//  ViewController.swift
//  TextFieldKeyboard
//
//  Created by Pin Lu on 10/28/23.
//

import UIKit

class ViewController: UIViewController {
    let textField = UITextField(frame: .zero)
    let textField2 = UITextField(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUp()
        style()
        layout()
    }
    
    func setUp() {
        setUpKeyboardHidding()
        setUpDismissKeyboard()
    }
    
    func style() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Text Field 1."
        textField.borderStyle = .bezel
        textField.delegate = self
        
        textField2.translatesAutoresizingMaskIntoConstraints = false
        textField2.placeholder = "Text Field 2."
        textField2.borderStyle = .line
        textField2.delegate = self
    }
    
    func layout() {
        view.addSubview(textField)
        view.addSubview(textField2)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier:2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 2),
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            textField2.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier:2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: textField2.trailingAnchor, multiplier: 2),
            textField2.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 300),
            textField2.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setUpKeyboardHidding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setUpDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func currentFirstResponder(_ view: UIView) -> UIView? {
        if view.isFirstResponder {
            return view
        }
        
        for subView in view.subviews {
            if let firstResponder = currentFirstResponder(subView) {
                return firstResponder
            }
        }
        
        return nil
    }
}

// MARK: Keyboard
extension ViewController {
    @objc func keyboardWillShow(_ sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else {
            return
        }
        
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let textFieldBottomY = currentTextField.frame.origin.y + currentTextField.frame.size.height
        
        if textFieldBottomY > keyboardTopY {
            let textBoxY = currentTextField.frame.origin.y
            let newFrameY = (textBoxY - keyboardTopY/2) * -1
            view.frame.origin.y = newFrameY
        }
        
        print(currentTextField.frame)
    }
    
    @objc func keyboardWillHide(_ sender: NSNotification) {
        view.frame.origin.y = 0
    }
}

extension ViewController: UITextFieldDelegate {
    
}

extension UIResponder {
    private struct Static {
        static weak var responder: UIResponder?
    }
    
    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder.trap), to: nil, from: nil, for: nil)
        return Static.responder
    }
    
    @objc func trap() {
        Static.responder = self
    }
}

