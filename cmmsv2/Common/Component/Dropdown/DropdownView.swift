//
//  DropdownView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/02/24.
//

import UIKit

class DropdownView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconAccordionImageView: UIImageView!
    
    var data: [String] = []
    
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
        view.makeCornerRadius(8)
    }
    
}

extension DropdownView {
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
}
