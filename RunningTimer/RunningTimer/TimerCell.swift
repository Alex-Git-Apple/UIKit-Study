//
//  TimerCell.swift
//  RunningTimer
//
//  Created by Pin Lu on 3/18/24.
//
import UIKit

class TimerCell: UITableViewCell {
    
    static let reusedID = "TimerCell"
    static var id = 1
    
    private var stackView = UIStackView()
    private var idLabel = UILabel(frame: .zero)
    private let label = UILabel(frame: .zero)
    private var currentTime = 0.0
    let id: Int
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        id = Self.id
        Self.id += 1
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
        stackView.distribution = .fill
        stackView.alignment = .center
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
        stackView.addArrangedSubview(label)
        label.text = "0.0"
    }
    
    func increament(interval: Double) {
        currentTime += interval
        self.label.text = String(format: "id: %d  Timer: %.1f", id, currentTime)
    }
    
}
