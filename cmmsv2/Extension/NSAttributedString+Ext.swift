//
//  NSAttributedString+Ext.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/01/24.
//

import UIKit

extension NSAttributedString {
    
    static func stylizedText(_ text: String, font: UIFont, color: UIColor) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
}
