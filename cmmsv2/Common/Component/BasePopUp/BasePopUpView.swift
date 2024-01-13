//
//  CustomPopUpView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/01/24.
//

import UIKit

class BasePopUpView: UIView {
    
    @IBOutlet weak var bottomSheetView: BottomSheetView!
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
    
    func configureView(icon: String, title: String, message: String, leftButtonTitle: String, rightButtonTitle: String) {
        iconImageView.image = UIImage(named: icon)
        titleLabel.text = title
        messageLabel.text = message
        agreeButton.configure(title: leftButtonTitle, type: .bordered)
        cancelButton.configure(title: rightButtonTitle)
    }
    
}
