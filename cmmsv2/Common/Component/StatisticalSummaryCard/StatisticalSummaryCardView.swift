//
//  StatisticalSummaryCardView.swift
//  cmmsv2
//
//  Created by macbook  on 30/08/24.
//

import UIKit
import DGCharts

class StatisticalSummaryCardView: UIView {
    
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var containerSummaryView: UIView!
    @IBOutlet weak var targetValueLabel: UILabel!
    @IBOutlet weak var realizationValueLabel: UILabel!
    @IBOutlet weak var achievementValueLabel: UILabel!
    
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
