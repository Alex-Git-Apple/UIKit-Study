//
//  FavoriateListVC.swift
//  DiffableDataSource
//
//  Created by Pin Lu on 4/17/24.
//

import UIKit

class FavoriateListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let favorites = try? PersistenceManager.retrieveFavorites()
    }

}
