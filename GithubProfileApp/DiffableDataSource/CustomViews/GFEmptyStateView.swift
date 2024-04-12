//
//  GFEmptyStateView.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 4/12/24.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let logoImageView = UIImageView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    func configure() {
        addSubview(messageLabel)
        addSubview(logoImageView)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        logoImageView.image = UIImage(systemName: "figure.fishing")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            logoImageView.widthAnchor.constraint(equalTo: widthAnchor),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: 0.8),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -140)
        ])
    }
    
}

@available(iOS 17.0, *)
#Preview {
    let view = GFEmptyStateView(message: "This is empty state view.")
    return view
}
