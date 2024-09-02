//
//  StatisticalSummaryCardView.swift
//  cmmsv2
//
//  Created by macbook  on 30/08/24.
//

import UIKit
import DGCharts

struct StatisticalSummaryDataSet {
    let targetEntry: BarChartDataEntry
    let realizationEntry: BarChartDataEntry
}

class StatisticalSummaryCardView: UIView {
    
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
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
    }
    
    func configure(
        title: NSAttributedString,
        description: String,
        target: String,
        realization: String,
        achievement: String,
        _ statistic: StatisticalSummaryDataSet) {
            self.targetValueLabel.text = target
            self.realizationValueLabel.text = realization
            self.achievementValueLabel.text = achievement
            self.setupChart(statistic)
            self.titleLabel.attributedText = title
            self.descriptionLabel.text = description
        }
    
    func setupChart(_ data: StatisticalSummaryDataSet) {
        let targetEntry = data.targetEntry
        let realizationEntry = data.realizationEntry
        
        let targetDataSet = BarChartDataSet(entries: [targetEntry], label: "Target")
        targetDataSet.colors = [UIColor.customPrimaryColor]
        
        let realizationDataSet = BarChartDataSet(entries: [realizationEntry], label: "Realisasi")
        realizationDataSet.colors = [UIColor.customLightGrayColor]
        
        let barChartData = BarChartData(dataSets: [targetDataSet, realizationDataSet])
        barChartData.barWidth = 0.3
        
        barChartView.data = barChartData
        
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["Target", "Realisasi"])
        barChartView.xAxis.granularity = 1
        barChartView.leftAxis.axisMinimum = 0
        barChartView.rightAxis.enabled = false
        barChartView.animate(yAxisDuration: 1.5)
        barChartView.legend.enabled = false
    }
    
}
