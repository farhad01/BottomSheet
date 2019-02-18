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
    override func layoutSubviews() {
        setShadow()
    }
    func setupView() {
        contentView.backgroundColor = UIColor.white
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]  
        setShadow()
    }
    
    private func setShadow() {
        contentView.layer.cornerRadius = 5
        contentView.layer.shadowPath =
            UIBezierPath(roundedRect: self.bounds,
                         cornerRadius: contentView.layer.cornerRadius).cgPath
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.layer.shadowRadius = 1
        contentView.layer.masksToBounds = false
    }
}
