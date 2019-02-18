//
//  BackgroundView.swift
//  BottomSheet
//
//  Created by farhad jebelli on 2/11/19.
//  Copyright © 2019 farhad jebelli. All rights reserved.
//

import UIKit

class BackgroundView: UIView {
    
    var alphaView: UIView!
    
    var shapeLayer: CAShapeLayer {
        return layer as! CAShapeLayer
    }
    var sideMargin: CGFloat = 16
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .clear
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.fillRule = .evenOdd
        
        alphaView = UIView(frame: bounds)
        alphaView.translatesAutoresizingMaskIntoConstraints = true
        addSubview(alphaView)
        alphaView.backgroundColor = .white
        alphaView.alpha = 0
    }
    
    override class var layerClass : AnyClass {
        return CAShapeLayer.self
    }
    
    func updateView(offsetFromTop: CGFloat, inSnapRangeFractionCompleate: CGFloat, aboveSnapRangeFractionCompleate: CGFloat) {
        let overlay = UIBezierPath(rect: bounds)
        let sideMargin = self.sideMargin - inSnapRangeFractionCompleate * self.sideMargin
        let transparent = UIBezierPath(roundedRect: CGRect(x: sideMargin, y: 0, width: bounds.width - 2 * sideMargin, height: offsetFromTop), cornerRadius: 12 * (1 - inSnapRangeFractionCompleate))
        overlay.append(transparent)
        overlay.usesEvenOddFillRule = true
        
        shapeLayer.path = overlay.cgPath
        
        let alpha = 1 - (clamp(value: aboveSnapRangeFractionCompleate, min: 0.2, max: 0.4) - 0.2) / 0.2
        alphaView.alpha = alpha
        
    }
    
    
}
