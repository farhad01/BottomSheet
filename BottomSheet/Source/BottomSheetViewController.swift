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
    var item: ContentOffsetDynamicItem!
    var layout: UICollectionViewFlowLayout!
    
    
    var backgroundView: BackgroundView!
    
    var backgroundViewOffset: CGFloat = 10
    var heightRatio: CGFloat = 0.6
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupDynmaicAnimation()
    }
    
    private func setupCollectionView() {
        layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.translatesAutoresizingMaskIntoConstraints = true
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = UIColor.clear
        
        collectionView.register(FooCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.contentInset = UIEdgeInsets(top: view.frame.height, left: 0, bottom: 0, right: 0)
        
        backgroundView = BackgroundView(frame: view.frame)
        collectionView.backgroundView = backgroundView
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout.invalidateLayout()
        setBehaviors(toTop: true)
    }
    
    private func setupDynmaicAnimation() {
        item = ContentOffsetDynamicItem(scrollView: collectionView)
        animator = UIDynamicAnimator(referenceView: collectionView)
        
        let edge = -view.frame.height * (1 - heightRatio)
        attach = UIAttachmentBehavior(item: item, attachedToAnchor: CGPoint(x: 0, y: edge))
        attach.length = 0
        attach.damping = 0.4
        attach.frequency = 3.5
        
        itemBehavior = UIDynamicItemBehavior(items: [item])
        itemBehavior.density = 100;
        itemBehavior.resistance = 10;
        
        animator.addBehavior(attach)
        animator.addBehavior(itemBehavior)
        
    }
}
extension BottomSheetViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        animator.removeAllBehaviors()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if isInSnapRange() {
            setBehaviors(toTop: velocity.y > 0)
        } else if isInSnapRange(point: targetContentOffset.pointee) {
            setBehaviors(toTop: true)
        } else {
            scrollView.decelerationRate = .normal
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let dy = max(-scrollView.contentOffset.y, 0)
        backgroundView?.backgroundCenterOffset = dy - backgroundViewOffset
    }
    
    private func setBehaviors(toTop: Bool) {
        if toTop {
            let edge = -view.frame.height * (1 - heightRatio)
            attach.anchorPoint = CGPoint(x: 0, y: edge)
        } else {
            attach.anchorPoint = CGPoint(x: 0, y: -view.frame.height - backgroundViewOffset)
        }
        animator.addBehavior(attach)
        animator.addBehavior(itemBehavior)
        
        collectionView.decelerationRate = .init(rawValue: 0)
    }
    
    private func isInSnapRange(point: CGPoint? = nil) -> Bool {
        return (point ?? collectionView.contentOffset).y < -view.frame.height * (1 - heightRatio)
    }
    
    private func isInBottomHalfOfSnapRange() -> Bool {
        return collectionView.contentOffset.y < -view.frame.height * (1 - heightRatio) - view.frame.height * (heightRatio / 2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width - 20, height: 60)
    }
}

extension BottomSheetViewController:  UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
}

