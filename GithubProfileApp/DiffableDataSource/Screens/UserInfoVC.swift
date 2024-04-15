//
//  UserInfoVC.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 4/12/24.
//

import UIKit

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViews: [UIView] = []
    
    var username: String
    var userInfo: User?
    
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutUI()
        Task {
            await downloadUserInfo()
            addChildViewControllers()
        }
    }
    
    func layoutUI() {
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissView))
        navigationItem.rightBarButtonItem = doneButton
        
        let padding: CGFloat = 20
        
        itemViews = [headerView, itemViewOne, itemViewTwo]
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }
        
        let itemHeight: CGFloat = 140
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight)
        ])
    }
    
    func downloadUserInfo() async {
        do {
            userInfo = try await NetworkManager.shared.getUserInfo(for: username)
        } catch {
            presentGFAlert(title: "Something went wrong", message: error.localizedDescription   , buttonTitle: "OK")
        }
    }
    
    func addChildViewControllers() {
        if let userInfo = self.userInfo {
            self.addChildVC(childVC: GFUserInfoHeaderVC(user: userInfo), to: headerView)
        }
    }
    
    func addChildVC(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true)
    }
}
