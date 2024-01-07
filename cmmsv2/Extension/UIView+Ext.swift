//
//  UIView+Ext.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import Foundation
import UIKit

extension UIView {
    
    public func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
    }
    
    func makeCornerRadius(_ radius: CGFloat, _ maskedCorner: CACornerMask? = nil) {
        layer.cornerRadius = radius
        layer.maskedCorners = maskedCorner ?? [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        clipsToBounds = true
    }
    
    func gesture(_ gestureType: GestureType = .tap()) -> GesturePublisher {
        .init(view: self, gestureType: gestureType)
    }
    
    func addBorder(width: CGFloat = 1, colorBorder: CGColor = UIColor.white.cgColor) {
        layer.borderWidth = width
        layer.borderColor = colorBorder
    }
    
    func addDashedBorder(width: CGFloat = 1, colorBorder: CGColor = UIColor.white.cgColor) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = colorBorder
        shapeLayer.lineWidth = width
        shapeLayer.lineDashPattern = [8, 4]
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        let path = UIBezierPath(rect: bounds)
        shapeLayer.path = path.cgPath
        
        layer.addSublayer(shapeLayer)
    }
    
    func animateShowView(_ duration: TimeInterval = 0.5, _ delay: TimeInterval = 0) {
        UIView.animate(withDuration: duration, delay: delay, options: [.curveEaseIn],
                       animations: {
            self.center.y -= self.bounds.height
            self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    
    func addShadow(_ radius: CGFloat, position: ShadowPosition = .defaultShadow, color: CGColor? = UIColor.customPrimaryColor.cgColor) {
        layer.shadowColor = color
        layer.shadowRadius = radius
        layer.shadowOpacity = 0.6
        layer.masksToBounds = false
        
        switch position {
        case .left:
            layer.shadowOffset = CGSize(width: -2.0, height: 0)
        case .right:
            layer.shadowOffset = CGSize(width: 2.0, height: 0)
        case .top:
            layer.shadowOffset = CGSize(width: 0, height: -2.0)
        case .bottom:
            layer.shadowOffset = CGSize(width: 0, height: 2.0)
        case .defaultShadow:
            layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    }
    
}

enum ShadowPosition {
    case left
    case right
    case top
    case bottom
    case defaultShadow
}