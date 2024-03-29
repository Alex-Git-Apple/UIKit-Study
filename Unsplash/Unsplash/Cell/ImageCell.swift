//
//  ImageCell.swift
//  Unsplash
//
//  Created by Pin Lu on 4/19/23.
//

import UIKit
import Combine

class ImageCell: UICollectionViewCell {
    private var viewModel: ImageCellViewModel?
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: View components
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    func setUp(viewModel: ImageCellViewModel) {
        self.viewModel = viewModel
        
        setLayout()
        setBinding()
    }
    
    
    func setLayout() {
        addSubview(imageView)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: self.imageView,
                                              attribute: .top, relatedBy: .equal, toItem: self,
                                              attribute: .top, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.imageView,
                                              attribute: .bottom, relatedBy: .equal, toItem: self,
                                              attribute: .bottom, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.imageView,
                                              attribute: .leading, relatedBy: .equal, toItem: self,
                                              attribute: .leading, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.imageView,
                                              attribute: .trailing, relatedBy: .equal, toItem: self,
                                              attribute: .trailing, multiplier: 1.0, constant: 0))
        
        addSubview(label)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: self.label,
                                              attribute: .bottom, relatedBy: .equal, toItem: self.imageView,
                                              attribute: .bottom, multiplier: 1.0, constant: -10))
        self.addConstraint(NSLayoutConstraint(item: self.label,
                                              attribute: .leading, relatedBy: .equal, toItem: self.imageView,
                                              attribute: .leading, multiplier: 1.0, constant: 15))
    }
    
    func setBinding() {
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.image
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.imageView.image = value
            })
            .store(in: &subscriptions)
        
        viewModel.author
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.label.text = value
            })
            .store(in: &subscriptions)
    }
}
