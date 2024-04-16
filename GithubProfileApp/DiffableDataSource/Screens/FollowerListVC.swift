//
//  FollowerListVC.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 1/30/24.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var isSearching = false
    var page = 1
    var hasMoreFollowers = true
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    var loadingView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = username
        configureCollectionView()
        configureDataSource()
        configureSearchController()

        // Do any additional setup after loading the view.
        loadFollowers()
    }
    
    func configureCollectionView() {
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = plusButton
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reusedID)
        collectionView.delegate = self
    }
    
    @objc func addButtonTapped() {
        print("Tapped")
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView,
                                                        cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reusedID, for: indexPath) as! FollowerCell
            cell.configure(follower: follower)
            return cell
        })
    }
    
    func configureSearchController() {
        let searchVC = UISearchController()
        searchVC.searchResultsUpdater = self
        searchVC.searchBar.delegate = self
        searchVC.searchBar.placeholder = "Search for a username"
        navigationItem.searchController = searchVC
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    @MainActor
    func loadFollowers() {
        showLoadingView()
        Task {
            do {
                defer {
                    dismissLoadingView()
                }
                let latestLoadedFollowers = try await NetworkManager.shared.getFollowers(for: username, page: page)
                if latestLoadedFollowers.count < 100 {
                    hasMoreFollowers = false
                }
                followers += latestLoadedFollowers
                
                if followers.isEmpty {
                    let message = "This user doesn't have any followers. Go follow them. 😁"
                    showEmptyStateView(with: message, in: self.view)
                    return
                }
                updateData(on: followers)
            } catch {
                print("Failed to load followers")
            }
        }
    }
    
    @MainActor
    func updateData(on followers: [Follower]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        self.dataSource.apply(snapShot, animatingDifferences: true)
    }

}

extension FollowerListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width / 3 - 10
        return CGSize(width: width, height: width)
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if contentHeight - offsetY - height < 100 {
            guard hasMoreFollowers else { return }
            page += 1
            loadFollowers()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeFollower = isSearching ? self.filteredFollowers : self.followers
        let follower = activeFollower[indexPath.item]
        
        let userInfoVC = UserInfoVC(username: follower.login)
        userInfoVC.delegate = self
        
        let navigationVC = UINavigationController(rootViewController: userInfoVC)
        present(navigationVC, animated: true)
    }
    
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines), !filter.isEmpty else {
            isSearching = false
            updateData(on: followers)
            return
        }
        
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
}

@MainActor
extension FollowerListVC {
    func showLoadingView() {
        let loadingView = loadingView()
        view.addSubview(loadingView)
        self.loadingView = loadingView
    }
    
    func dismissLoadingView() {
        if let loadingView = self.loadingView {
            loadingView.removeFromSuperview()
            self.loadingView = nil
        }
    }
}

extension FollowerListVC: UserInfoVCDelegate {
    func requestFollowers(for username: String) {
        let followerListVC = FollowerListVC()
        followerListVC.username = username
        navigationController?.pushViewController(followerListVC, animated: true)
    }
}
