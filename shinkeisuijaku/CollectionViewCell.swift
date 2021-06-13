//
//  CollectionViewCell.swift
//  shinkeisuijaku
//
//  Created by Masakaz Ozaki on 2021/06/13.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var numberLabel: UILabel!
    
    var number: Int = 0 {
        didSet {
            guard let numberLabel = numberLabel else { return }
            numberLabel.text = "裏"
        }
    }
    
    var isOpened = false {
        didSet {
            if isOpened {
                numberLabel.text = String(number)
                self.layer.borderWidth = 3
                self.layer.borderColor = UIColor.black.cgColor
            } else {
                numberLabel.text = "裏"
                self.layer.borderWidth = 0
            }
        }
    }
    
    func remove() {
        self.backgroundColor = .gray
        self.isUserInteractionEnabled = false
    }
}
