//
//  FollowerCellCollectionViewCell.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 1/30/24.
//

import UIKit
import SwiftUI

@MainActor
class FollowerCell: UICollectionViewCell {
    static let reusedID = "FollowerCell"
    
    let label = GFTitleLabel(textAlignment: .center, fontSize: 16)
    let avatarImageView = GFAvartarImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(follower: Follower) {
        contentConfiguration = UIHostingConfiguration {
            FollowerView(follower: follower)
        }
//        label.text = follower.login
//        downloadImageAsync(url: follower.avatarUrl)
    }
    
    func downloadImageAsync(url urlSring: String) {
        Task {
            self.avatarImageView.image = try? await ImageLoader.shared.downloadImage(url: urlSring)
        }
    }
    
    private func setUp() {
        contentView.addSubview(label)
        contentView.addSubview(avatarImageView)
        layout()
    }
    
    private func layout() {
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor ,constant: 5),
            label.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
