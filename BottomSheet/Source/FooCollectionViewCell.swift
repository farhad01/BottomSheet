//
//  FooCollectionViewCell.swift
//  BottomSheet
//
//  Created by farhad jebelli on 2/11/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import UIKit

class FooCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = UIColor.white
        
        layer.cornerRadius = 5
        
        layer.shadowPath =
            UIBezierPath(roundedRect: self.bounds,
                         cornerRadius: layer.cornerRadius).cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 1
        layer.masksToBounds = false
    }
}
