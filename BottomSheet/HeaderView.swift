//
//  HeaderView.swift
//  BottomSheet
//
//  Created by farhad jebelli on 2/14/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import UIKit

public class HeaderView: PassthroughView {
    
    public var contentView: UIView! {
        didSet {
            oldValue?.removeFromSuperview()
            addSubview(contentView)
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            bringSubviewToFront(contentView)
        }
    }
    
    public var backgroundView: UIView! {
        didSet {
            oldValue?.removeFromSuperview()
            addSubview(backgroundView)
            backgroundView.frame = bounds
            backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            sendSubviewToBack(backgroundView)
        }
    }
    
    public var backgroundMarginFrom: CGFloat = 0
    public var backgroundMarginTo: CGFloat = 0
    
    
    
    var backgroundAnimationFractionCompleate: CGFloat = 0 {
        didSet {
            let expandedWidth = frame.width - 2 * backgroundMarginTo
            let collapsedWidth = frame.width - 2 * backgroundMarginFrom
            // 1 -> collapsedWidth, 0 -> expandedWidth
            let width = collapsedWidth + (expandedWidth - collapsedWidth) * backgroundAnimationFractionCompleate
            CATransaction.begin()
            backgroundView?.transform
                = CGAffineTransform(scaleX: width / frame.width, y: 1)
            CATransaction.commit()
        }
    }
    
    var offsetFromTop: CGFloat = 0 {
        didSet {
            transform = CGAffineTransform(translationX: 0, y: offsetFromTop)
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
    var gesture: UISwipeGestureRecognizer!
    private func setupView() {
        backgroundColor = .clear
    }

}

