//
//  HeaderView.swift
//  BottomSheet
//
//  Created by farhad jebelli on 2/17/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import Foundation
import UIKit
class HeaderViewExample: PassthroughView {
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
        backgroundColor = UIColor.white
        autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setShadow()
        
    }

    private func setShadow() {
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
