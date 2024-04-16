//
//  GFRepoItemVC.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 4/15/24.
//

import UIKit

@MainActor
protocol RepoItemVCDelegate: AnyObject {
    func didTapGitHubProfoile(for user: User)
}

final class GFRepoItemVC: GFItemInfoVC {
    weak var delegate: RepoItemVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        configureActionButton()
    }
    
    func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, count: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, count: user.publicGists)
        actionButton.set(title: "GitHub Profile", color: .systemPurple)
    }
    
    private func configureActionButton() {
        let action = UIAction { [delegate, user] _ in
            delegate?.didTapGitHubProfoile(for: user)
        }
        actionButton.addAction(action, for: .primaryActionTriggered)
    }
}
