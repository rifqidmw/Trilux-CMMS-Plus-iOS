//
//  ComplaintChartSectionView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 19/08/24.
//

import UIKit
import DGCharts

class ComplaintChartSectionView: UIView {
    
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var horizontalBarChartView: HorizontalBarChartView!
    
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
        
        self.containerStackView.makeCornerRadius(8)
        self.containerStackView.addShadow(2, position: .bottom, opacity: 0.2)
        
        self.setupPieChart()
        self.setupBarChart()
    }
    
}

extension ComplaintChartSectionView {
    
    private func setupPieChart() {
        let entries = [
            PieChartDataEntry(value: 96, label: "Open"),
            PieChartDataEntry(value: 7, label: "Progress"),
            PieChartDataEntry(value: 10, label: "Finish")
        ]
        
        let dataSet = PieChartDataSet(
            entries: entries,
            label: "Total Pengaduan")
        dataSet.colors = [UIColor.systemBlue, UIColor.systemYellow, UIColor.systemGreen]
        dataSet.valueTextColor = .black
        dataSet.entryLabelColor = .black
        
        pieChartView.data = PieChartData(dataSet: dataSet)
        pieChartView.centerText = "113"
        pieChartView.holeRadiusPercent = 0.5
    }
    
    private func setupBarChart() {
        let barEntries = [
            BarChartDataEntry(x: 0, y: 96),
            BarChartDataEntry(x: 1, y: 7),
            BarChartDataEntry(x: 2, y: 10)
        ]
        
        let barDataSet = BarChartDataSet(entries: barEntries, label: "")
        barDataSet.colors = [UIColor.systemBlue, UIColor.systemYellow, UIColor.systemGreen]
        barDataSet.valueTextColor = .black
        horizontalBarChartView.data = BarChartData(dataSet: barDataSet)
        horizontalBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["Open", "Progress", "Finish"])
        horizontalBarChartView.xAxis.granularity = 1
        horizontalBarChartView.xAxis.labelPosition = .bottom
        horizontalBarChartView.leftAxis.enabled = false
        horizontalBarChartView.rightAxis.enabled = false
        horizontalBarChartView.legend.enabled = false
        horizontalBarChartView.animate(yAxisDuration: 1.0)
    }
    
}
