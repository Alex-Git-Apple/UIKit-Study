//
//  ViewController.swift
//  TableViewBatchUpdate
//
//  Created by Pin Lu on 10/18/23.
//

import UIKit

class ViewController: UIViewController {
    typealias PostCellModel = PostCell.Model
    
    var tableView = UITableView(frame: .zero)
    var button = UIButton()
    
    let serviceData = [[1, 2, 3, 4, 5] , [3, 2, 6, 7]]
    var dataSource = [PostCell.Model]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUp()
        layout()
        setupData()
    }
    
    func setUp() {
        view.addSubview(tableView)
        view.addSubview(button)
        
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.reusedID)
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        var config = UIButton.Configuration.bordered()
        config.title = "Update"
        button.configuration = config
        
        button.addTarget(self, action: #selector(performBatchUpdates), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -10)
        ])
    }
    
    func setupData() {
        dataSource.append(contentsOf: serviceData[0].map {PostCellModel(num: $0)})
    }
    
    @objc func performBatchUpdates() {
        let newData = serviceData[1].map { PostCellModel(num: $0)}
        
        var tmpDataSource = dataSource
        tmpDataSource.removeLast()
        tmpDataSource.removeLast()
        
        let newOrder = newData + tmpDataSource.filter {!newData.contains($0)}
        
        var deleteIndexes = [IndexPath]()
        var insertIndexes = [IndexPath]()
        var moves = [(from: IndexPath, to: IndexPath)]()
        
        var oldPostToIndex = [PostCellModel: Int]()
        for (i, post) in dataSource.enumerated() {
            oldPostToIndex[post] = i
        }
        
        var newPostToIndex = [PostCellModel: Int]()
        for (i, post) in newOrder.enumerated() {
            newPostToIndex[post] = i
        }
        
        for (post, i) in oldPostToIndex {
            if newPostToIndex[post] == nil {
                deleteIndexes.append(IndexPath(row: i, section: 0))
            }
        }
        
        for (post, newIndex) in newPostToIndex {
            if let oldIndex = oldPostToIndex[post] {
                moves.append((from: IndexPath(row: oldIndex, section: 0), to: IndexPath(row: newIndex, section: 0)))
            } else {
                insertIndexes.append(IndexPath(row: newIndex, section: 0))
            }
        }
        
        dataSource = newOrder
        
        tableView.performBatchUpdates {
            tableView.deleteRows(at: deleteIndexes, with: .automatic)
            tableView.insertRows(at: insertIndexes, with: .automatic)
            for move in moves {
                tableView.moveRow(at: move.from, to: move.to)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reusedID) as! PostCell
        cell.model = dataSource[indexPath.row]
        return cell
    }
    
    
}

