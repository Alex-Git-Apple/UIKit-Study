//
//  FavoriteListVC.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 4/17/24.
//

import UIKit

class FavoriteListVC: UIViewController {
    
    let tableView = UITableView()
    var favorites = [Follower]()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureTableView()
        loadFavorites()
    }
    
    func loadFavorites() {
        do {
            favorites = try PersistenceManager.retrieveFavorites()
            if favorites.isEmpty {
                showEmptyStateView(with: "No Favorites?\nAdd one on the follower screen.", in: self.view)
            }
        } catch {
            var message = ""
            if let error = error as? GFError {
                message = error.rawValue
            } else {
                message = error.localizedDescription
            }
            presentGFAlert(title: "Unable to favorite", message: message)
        }
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reusedID)
    }

}

extension FavoriteListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reusedID, for: indexPath) as? FavoriteCell else {
            return UITableViewCell()
        }
        cell.set(favorite: favorites[indexPath.row])
        return cell
    }
    
}

extension FavoriteListVC: UITableViewDelegate {
    
}
