//
//  GFButton.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 4/10/24.
//

import UIKit

class GFButton: UIButton {

    init(title: String, color: UIColor) {
        super.init(frame: .zero)
        configuration = UIButton.Configuration.filled()
        configuration?.title = title
        configuration?.baseBackgroundColor = color
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
