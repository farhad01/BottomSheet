//
//  BackgroundView.swift
//  BottomSheet
//
//  Created by farhad jebelli on 2/11/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import UIKit

class BackgroundView: UIView {
    var backgroundٰView: UIView!
    var offsetFromTop: CGFloat! {
        didSet {
            backgroundٰView.transform = CGAffineTransform(translationX: 0, y: offsetFromTop)
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
        backgroundٰView = UIView(frame: bounds.applying(CGAffineTransform(scaleX: 1, y: 1.2)))
        backgroundٰView.backgroundColor = UIColor.white
        backgroundٰView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundٰView.layer.cornerRadius = 10
        addSubview(backgroundٰView)
        
    
        
    }
}
