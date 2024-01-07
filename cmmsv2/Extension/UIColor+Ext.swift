//
//  UIColor+Ext.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 06/01/24.
//

import Foundation
import UIKit

extension UIColor {
    
    // MARK: - Additional
    static let customPrimaryColor     = #colorLiteral(red: 0, green: 0.6901960784, blue: 0.8784313725, alpha: 1)
    static let customSecondaryColor   = #colorLiteral(red: 0.7607843137, green: 0.9490196078, blue: 1, alpha: 1)
    static let customDarkGrayColor    = #colorLiteral(red: 0.3176470588, green: 0.3176470588, blue: 0.3176470588, alpha: 1)
    static let customLightGrayColor   = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
    static let placeholderColor       = #colorLiteral(red: 0.7882352941, green: 0.7882352941, blue: 0.7882352941, alpha: 1)
    static let darkYellow             = #colorLiteral(red: 0.9882352941, green: 0.7450980392, blue: 0.1333333333, alpha: 1)
    static let lightYellow            = #colorLiteral(red: 0.9960784314, green: 0.9294117647, blue: 0.7647058824, alpha: 1)
    static let customGreenColor       = #colorLiteral(red: 0.3803921569, green: 0.7411764706, blue: 0.5058823529, alpha: 1)
    static let lightGreen             = #colorLiteral(red: 0.8862745098, green: 0.9529411765, blue: 0.9098039216, alpha: 1)
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        // swiftlint:disable identifier_name
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}