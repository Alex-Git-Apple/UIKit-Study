//
//  FollowerListVC.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 1/30/24.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var username: String!
    var followers: [Follower] = []
    var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = username

        // Do any additional setup after loading the view.
        Task {
            await loadFollowers()
        }
    }
    
    func loadFollowers() async {
        do {
            let followers = try await NetworkManager.shared.getFollowers(for: username, page: page)
            print(followers)
        } catch {
            print("Failed to load followers")
        }
    }

}
