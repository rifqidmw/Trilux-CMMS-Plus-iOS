//
//  CustomButton.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/01/24.
//

import UIKit

class GeneralButton: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var iconMagnifyingGlass: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
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
        view.makeCornerRadius(8)
        self.addSubview(view)
    }
    
}

extension GeneralButton {
    
    func configure(title: String? = nil, type: GeneralButtonType = .normal, icon: String? = nil, backgroundColor: UIColor? = UIColor.customPrimaryColor, titleColor: UIColor? = UIColor.white) {
        titleLabel.text = title ?? ""
        titleLabel.textColor = titleColor
        iconImageView.image = UIImage(named: icon ?? "")
        
        searchLabel.isHidden = true
        iconImageView.isHidden = true
        searchLabel.isHidden = true
        iconMagnifyingGlass.isHidden = true
        containerView.backgroundColor = backgroundColor
        
        switch type {
        case .normal:
            titleLabel.isHidden = false
        case .searchbutton:
            titleLabel.isHidden = true
            searchLabel.isHidden = false
            iconMagnifyingGlass.isHidden = false
            containerView.backgroundColor = UIColor.white
            containerView.makeCornerRadius(8)
            containerView.addShadow(4, color: UIColor.customDarkGrayColor.cgColor, opacity: 0.2)
        case .withIcon:
            titleLabel.isHidden = false
            iconImageView.isHidden = false
        case .bordered:
            containerView.addBorder(width: 1, colorBorder: UIColor.customPlaceholderColor)
            containerView.backgroundColor = .clear
            titleLabel.isHidden = false
            titleLabel.textColor = UIColor.customPlaceholderColor
        case .borderedWithIcon:
            containerView.addBorder(width: 1, colorBorder: UIColor.customPlaceholderColor)
            containerView.backgroundColor = .clear
            titleLabel.isHidden = false
            iconImageView.isHidden = false
        }
    }
    
}

enum GeneralButtonType {
    case normal
    case withIcon
    case searchbutton
    case bordered
    case borderedWithIcon
}
