//
//  FooBottomSheetViewController.swift
//  BottomSheet
//
//  Created by farhad jebelli on 2/14/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import UIKit

class FooBottomSheetViewController: BottomSheetViewController {

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
