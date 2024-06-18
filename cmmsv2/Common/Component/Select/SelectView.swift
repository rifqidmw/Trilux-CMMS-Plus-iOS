//
//  SelectView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/06/24.
//

import UIKit

class SelectView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectContainerView: UIView!
    @IBOutlet weak var placeholderTitleLabel: UILabel!
    
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
        self.selectContainerView.makeCornerRadius(8)
    }
    
}

extension SelectView {
    
    func configure(title: String, placeHolder: String, value: String?) {
        self.titleLabel.text = title
        self.placeholderTitleLabel.text = placeHolder
    }
    
}
