//
//  GFButton.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 4/10/24.
//

import UIKit

class GFButton: UIButton {

    init(title: String? = nil, color: UIColor? = nil) {
        super.init(frame: .zero)
        configuration?.title = title
        configuration?.baseBackgroundColor = color
        configuration = UIButton.Configuration.filled()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(title: String, color: UIColor) {
        configuration?.title = title
        configuration?.baseBackgroundColor = color
    }
    
}
