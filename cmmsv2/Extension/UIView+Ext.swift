//
//  UIView+Ext.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import Foundation
import UIKit

enum LinePosition {
    case top
    case bottom
    case left
    case right
    case all
}

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
    
    func addBorder(width: CGFloat = 1, colorBorder: UIColor = .white, position: LinePosition? = nil) {
        let borderColor = colorBorder.cgColor
        
        if let position = position {
            let border = CALayer()
            border.backgroundColor = borderColor
            
            switch position {
            case .top:
                border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: width)
            case .bottom:
                border.frame = CGRect(x: 0, y: self.frame.height - width, width: self.frame.width, height: width)
            case .left:
                border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.height)
            case .right:
                border.frame = CGRect(x: self.frame.width - width, y: 0, width: width, height: self.frame.height)
            case .all:
                self.addBorder(width: width, colorBorder: colorBorder, position: .top)
                self.addBorder(width: width, colorBorder: colorBorder, position: .bottom)
                self.addBorder(width: width, colorBorder: colorBorder, position: .left)
                self.addBorder(width: width, colorBorder: colorBorder, position: .right)
            }
            
            self.layer.addSublayer(border)
        } else {
            self.layer.borderWidth = width
            self.layer.borderColor = borderColor
        }
    }
    
    func animateShowView(_ duration: TimeInterval = 0.5, _ delay: TimeInterval = 0) {
        UIView.animate(withDuration: duration, delay: delay, options: [.curveEaseIn],
                       animations: {
            self.center.y -= self.bounds.height
            self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    
    func addShadow(_ radius: CGFloat, position: ShadowPosition = .allSides, color: CGColor? = UIColor.customDarkGrayColor.cgColor, opacity: Float? = 0.6) {
        layer.shadowColor = color
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity ?? 0.6
        layer.masksToBounds = false
        layer.shadowOffset = position.offset
    }
    
    func addDashedBorder(position: UIRectEdge, width: CGFloat = 1, colorBorder: CGColor = UIColor.white.cgColor, rounded: Bool = false) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = colorBorder
        shapeLayer.lineWidth = width
        shapeLayer.lineDashPattern = [8, 4]
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        var path: UIBezierPath
        
        switch position {
        case .top:
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        case .bottom:
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: self.bounds.height))
            path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        case .left:
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: self.bounds.height))
        case .right:
            path = UIBezierPath()
            path.move(to: CGPoint(x: self.bounds.width, y: 0))
            path.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        default:
            path = rounded ? UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius) : UIBezierPath(rect: self.bounds)
        }
        
        shapeLayer.path = path.cgPath
        layer.addSublayer(shapeLayer)
    }
    
    
    func makeAnimation(duration: TimeInterval = 0.3, animations: @escaping () -> Void, completion: (() -> Void)? = nil) {
        UIView.transition(with: self,
                          duration: duration,
                          options: .transitionCrossDissolve,
                          animations: {
            animations()
        },
                          completion: { _ in
            completion?()
        })
    }
    
    func createProgressBar(value: Float, color: UIColor, labelText: String) -> UIView {
        let container = UIView()
        let label = UILabel()
        label.text = labelText
        label.font = UIFont.robotoRegular(10)
        label.textColor = .customPlaceholderColor
        
        let progressBar = UIProgressView(progressViewStyle: .default)
        progressBar.progress = value
        progressBar.tintColor = color
        
        container.addSubview(label)
        container.addSubview(progressBar)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            label.topAnchor.constraint(equalTo: container.topAnchor),
            
            progressBar.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            progressBar.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 4),
            progressBar.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            progressBar.heightAnchor.constraint(equalToConstant: 6)
        ])
        
        return container
    }
    
}

enum ShadowPosition {
    case left
    case right
    case top
    case bottom
    case allSides
    
    var offset: CGSize {
        switch self {
        case .left:
            return CGSize(width: -2.0, height: 0)
        case .right:
            return CGSize(width: 2.0, height: 0)
        case .top:
            return CGSize(width: 0, height: -2.0)
        case .bottom:
            return CGSize(width: 0, height: 2.0)
        case .allSides:
            return CGSize(width: 0, height: 0)
        }
    }
}
