//
//  NumberCell.swift
//  TableViewBatchUpdate
//
//  Created by Pin Lu on 10/18/23.
//

import UIKit

class PostCell: UITableViewCell {
    static let reusedID = "PostCell"
    
    struct Model: Equatable, Hashable {
        var num: Int
    }
    
    var model: Model? {
        didSet {
            applyModel()
        }
    }
    
    let label = UILabel(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        
        contentView.addSubview(label)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    func applyModel() {
        guard let model else { return }
        label.text = String(model.num)
    }
}
