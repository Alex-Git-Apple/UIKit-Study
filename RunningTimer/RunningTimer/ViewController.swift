//
//  ViewController.swift
//  RunningTimer
//
//  Created by Pin Lu on 3/18/24.
//

import UIKit
import Combine

class RunningTime: ObservableObject {
    @Published var value = 0.0
    var timerPublisher: Publishers.Autoconnect<Timer.TimerPublisher>?
    private var subscriptions = Set<AnyCancellable>()
    
    func start() {
        timerPublisher?
            .sink(receiveValue: { _ in
            self.value += 0.1
        })
        .store(in: &subscriptions)
    }
    
    func stop() {
        for subscription in subscriptions {
            subscription.cancel()
        }
        subscriptions.removeAll()
    }
}

class ViewController: UIViewController {
    
    var data = [RunningTime]()
    var tableView = UITableView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupData()
        setupTableView()
    }
    
    func setupData() {
        // autoconnect() makes sure the timer publisher is active all the time.
        // Cancel the publisher -> timerPublisher.upstream.connect().cancel
        let timerPublisher = Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
        data = (1...10).map{ _ in
            let runningTime = RunningTime()
            runningTime.timerPublisher = timerPublisher
            return runningTime
        }
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.register(TimerCell.self, forCellReuseIdentifier: TimerCell.reusedID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 200
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
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TimerCell.reusedID, for: indexPath) as! TimerCell
        cell.configure(data[indexPath.row], indexPath.row)
        print("create cell - \(indexPath.row)")
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath) {
            print("cell \(indexPath.row) will display")
            data[indexPath.row].start()
    }
    
    func tableView(
        _ tableView: UITableView,
        didEndDisplaying cell: UITableViewCell,
        forRowAt indexPath: IndexPath) {
            data[indexPath.row].stop()
            print("cell \(indexPath.row) did end displaying")
    }
    
}

