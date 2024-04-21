//
//  FavoriteCell.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 4/17/24.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let reusedID = "FavoriteCell"
    
    let avatarImageView = GFAvartarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)
    
    
    private var stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(usernameLabel)
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func set(favorite: Follower) {
        usernameLabel.text = favorite.login
        Task { @MainActor in
            avatarImageView.image = try? await ImageLoader.shared.downloadImage(url: favorite.avatarUrl)
        }
    }
    
}
