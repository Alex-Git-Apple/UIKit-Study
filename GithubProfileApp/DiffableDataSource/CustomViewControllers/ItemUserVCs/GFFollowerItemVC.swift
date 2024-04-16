//
//  GFFollowerItemVC.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 4/15/24.
//

import UIKit

@MainActor
protocol FollowerItemVCDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

final class GFFollowerItemVC: GFItemInfoVC {
    weak var delegate: FollowerItemVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        configureActionButton()
    }
    
    func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, count: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, count: user.following)
        actionButton.set(title: "Get Followers", color: .systemGreen)
    }
    
    private func configureActionButton() {
        let action = UIAction { [delegate, user] _ in
            delegate?.didTapGetFollowers(for: user)
        }
        actionButton.addAction(action, for: .primaryActionTriggered)
    }
}
