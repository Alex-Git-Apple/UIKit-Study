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

        // Do any additional setup after loading the view.
        loadFollowers()
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reusedID)
        collectionView.delegate = self
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView,
                                                        cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reusedID, for: indexPath) as! FollowerCell
            cell.configure(follower: follower)
            return cell
        })
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
                updateData()
            } catch {
                print("Failed to load followers")
            }
        }
    }
    
    func updateData() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapShot, animatingDifferences: true)
        }
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
