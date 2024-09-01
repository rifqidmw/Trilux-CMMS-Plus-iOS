//
//  PerformanceMonitoringSectionView.swift
//  cmmsv2
//
//  Created by macbook  on 01/09/24.
//

import UIKit

class PerformanceMonitoringSectionView: UIView {
    
    @IBOutlet weak var firstSectionTitleLabel: UILabel!
    @IBOutlet weak var firstSectionDescriptionLabel: UILabel!
    @IBOutlet weak var firstSummaryStatisticalCardView: StatisticalSummaryCardView!
    
    @IBOutlet weak var secondSectionTitleLabel: UILabel!
    @IBOutlet weak var secondSectionDescriptionLabel: UILabel!
    @IBOutlet weak var secondSummaryStatisticalCardView: StatisticalSummaryCardView!
    
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

extension PerformanceMonitoringSectionView {
    
    func configure(firstTitle: String, firstDescription: String, secondTitle: String, secondDescription: String) {
        self.firstSectionTitleLabel.text = firstTitle
        self.firstSectionDescriptionLabel.text = firstDescription
        self.secondSectionTitleLabel.text = secondTitle
        self.secondSectionDescriptionLabel.text = secondDescription
    }
    
}
