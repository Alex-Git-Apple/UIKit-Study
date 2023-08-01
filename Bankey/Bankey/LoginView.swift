//
//  LoginView.swift
//  Bankey
//
//  Created by Pin Lu on 8/1/23.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension LoginView {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .red
    }
    
    func layout() {
        
    }
}

