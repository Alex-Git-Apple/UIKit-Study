//
//  GFFollowerItemVC.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 4/15/24.
//

import Foundation

class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, count: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, count: user.following)
        actionButton.set(title: "Get Followers", color: .systemGreen)
    }
}
