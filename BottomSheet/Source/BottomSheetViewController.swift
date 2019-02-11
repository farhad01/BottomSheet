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
    
    var heightRatio: CGFloat = 0.6
    
    var timeLocation: (loc: CGFloat, time: DispatchTime)!
    
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
        item = ContentOffsetDynamicItem(collectionView: collectionView)
        animator = UIDynamicAnimator(referenceView: collectionView)
        
        let edge = -view.frame.height * (1 - heightRatio)
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
    
    private func getTimeLocation() -> (loc: CGFloat, time: DispatchTime){
        return (loc: collectionView.contentOffset.y,time: .now())
    }
}
extension BottomSheetViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timeLocation = getTimeLocation()
        animator.removeAllBehaviors()
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if  isInSnapRange() {
//            setBehaviers(toTop: !isInHafeBottomOfSnappRange())
//        } else {
//            //scrollView.decelerationRate = .normal
//        }
//    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if isInSnapRange() {
            setBehaviers(toTop: velocity.y > 0)
        } else if isInSnapRange(point: targetContentOffset.pointee) {
            setBehaviers(toTop: true)
        } else {
            scrollView.decelerationRate = .normal
        }
    }
    
    private func setBehaviers(toTop: Bool) {
        if toTop {
            let edge = -view.frame.height * (1 - heightRatio)
            attach.anchorPoint = CGPoint(x: 0, y: edge)
        } else {
            attach.anchorPoint = CGPoint(x: 0, y: -view.frame.height)
        }
        animator.addBehavior(attach)
        animator.addBehavior(itemBehavior)
        
        collectionView.decelerationRate = .init(rawValue: 0)
    }
    
    private func isInSnapRange(point: CGPoint? = nil) -> Bool {
        
        return (point ?? collectionView.contentOffset).y < -view.frame.height * (1 - heightRatio)
    }
    
    private func isInHafeBottomOfSnappRange() -> Bool {
        return collectionView.contentOffset.y < -view.frame.height * (1 - heightRatio) - view.frame.height * (heightRatio / 2)
    }
    
    private func getVolume() -> CGFloat {
        let now = getTimeLocation()
        let volume = (now.loc - timeLocation.loc) / CGFloat((Double(now.time.uptimeNanoseconds - timeLocation.time.uptimeNanoseconds))/1000000000)
        return volume
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
