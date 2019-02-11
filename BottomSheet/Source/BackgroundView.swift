//
//  BackgroundView.swift
//  BottomSheet
//
//  Created by farhad jebelli on 2/11/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import UIKit

class BackgroundView: UIView {
    var backgroundLayer: CALayer!
    var backgroundCenterOffset: CGFloat! {
        didSet {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            backgroundLayer.transform = CATransform3DMakeTranslation(0, backgroundCenterOffset - 10, 0)
            CATransaction.commit()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        
        backgroundColor = .clear
        
        backgroundLayer = CALayer()
        backgroundLayer.backgroundColor = UIColor.white.cgColor
        backgroundLayer.frame = bounds.applying(CGAffineTransform(scaleX: 1, y: 1.5))
        backgroundLayer.cornerRadius = 10
        layer.addSublayer(backgroundLayer)
    }

    
}
