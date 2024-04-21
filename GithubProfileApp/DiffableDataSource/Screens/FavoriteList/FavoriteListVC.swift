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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
    }
    
    @available(iOS 17.0, *)
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if favorites.isEmpty {
            var config = UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: "star")
            config.text = "No Favorite"
            config.secondaryText = "Add a favorite on the follower list screen"
            contentUnavailableConfiguration = config
        } else {
            contentUnavailableConfiguration = nil
        }
    }
    
    func loadFavorites() {
        do {
            favorites = try PersistenceManager.retrieveFavorites()
            tableView.reloadData()
            if #available(iOS 17.0, *) {
                setNeedsUpdateContentUnavailableConfiguration()
            } else {
                if favorites.isEmpty {
                    showEmptyStateView(with: "No Favorites?\nAdd one on the follower screen.", in: self.view)
                }
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoriate = favorites[indexPath.row]
        let userInfoVC = FollowerListVC(username: favoriate.login)
        navigationController?.pushViewController(userInfoVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favorite = favorites[indexPath.row]
        do {
            try PersistenceManager.update(with: favorite, actionType: .remove)
            favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        } catch {
            presentGFAlert(title: "Unable to remove", message: error.localizedDescription)
        }
    }
}
