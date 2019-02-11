//
//  ContentOffsetDynamicItem.swift
//  BottomSheet
//
//  Created by farhad jebelli on 2/9/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import Foundation
import UIKit
class ContentOffsetDynamicItem:NSObject, UIDynamicItem {
    weak var collectionView: UICollectionView!
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
    }
    var center: CGPoint {
        get {
            return collectionView.contentOffset
        }
        set {
            collectionView.contentOffset = newValue
        }
    }
    var bounds: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
    var transform: CGAffineTransform = .identity
}
