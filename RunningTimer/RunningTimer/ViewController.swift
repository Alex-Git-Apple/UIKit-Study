//
//  ViewController.swift
//  RunningTimer
//
//  Created by Pin Lu on 3/18/24.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    var tableView = UITableView(frame: .zero)
    private var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupTableView()
        setupData()
    }
    
    func setupData() {
        // autoconnect() makes sure the timer publisher is active all the time.
        // Cancel the publisher -> timerPublisher.upstream.connect().cancel
        let timerPublisher = Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
        
        timerPublisher.sink { _ in
            for cell in self.tableView.visibleCells {
                if let timerCell = cell as? TimerCell {
                    timerCell.increament(interval: 0.1)
                }
            }
        }.store(in: &subscriptions)
    
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.register(TimerCell.self, forCellReuseIdentifier: TimerCell.reusedID)
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: tableView.trailingAnchor, multiplier: 5),
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 5),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: tableView.bottomAnchor, multiplier: 5)
        ])
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TimerCell.reusedID, for: indexPath) as! TimerCell
//        cell.configure(data[indexPath.row], indexPath.row)
        print("create cell - \(indexPath.row)")
        return cell
    }
    
}
