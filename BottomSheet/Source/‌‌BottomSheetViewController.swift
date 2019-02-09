//
//  ‌‌BottomSheetViewController.swift
//  BottomSheet
//
//  Created by farhad jebelli on 2/9/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import UIKit

class BottomSheetViewController: UIViewController {
    var collectionView: UICollectionView!
    var animator: UIDynamicAnimator!
    var attach: UIAttachmentBehavior!
    var itemBehavior: UIDynamicItemBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        setupDynmaicAnimation()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.translatesAutoresizingMaskIntoConstraints = true
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = UIColor.clear
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.contentInset = UIEdgeInsets(top: view.frame.height, left: 0, bottom: 0, right: 0)
    }
    
    private func setupDynmaicAnimation() {
        let item = ContentOffsetDynamicItem(collectionView: collectionView)
        animator = UIDynamicAnimator(referenceView: collectionView)
        
        let edge = -view.frame.height * 0.3
        attach = UIAttachmentBehavior(item: item, attachedToAnchor: CGPoint(x: 0, y: edge))
        attach.length = 0
        attach.damping = 0.4
        attach.frequency = 3.5
        animator.addBehavior(attach)
        
        itemBehavior = UIDynamicItemBehavior(items: [item])
        itemBehavior.density = 100;
        itemBehavior.resistance = 10;

        animator.addBehavior(itemBehavior)
        
    }
    
    
}
extension BottomSheetViewController: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        animator.removeAllBehaviors()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > -view.frame.height * 0.3 - view.frame.height * 0.35 {
            let edge = -view.frame.height * 0.3
            attach.anchorPoint = CGPoint(x: 0, y: edge)
        } else {
            attach.anchorPoint = CGPoint(x: 0, y: -view.frame.height)
        }
        animator.addBehavior(attach)
        animator.addBehavior(itemBehavior)
    }
}

extension BottomSheetViewController:  UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    
}
