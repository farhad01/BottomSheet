//
//  ‌‌BottomSheetViewController.swift
//  BottomSheet
//
//  Created by farhad jebelli on 2/9/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import UIKit

public protocol ParallexBackgroundProtocol: class {
    var frame: CGRect {get}
    func scrollDidChange(transform: CGAffineTransform)
}

open class BottomSheetViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    public var collectionView: UICollectionView!
    public var headerView: HeaderView!
    var headerHeightConstraint: NSLayoutConstraint!
    
    var animator: UIDynamicAnimator!
    var attach: UIAttachmentBehavior!
    var itemBehavior: UIDynamicItemBehavior!
    var item: ContentOffsetDynamicItem!
    var layout: UICollectionViewFlowLayout!
    var backgroundView: BackgroundView!
    
    open var headerHeight: CGFloat {
        return 50
    }
    open var headerMargin: CGFloat {
        return 24
    }
    
    
    open var backgroundViewOffset: CGFloat {
        return 10
    }
    open var upRangeHeight: CGFloat = 296
    
    private var extendedHeight: CGFloat {
        return view.frame.height + headerMargin + headerHeight
    }
    
    private var snapPoint: CGFloat {
        return  upRangeHeight
    }
    
    public weak var parallexDelegate: ParallexBackgroundProtocol?
    // MARK: Setup
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupViews()
        setupNavigationController()
        setupCollectionView()
        setupDynamicAnimation()
        setupHeaderView()
    }
    
    private func setupViews() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: guide.topAnchor),
                guide.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor)
                ])
            
        } else {
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0),
                bottomLayoutGuide.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 0)
                ])
        }
        
        headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: headerHeight))
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: headerHeight)
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: collectionView.topAnchor),
            headerHeightConstraint
            ])
        
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func setupCollectionView() {
        layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        
        collectionView.backgroundColor = UIColor.clear
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.contentInset = UIEdgeInsets(top: extendedHeight, left: 0, bottom: 0, right: 0)
        
        backgroundView = BackgroundView(frame: view.frame)
        collectionView.backgroundView = backgroundView
        
    }
    
    func setupHeaderView() {
        headerView.backgroundMarginTo = 24
        headerView.backgroundMarginFrom = -6
        headerHeightConstraint.constant = headerHeight
    }
    
    private func setupDynamicAnimation() {
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
    
    override open func viewDidLayoutSubviews() {
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
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fatalError("The subclass should override this func")
    }

    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError("The subclass should override this func")
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        animator.removeAllBehaviors()
    }
    
    open func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if isInSnapRange() {
            if velocity.y > 0 {
                setBehaviors(toTop: true)
            } else {
                if -scrollView.contentOffset.y < snapPoint + 80 {
                    setBehaviors(toTop: true)
                } else {
                    setBehaviors(toTop: false)
                }
            }
        } else if isInSnapRange(point: targetContentOffset.pointee) {
            setBehaviors(toTop: true)
        } else {
            scrollView.decelerationRate = .normal
        }
    }
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
