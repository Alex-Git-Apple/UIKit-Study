//
//  UIViewController+Ext.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 4/10/24.
//

import UIKit

@MainActor
extension UIViewController {
    
    func presentGFAlert(title: String, messge: String, buttonTitle: String) {
        let alertVC = GFAlertViewController(title: title, message: messge, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        Task { @MainActor in
            present(alertVC, animated: true)
        }
    }
    
    func loadingView() -> UIView {
        let containerView = UIView(frame: view.bounds)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.8) {
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints  = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
        return containerView
    }
    
}
