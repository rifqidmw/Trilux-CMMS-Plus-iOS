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
    
    func configure(title: String? = nil, type: GeneralButtonType = .normal) {
        titleLabel.text = title ?? ""
        searchLabel.isHidden = true
        
        switch type {
        case .normal:
            iconMagnifyingGlass.isHidden = true
        case .searchbutton:
            titleLabel.isHidden = true
            searchLabel.isHidden = false
            
            containerView.backgroundColor = UIColor.white
            containerView.makeCornerRadius(8)
            containerView.addShadow(4, color: UIColor.customDarkGray.cgColor, opacity: 0.2)
        }
    }
    
}

enum GeneralButtonType {
    case normal
    case searchbutton
}
