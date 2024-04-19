//
//  UserInfoVC.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 4/12/24.
//

import UIKit

@MainActor
protocol UserInfoVCDelegate: AnyObject {
    func requestFollowers(for username: String)
}

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    var username: String
    weak var delegate: UserInfoVCDelegate?
    
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() {
        Task {
            do {
                let user =  try await self.downloadUserInfo()
                displayUserInfo(with: user)
            } catch {
                presentGFAlert(title: "Something went wrong", message: error.localizedDescription   , buttonTitle: "OK")
            }
        }
        layoutUI()
    }
    
    func layoutUI() {
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissView))
        navigationItem.rightBarButtonItem = doneButton
        
        let padding: CGFloat = 20
        
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
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
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func downloadUserInfo() async throws -> User {
        return try await NetworkManager.shared.getUserInfo(for: username)
    }
    
    func displayUserInfo(with userInfo: User) {
        self.addChildVC(childVC: GFUserInfoHeaderVC(user: userInfo), to: headerView)
        let repoItemVC = GFRepoItemVC(user: userInfo)
        repoItemVC.delegate = self
        self.addChildVC(childVC:repoItemVC , to: itemViewOne)
        let followerItemVC = GFFollowerItemVC(user: userInfo)
        followerItemVC.delegate = self
        self.addChildVC(childVC:followerItemVC , to: itemViewTwo)
        dateLabel.text = "GitHub since \(userInfo.createdAt.convertToMonthYearFormat())"
    }
    
    func addChildVC(childVC: UIViewController, to containerView: UIView) {
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        
        addChild(childVC)
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true)
    }
}

extension UserInfoVC: RepoItemVCDelegate, FollowerItemVCDelegate {
    func didTapGitHubProfoile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else { 
            presentGFAlert(title: "Invalid URL", message: "The url attached is invalid", buttonTitle: "OK")
            return
        }
        
        presentSafariVC(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlert(title: "No followers", message: "This user has no followers", buttonTitle: "So Sad")
            return
        }
        delegate?.requestFollowers(for: user.login)
        self.dismissView()
    }
}
