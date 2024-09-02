//
//  ProfileInformationCardView.swift
//  cmmsv2
//
//  Created by macbook  on 29/08/24.
//

import UIKit

class ProfileInformationCardView: UIView {
    
    @IBOutlet weak var profileIconImageView: UIImageView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
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
        self.makeCornerRadius(16)
        self.addBorder(width: 1.0, colorBorder: UIColor.customPlaceholderColor)
    }
    
}

extension ProfileInformationCardView {
    
    func configure(image: String, title: String, _ value: String) {
        self.profileIconImageView.image = UIImage(named: image)
        self.titleLabel.text = title
        self.valueLabel.text = value
    }
    
}
