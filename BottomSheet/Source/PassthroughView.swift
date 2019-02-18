//
//  PassthroughView.swift
//  BottomSheet
//
//  Created by farhad jebelli on 2/17/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import UIKit

class PassthroughView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? nil : view
    }
}
