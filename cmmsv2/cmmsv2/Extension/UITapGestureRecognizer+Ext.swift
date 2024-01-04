//
//  UITapGestureRecognizer+Ext.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import UIKit

extension UITapGestureRecognizer {
    func didTapAttributedTextInLabel(label: UILabel, targetText: String) -> Bool {
        guard let attributedString = label.attributedText, let lblText = label.text else { return false }
        let targetRange = (lblText as NSString).range(of: targetText)
        
        // label correct font for NSTextStorage needed
        let mutableAttribString = NSMutableAttributedString(attributedString: attributedString)
        mutableAttribString.addAttributes(
            [NSAttributedString.Key.font: label.font ?? UIFont.smallSystemFontSize],
            range: NSRange(location: 0, length: attributedString.length)
        )
        
        // Set text alignment for attributed text
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = label.textAlignment
        mutableAttribString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: attributedString.length))
        
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: mutableAttribString)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y:
            locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)

        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
    func didTapAttributedText(in label: UILabel, inRange targetRange: NSRange) -> Bool {
        guard let attributedText = label.attributedText else { return false }

        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: .zero)
        let textStorage = NSTextStorage(attributedString: attributedText)

        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        textContainer.size = label.bounds.size

        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)

        let alignmentOffset = self.alignmentOffset(for: label)

        let textContainerOffset = CGPoint(x: (label.bounds.size.width - textBoundingBox.size.width) * 0.5 - alignmentOffset, y: (label.bounds.size.height - textBoundingBox.size.height) * 0.5)

        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)

        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)

        return NSLocationInRange(indexOfCharacter, targetRange)
    }

    private func alignmentOffset(for label: UILabel) -> CGFloat {
        switch label.textAlignment {
        case .center:
            return 0.5
        case .right:
            return 1.0
        default:
            return 0.0
        }
    }
}

