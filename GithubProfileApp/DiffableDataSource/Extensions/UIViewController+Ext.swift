//
//  UIViewController+Ext.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 4/10/24.
//

import UIKit

extension UIViewController {
    
    func presentGFAlert(title: String, messge: String, buttonTitle: String) {
        let alertVC = GFAlertViewController(title: title, message: messge, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        Task { @MainActor in
            present(alertVC, animated: true)
        }
    }
}
