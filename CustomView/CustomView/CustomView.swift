//
//  CustomView.swift
//  CustomView
//
//  Created by Pin Lu on 11/3/23.
//

import UIKit
import SafariServices

class CustomView: UIView {

    let id: String
    let height: Int
    let width: Int
    let imageURL: String
    let redirectURL: String
    let imageView = UIImageView()
    let label = UILabel()
    let xImage = UIImageView()
    
    init(id: String, height: Int, width: Int, imageURL: String, redirectURL: String) {
        self.id = id
        self.height = height
        self.width = width
        self.imageURL = imageURL
        self.redirectURL = redirectURL
        
        super.init(frame: .zero)
        setUp()
        style()
        layout()
    }
    
    convenience init(height: Int, width: Int) {
        self.init(id: "", height: height, width: width, imageURL: "", redirectURL: "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(redirect))
        self.addGestureRecognizer(tap)
        
//         Add tap gesture to the image view.
        xImage.isUserInteractionEnabled = true
        let tapX = UITapGestureRecognizer(target: self, action: #selector(removeFromSuperview))
        xImage.addGestureRecognizer(tapX)
    }
    
    func style() {
        self.layer.borderWidth = 1
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "star")
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "The Star"
        label.textAlignment = .center
        
        addSubview(xImage)
        xImage.translatesAutoresizingMaskIntoConstraints = false
        xImage.image = UIImage(systemName: "x.square")
    }
    
    func layout() {
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.widthAnchor.constraint(equalToConstant: 200),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            xImage.topAnchor.constraint(equalTo: self.topAnchor),
            xImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            label.widthAnchor.constraint(equalToConstant: 10),
            label.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: label.bottomAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: self.width, height: self.height)
    }
    
    @objc func redirect(_ sender: UITapGestureRecognizer) {
        let url = URL(string: "https://www.google.com")
        let vc = SFSafariViewController(url: url!)
        let currentVC = findViewController()
        currentVC?.present(vc, animated: true, completion: nil)
    }
    
}

extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}

