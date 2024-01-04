//
//  CustomButton.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/01/24.
//

import UIKit

class GeneralButton: UIView {
    
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
        self.addSubview(view)
    }
    
}

extension GeneralButton {
    
    func configure(title: String) {
        titleLabel.text = title
        self.makeCornerRadius(8)
    }
    
}
