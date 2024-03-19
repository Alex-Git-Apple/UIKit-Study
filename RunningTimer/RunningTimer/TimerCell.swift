//
//  TimerCell.swift
//  RunningTimer
//
//  Created by Pin Lu on 3/18/24.
//

import Combine
import UIKit

class TimerCell: UITableViewCell {
    
    static let reusedID = "TimerCell"
    
    private var stackView = UIStackView()
    private var idLabel = UILabel(frame: .zero)
    private let label = UILabel(frame: .zero)
    private var subscriptions = Set<AnyCancellable>()
    
    private var data: RunningTime!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        setupStackView()
        setupLabel()
    }
    
    func setupStackView() {
        stackView.axis = .vertical
        stackView.backgroundColor = .systemPink
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupLabel() {
        stackView.addArrangedSubview(idLabel)
        stackView.alignment = .center
        stackView.addArrangedSubview(label)
    }
    
    func configure(_ data: RunningTime, _ id: Int) {
        self.data = data
        idLabel.text = String(id)
        data.$value
            .sink(receiveValue: { value in
                self.label.text = String(format: "%.1f", value)
            })
            .store(in: &subscriptions)
    }
    
}
