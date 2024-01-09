//
//  ViewController.swift
//  InfiniteNumbers
//
//  Created by Pin Lu on 4/16/23.
//

import UIKit

class ViewController: UIViewController {
   
    private var numbers = [1, 1]
    private var cv: UICollectionView!
    private let loadLimit = 30
    private var isLoading = false
    private var totalNumber = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUp()
        layOut()
        loadData()
    }
    
    func setUp() {
        cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        cv.dataSource = self
        cv.delegate = self
        cv.register(NumberCell.self, forCellWithReuseIdentifier: NumberCell.reusedID)
        
        view.addSubview(cv)
        cv.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layOut() {
        NSLayoutConstraint.activate([
            cv.topAnchor.constraint(equalTo: view.topAnchor),
            cv.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cv.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            cv.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    func loadData() {
        var numberCopy = numbers
        var a = numberCopy[numbers.endIndex - 2]
        var b = numberCopy[numbers.endIndex - 1]
        for _ in 0..<loadLimit {
            if a > Int.max - b {
//                numberCopy.append(contentsOf: [1, 1])
//                break
                totalNumber += 1
                continue
            }
            let c = a + b
            numberCopy.append(c)
            a = b
            b = c
            totalNumber += 1
        }
        numbers = numberCopy
        isLoading = false
        cv.reloadData()
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        <#code#>
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        <#code#>
//    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalNumber
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberCell.reusedID, for: indexPath)
            as! NumberCell
        cell.configure(numbers[indexPath.item % numbers.count])
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 2 - 15
        return CGSize(width: width, height: 50)
    }

}

extension ViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let yOffset = scrollView.contentOffset.y
        let scrollViewHeight = scrollView.frame.height
        let contentHeight = scrollView.contentSize.height
        
        guard yOffset + scrollViewHeight > contentHeight - 100 else {
            return
        }
        
        guard !isLoading else { return }
        
        isLoading = true
        loadData()
    }
    
}

