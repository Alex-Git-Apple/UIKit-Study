//
//  GFAvartarImageView.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 4/14/24.
//

import UIKit

class GFAvartarImageView: UIImageView {
    
    let placeHolderImage = UIImage(systemName: "person")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
    }

}
