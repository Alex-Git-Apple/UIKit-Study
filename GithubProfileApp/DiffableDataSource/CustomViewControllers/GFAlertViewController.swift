//
//  GFAlertViewController.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 4/10/24.
//

import UIKit

class GFAlertViewController: UIViewController {
    
    let containerView = GFAlertContainerView()
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GFBodyLabel(textAlignment: .center)
    let actionButton = GFButton(title: "", color: .systemPink)
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    init(title: String? = nil, message: String? = nil, buttonTitle: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }
    
    func configureContainerView() {
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: containerView.leadingAnchor, multiplier: 2),
            containerView.trailingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 2),
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: containerView.topAnchor, multiplier: 2),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureActionButton() {
        containerView.addSubview(actionButton)
        
        actionButton.configuration?.title = title ?? "OK"
        actionButton.addAction(UIAction(handler: { _ in
            self.dismissVC()
        }), for: .primaryActionTriggered)
        
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalToSystemSpacingBelow: actionButton.bottomAnchor, multiplier: 3),
            actionButton.leadingAnchor.constraint(equalToSystemSpacingAfter: containerView.leadingAnchor, multiplier: 3),
            containerView.trailingAnchor.constraint(equalToSystemSpacingAfter: actionButton.trailingAnchor, multiplier: 3),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? "Unable to complete request"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: containerView.leadingAnchor, multiplier: 2),
            containerView.trailingAnchor.constraint(equalToSystemSpacingAfter: messageLabel.trailingAnchor, multiplier: 2),
            messageLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 2),
            actionButton.topAnchor.constraint(equalToSystemSpacingBelow: messageLabel.bottomAnchor, multiplier: 2)
        ])
    }
    
    func dismissVC() {
        dismiss(animated: true)
    }
}

@available(iOS 17.0, *)
#Preview {
    let vc = GFAlertViewController()
    return vc
}
