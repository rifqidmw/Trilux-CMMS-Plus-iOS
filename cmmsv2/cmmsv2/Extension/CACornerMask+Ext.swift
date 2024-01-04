//
//  CACornerMask+Ext.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import UIKit

extension CACornerMask {
    static let topCurve: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    static let bottomCurve: CACornerMask = [.layerMinXMaxYCorner, layerMaxXMaxYCorner]
    static let leftCurve: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    static let rightCurve: CACornerMask = [.layerMaxXMinYCorner, layerMaxXMaxYCorner]
    static let bottomRightCurve: CACornerMask = [.layerMaxXMaxYCorner]
}

