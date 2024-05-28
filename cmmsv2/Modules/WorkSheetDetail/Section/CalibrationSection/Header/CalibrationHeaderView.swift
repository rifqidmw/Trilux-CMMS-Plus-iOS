//
//  CalibrationHeaderView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 28/05/24.
//

import UIKit

class CalibrationHeaderView: UIView {
    
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
