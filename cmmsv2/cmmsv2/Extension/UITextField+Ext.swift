//
//  UITextField+Ext.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import Foundation
import UIKit

extension UITextField {
    
    func configurePlaceHolder(font: UIFont, color: UIColor, placeHolderText: String) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: font
        ]
        let attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: attributes)
        self.attributedPlaceholder = attributedPlaceholder
    }
}

