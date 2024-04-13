//
//  UserInfoVC.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 4/12/24.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var username: String
    
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissView))
        navigationItem.rightBarButtonItem = doneButton
        
        Task {
            do {
                let userInfo = try await NetworkManager.shared.getUserInfo(for: username)
                print(userInfo)
            } catch {
                presentGFAlert(title: "Something went wrong", message: error.localizedDescription   , buttonTitle: "OK")
            }
        }
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true)
    }
}
