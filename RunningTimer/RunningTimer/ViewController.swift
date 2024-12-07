//
//  ViewController.swift
//  RunningTimer
//
//  Created by Pin Lu on 3/18/24.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    let tableView = UITableView()
    var dataSource = [TimerCell.Model]()
    var cancellable: Cancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        setupData()
    }
    
    func setup() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints  = false
        tableView.rowHeight = 100
        tableView.register(TimerCell.self, forCellReuseIdentifier: TimerCell.reusedID)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupData() {
        dataSource = (0..<20).map { TimerCell.Model(id: $0) }
        cancellable = Timer.publish(every: 0.1, on: .main, in: .default)
            .autoconnect()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _  in
                guard let self else { return }
                for cell in self.tableView.visibleCells {
                    if let cell = cell as? TimerCell {
                        cell.increase(0.1)
                    }
                }
            }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TimerCell.reusedID, for: indexPath)
                as! TimerCell
        cell.model = dataSource[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSource[indexPath.row].paused.toggle()
    }
}

class TimerCell: UITableViewCell {
    
    class Model {
        let id: Int
        var elapse: Double
        var paused = false
        
        init(id: Int, elapse: Double = 0.0) {
            self.id = id
            self.elapse = elapse
        }
    }
    
    var model: Model?
    
    static let reusedID = "TimerCell"
    
    let stackView = UIStackView()
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        stackView.addArrangedSubview(label)
        label.text = "0.0"
        label.textAlignment = .center
    }
    
    func increase(_ interval: Double) {
        guard let model, !model.paused else { return }
        model.elapse += interval
        label.text = String(format: "id: %d Timer: %.1f", model.id, model.elapse)
    }
}
