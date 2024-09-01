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
        self.configureView()
    }
    
}

extension StatisticalSummaryCardView {
    
    private func configureView() {
        self.containerSummaryView.makeCornerRadius(16)
        self.containerSummaryView.addShadow(2.0, opacity: 0.2)
        self.setupChart()
    }
    
    func configure(target: String, realization: String, achievement: String) {
        self.targetValueLabel.text = target
        self.realizationValueLabel.text = realization
        self.achievementValueLabel.text = achievement
    }
    
    func setupChart() {
        let targetEntry = BarChartDataEntry(x: 0, y: 75)
        let realizationEntry = BarChartDataEntry(x: 1, y: 0)
        
        let targetDataSet = BarChartDataSet(entries: [targetEntry], label: "Target")
        targetDataSet.colors = [UIColor.lightGray]
        
        let realizationDataSet = BarChartDataSet(entries: [realizationEntry], label: "Realisasi")
        realizationDataSet.colors = [UIColor.systemBlue]
        
        let data = BarChartData(dataSets: [targetDataSet, realizationDataSet])
        data.barWidth = 0.3
        
        barChartView.data = data
        
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["Target", "Realisasi"])
        barChartView.xAxis.granularity = 1
        barChartView.leftAxis.axisMinimum = 0
        barChartView.rightAxis.enabled = false
        barChartView.animate(yAxisDuration: 1.5)
        barChartView.legend.enabled = true
    }
    
}
