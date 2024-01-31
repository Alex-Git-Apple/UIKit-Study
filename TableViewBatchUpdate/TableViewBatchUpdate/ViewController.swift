//
//  ViewController.swift
//  TableViewBatchUpdate
//
//  Created by Pin Lu on 10/18/23.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView = UITableView(frame: .zero)
    var button = UIButton()
    var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUp()
    }
    
    func setUp() {
        view.addSubview(tableView)
        view.addSubview(button)
        
        tableView.register(NumberCell.self, forCellReuseIdentifier: NumberCell.reusedID)
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        var config = UIButton.Configuration.filled()
        config.title = "New Item"
        config.baseBackgroundColor = .systemBlue
        button.configuration = config
        
        button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        layOut()
    }
    
    func layOut() {
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -10)
        ])
    }
    
    @objc func pressed(_ sender: UIButton) {
        let lastIndex = numbers.endIndex - 1
        numbers.removeLast()
        numbers.removeLast()
        let val = numbers.removeLast()
        
        numbers.insert(val, at:0)
        
        tableView.performBatchUpdates {
            let ip1 = IndexPath(row: lastIndex, section: 0)
            let ip2 = IndexPath(row: lastIndex - 1, section: 0)
            let ip3 = IndexPath(row: lastIndex - 2, section: 0)
            
            let ip4 = IndexPath(row: 0, section: 0)
            
            tableView.deleteRows(at: [ip1, ip2, ip3], with: .automatic)
            tableView.insertRows(at: [ip4], with: .fade)
        }
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NumberCell.reusedID) as! NumberCell
        cell.setLabel(numbers[indexPath.row])
        return cell
    }
    
    
}

