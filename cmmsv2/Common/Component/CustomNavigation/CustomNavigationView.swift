//
//  CustomNavigationView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/01/24.
//

import UIKit

class CustomNavigationView: UIView {
    
    @IBOutlet weak var containerHomeToolbarView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var notificationDotView: UIView!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    
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

extension CustomNavigationView {
    
    func configure(username: String? = nil, headline: String? = nil, type: CustomNavigationType) {
        switch type {
        case .plain:
            containerHomeToolbarView.isHidden = true
        case .plainToolbar:
            containerHomeToolbarView.isHidden = true
        case .toolbar:
            containerHomeToolbarView.isHidden = true
        case .homeToolbar:
            let text = NSAttributedString.stylizedText("Hai, ", font: UIFont.latoRegular(14), color: UIColor.customDarkGrayColor)
            let usernameText = NSAttributedString.stylizedText(username ?? "", font: UIFont.latoBlack(14), color: UIColor.customPrimaryColor)
            
            let fullAttributedText = NSMutableAttributedString()
            fullAttributedText.append(text)
            fullAttributedText.append(usernameText)

            usernameLabel.attributedText = fullAttributedText
            welcomeLabel.text = "Selamat Datang di \(headline ?? "")"
            
            profileView.makeCornerRadius(25)
            notificationView.makeCornerRadius(25)
            notificationDotView.makeCornerRadius(4)
        case .searchToolbar:
            containerHomeToolbarView.isHidden = true
        }
    }
    
}

enum CustomNavigationType {
    case plain
    case plainToolbar
    case toolbar
    case homeToolbar
    case searchToolbar
}
