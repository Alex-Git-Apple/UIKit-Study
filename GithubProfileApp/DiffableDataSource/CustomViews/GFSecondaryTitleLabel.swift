//
//  GFSecondaryTitleLabel.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 4/14/24.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = .left
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }

}
