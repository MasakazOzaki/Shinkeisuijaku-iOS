//
//  ViewController.swift
//  shinkeisuijaku
//
//  Created by Masakaz Ozaki on 2021/06/13.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    var numberSet = [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13]
    
    var selectedNumber = 0
    
    var firstSelectedIndex: IndexPath = IndexPath()
    
    var isFirstTime = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberSet.shuffle()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.number = numberSet[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        cell.isOpened = true
        
        if isFirstTime {
            selectedNumber = cell.number
            firstSelectedIndex = indexPath
            isFirstTime = false
        } else {
            let previousCell = collectionView.cellForItem(at: firstSelectedIndex) as! CollectionViewCell
            if selectedNumber == cell.number {
                cell.remove()
                previousCell.remove()
            } else {
                collectionView.isUserInteractionEnabled = false
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                    previousCell.isOpened = false
                    cell.isOpened = false
                    collectionView.isUserInteractionEnabled = true
                }
            }
            isFirstTime = true
        }
    }
}
