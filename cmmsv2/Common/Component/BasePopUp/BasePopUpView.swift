//
//  CustomPopUpView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/01/24.
//

import UIKit

class BasePopUpView: UIView {
    
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var agreeButton: GeneralButton!
    @IBOutlet weak var cancelButton: GeneralButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        let view = loadNib()
        view.frame = self.bounds
        self.addSubview(view)
    }
    
}

extension BasePopUpView {
    
    func configureView(icon: String, title: String, firstMessage: String, boldText: String, secondMessage: String, leftButtonTitle: String, rightButtonTitle: String) {
        
        let firstMessageText = NSAttributedString.stylizedText(firstMessage, font: UIFont.robotoRegular(14), color: UIColor.customPlaceholderColor)
        let highlightedText = NSAttributedString.stylizedText(boldText, font: UIFont.robotoBold(14), color: UIColor.customPrimaryColor)
        let secondMessageText = NSAttributedString.stylizedText(secondMessage, font: UIFont.robotoRegular(14), color: UIColor.customPlaceholderColor)
        
        let fullAttributedText = NSMutableAttributedString()
        fullAttributedText.append(firstMessageText)
        fullAttributedText.append(highlightedText)
        fullAttributedText.append(secondMessageText)

        messageLabel.attributedText = fullAttributedText
        iconImageView.image = UIImage(named: icon)
        titleLabel.text = title
        agreeButton.configure(title: leftButtonTitle, type: .bordered)
        cancelButton.configure(title: rightButtonTitle)
    }
    
}
