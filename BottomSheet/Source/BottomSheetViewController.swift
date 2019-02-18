//
//  ‌‌BottomSheetViewController.swift
//  BottomSheet
//
//  Created by farhad jebelli on 2/9/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import UIKit

protocol ParallexBackgroundProtocol: class {
    var frame: CGRect {get}
    func scrollDidChange(transform: CGAffineTransform)
}

class BottomSheetViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var headerView: HeaderView!
    @IBOutlet var headerHeightConstraint: NSLayoutConstraint!
    
    var animator: UIDynamicAnimator!
    var attach: UIAttachmentBehavior!
    var itemBehavior: UIDynamicItemBehavior!
    var item: ContentOffsetDynamicItem!
    var layout: UICollectionViewFlowLayout!
    
    var headerHeight: CGFloat {
        return 50
    }
    var headerMargin: CGFloat {
        return 24
    }
    var backgroundView: BackgroundView!
    
    var backgroundViewOffset: CGFloat {
        return 10
    }
    var upRangeHeight: CGFloat = 296
    
    private var extendedHeight: CGFloat {
        return view.frame.height + headerMargin + headerHeight
    }
    
    private var snapPoint: CGFloat {
        return  upRangeHeight
    }
    
    weak var parallexDelegate: ParallexBackgroundProtocol?
    // MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupNavigationController()
        setupCollectionView()
        setupDynmaicAnimation()
        setupHeaderView()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func setupCollectionView() {
        layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        
        collectionView.backgroundColor = UIColor.clear
        
        collectionView.register(FooCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.contentInset = UIEdgeInsets(top: extendedHeight, left: 0, bottom: 0, right: 0)
        
        backgroundView = BackgroundView(frame: view.frame)
        collectionView.backgroundView = backgroundView
        
    }
    
    func setupHeaderView() {
        headerView.backgroundMarginTo = 24
        headerView.backgroundMarginFrom = -2
        headerHeightConstraint.constant = headerHeight
    }
    
    private func setupDynmaicAnimation() {
        item = ContentOffsetDynamicItem(scrollView: collectionView)
        animator = UIDynamicAnimator(referenceView: collectionView)
        
        let edge = -snapPoint
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout.invalidateLayout()
        setBehaviors(toTop: true)
    }
    
    // MARK: SetPositions
    func setPositions(offsetFromTop: CGFloat) {
        setBackgroundPosition(offsetFromTop: offsetFromTop)
        setHeaderPosition(offsetFromTop: offsetFromTop)
        setParallexPosition(offsetFromTop: offsetFromTop)
    }
    
    func setBackgroundPosition(offsetFromTop: CGFloat) {
        
        let range = extendedHeight - snapPoint
        let inrangeOffset = clamp(value: offsetFromTop, min: snapPoint, max: extendedHeight) - snapPoint
        
        let aboveRange = snapPoint / 2
        let aboceInrangeOffset = clamp(value: offsetFromTop - headerHeight, min: 0, max: snapPoint / 2)
        
        backgroundView?.updateView(offsetFromTop: offsetFromTop - backgroundViewOffset - headerMargin, inSnapRangeFractionCompleate: inrangeOffset / range, aboveSnapRangeFractionCompleate: aboceInrangeOffset / aboveRange)
    }
    
    func setHeaderPosition(offsetFromTop: CGFloat) {
        headerView?.offsetFromTop = max(offsetFromTop - headerHeight - headerMargin, 0)

        let range = snapPoint - headerHeight
        let inRangeOffset = clamp(value: offsetFromTop - headerHeight, min: 0, max: range)
        headerView?.backgroundAnimationFractionCompleate = inRangeOffset / range
    }
    
    func setParallexPosition(offsetFromTop: CGFloat) {
        guard let frame = parallexDelegate?.frame else {
            return
        }
        let destination = (snapPoint - headerMargin - headerHeight / 2) / 2
        let offset = frame.height / 2 + frame.origin.x - destination
        
        let range = extendedHeight - snapPoint
        let inrangeOffset = clamp(value: offsetFromTop, min: snapPoint, max: extendedHeight) - snapPoint
        let inRangeFractionCompleate = inrangeOffset / range
        
        let transform = CGAffineTransform(translationX: 0, y: -(offset * (1 - inRangeFractionCompleate)))
        parallexDelegate?.scrollDidChange(transform: transform)
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fatalError("The subclass should override this func")
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError("The subclass should override this func")
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
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
        setPositions(offsetFromTop: clamp(value: -scrollView.contentOffset.y, min: 0, max: extendedHeight))
    }
    
    private func setBehaviors(toTop: Bool) {
        if toTop {
            let edge = -snapPoint
            attach.anchorPoint = CGPoint(x: 0, y: edge)
            //attach.frequency = 3.5
        } else {
            attach.anchorPoint = CGPoint(x: 0, y: -extendedHeight)
            //attach.frequency = 0
        }
        animator.addBehavior(attach)
        animator.addBehavior(itemBehavior)
        
        collectionView.decelerationRate = .init(rawValue: 0)
    }
    
    private func isInSnapRange(point: CGPoint? = nil) -> Bool {
        return (point ?? collectionView.contentOffset).y < -snapPoint
    }
    
    private func isInBottomHalfOfSnapRange() -> Bool {
        return collectionView.contentOffset.y < -snapPoint - upRangeHeight / 2
    }
}

class MyFlowLaytou: UICollectionViewFlowLayout {
    
}
