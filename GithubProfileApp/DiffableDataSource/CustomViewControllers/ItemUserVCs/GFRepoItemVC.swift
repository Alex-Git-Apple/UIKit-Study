//
//  GFRepoItemVC.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 4/15/24.
//

import Foundation

class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, count: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, count: user.publicGists)
        actionButton.set(title: "GitHub profile", color: .systemPurple)
    }
}
