//
//  UILabel+Ext.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import Foundation
import UIKit

extension UILabel {
    func textWidth(font: UIFont, text: String) -> CGFloat {
        let myText = text as NSString
        
        let rect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(labelSize.width)
    }
    
    func changeFontStyle(text: String, fontFamily: String, fontSize: Int, textColor: UIColor? = nil) {
        let attributedString = NSMutableAttributedString(string: self.text ?? "")
        let customFont = UIFont(name: fontFamily, size: CGFloat(fontSize)) ?? UIFont.systemFont(ofSize: 18)
        let range = ((self.text ?? "") as NSString).range(of: text)
        attributedString.addAttribute(.font, value: customFont, range: range)
        
        if let textColor {
            attributedString.addAttribute(.foregroundColor, value: textColor, range: range)
        }
        
        self.attributedText = attributedString
    }
}