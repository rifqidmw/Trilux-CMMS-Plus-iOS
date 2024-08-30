//
//  StatisticalSummaryCardView.swift
//  cmmsv2
//
//  Created by macbook  on 30/08/24.
//

import UIKit

class StatisticalSummaryCardView: UIView {
    
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
