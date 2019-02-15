//
//  HeaderView.swift
//  BottomSheet
//
//  Created by farhad jebelli on 2/14/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    var contentView: UIView? {
        didSet {
            
        }
    }
    
    var backgroundView: UIView? {
        didSet {
            
        }
    }
    
    var backgroundMarginFrom: CGFloat?
    var backgroundMarginTo: CGFloat?
    
    
    
    var backgroundAnimationFractionCompleate: CGFloat? {
        didSet {
            
        }
    }
    
    var offsetFromTop: CGFloat! {
        didSet {
            
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
        
    }

}
