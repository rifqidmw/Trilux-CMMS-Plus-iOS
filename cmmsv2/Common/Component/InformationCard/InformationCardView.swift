//
//  InformationCardView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 11/01/24.
//

import UIKit
import SkeletonView

class InformationCardView: UIView {
    
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
        view.makeCornerRadius(8)
        
        self.addSubview(view)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.makeCornerRadius(8)
        self.isSkeletonable = true
        self.showAnimatedGradientSkeleton()
    }
    
}

extension InformationCardView {
    
    func configureView(title: String, value: String) {
        self.hideSkeleton()
        self.valueLabel.hideSkeleton()
        
        titleLabel.text = title
        valueLabel.text = value
    }
    
}
