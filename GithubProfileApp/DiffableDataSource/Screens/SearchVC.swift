//
//  SearchVC.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 1/30/24.
//

import UIKit

class SearchVC: UIViewController {
    
    let userNameTextField = UITextField(frame: .zero)
    let callToActionButton = UIButton()
    var isUserNameEntered: Bool {
        get {
            userNameTextField.text != nil && !userNameTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // Do any additional setup after loading the view.
        setupSubViews()
        layout()
        createDismissKeyboardTapGesture()
    }
    
    func setupSubViews() {
        setUpNserNameTextField()
        setUpButton()
    }
    
    func setUpNserNameTextField() {
        view.addSubview(userNameTextField)
        userNameTextField.layer.borderWidth = 2
        userNameTextField.layer.borderColor = UIColor.label.cgColor
        userNameTextField.layer.cornerRadius = 15
        
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setUpButton() {
        view.addSubview(callToActionButton)
        var config = UIButton.Configuration.filled()
        config.title = "Get Followers"
        config.buttonSize = .large
        config.baseBackgroundColor = .systemPink
        callToActionButton.configuration = config
        
        callToActionButton.addTarget(self, action: #selector(pushFollowerVC), for: .primaryActionTriggered)
        callToActionButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerVC() {
        guard isUserNameEntered else {
            presentGFAlert(title: "Empty Username", message: "Please enter a user name. 😀", buttonTitle: "OK")
            return
        }
        let followerListVC = FollowerListVC()
        followerListVC.username = userNameTextField.text
        followerListVC.title = userNameTextField.text
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
}
