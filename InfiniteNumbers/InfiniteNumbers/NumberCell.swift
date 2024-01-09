//
//  NumberCell.swift
//  InfiniteNumbers
//
//  Created by Pin Lu on 4/16/23.
//

import UIKit

class NumberCell: UICollectionViewCell {
    static let reusedID = "NumberCell"
    
    let label = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(_ number: Int) {
        label.text = String(number)
    }
    
    private func setUp() {
        contentView.addSubview(label)
        
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        layer.borderWidth = 2
        
        layout()
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}


