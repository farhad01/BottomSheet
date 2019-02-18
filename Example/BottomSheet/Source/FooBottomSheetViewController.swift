//
//  FooBottomSheetViewController.swift
//  BottomSheet
//
//  Created by farhad jebelli on 2/14/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import UIKit
import BottomSheet
class FooBottomSheetViewController: BottomSheetViewController {
    override var headerHeight: CGFloat {
        return 90
    }
    
    override var backgroundViewOffset: CGFloat {
        return headerHeight / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(FooCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        let background = HeaderViewExample(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: headerHeight))
        background.removeFromSuperview()
        headerView.backgroundView = background
        
    }
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width - 20, height: 60)
    }
}
