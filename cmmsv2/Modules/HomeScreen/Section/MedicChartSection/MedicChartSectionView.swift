//
//  MedicChartSectionView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 19/08/24.
//

import UIKit
import DGCharts

enum MedicChartType {
    case medic
    case nonMedic
}

class MedicChartSectionView: UIView {
    
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var horizontalBarChartView: HorizontalBarChartView!
    
    var type: MedicChartType?
    
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

extension MedicChartSectionView {
    
    private func setupPieChart() {
        var entries = [
            PieChartDataEntry(value: 4632, label: "Baik"),
            PieChartDataEntry(value: 92, label: "Rusak"),
            PieChartDataEntry(value: 2, label: "Rusak Berat"),
            PieChartDataEntry(value: 3, label: "Tidak Operasi"),
            PieChartDataEntry(value: 3, label: "Decom")
        ]
        var centerText = "4729"
        
        let dataSet = PieChartDataSet(entries: entries, label: "Total")
        dataSet.colors = [UIColor.systemBlue, UIColor.systemYellow, UIColor.systemRed, UIColor.systemGray, UIColor.systemPurple]
        dataSet.valueTextColor = .black
        dataSet.entryLabelColor = .black
        
        pieChartView.data = PieChartData(dataSet: dataSet)
        pieChartView.centerText = centerText
        pieChartView.holeRadiusPercent = 0.5
    }
    
    private func setupBarChart() {
        var barEntries = [
            BarChartDataEntry(x: 0, y: 4632),
            BarChartDataEntry(x: 1, y: 92),
            BarChartDataEntry(x: 2, y: 2),
            BarChartDataEntry(x: 3, y: 3),
            BarChartDataEntry(x: 4, y: 3)
        ]
        var labels = ["Baik", "Rusak", "Rusak Berat", "Tidak Operasi", "Decom"]
        
        let barDataSet = BarChartDataSet(entries: barEntries, label: "")
        barDataSet.colors = [UIColor.systemBlue, UIColor.systemYellow, UIColor.systemRed, UIColor.systemGray, UIColor.systemPurple]
        barDataSet.valueTextColor = .black
        
        horizontalBarChartView.data = BarChartData(dataSet: barDataSet)
        horizontalBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: labels)
        horizontalBarChartView.xAxis.granularity = 1
        horizontalBarChartView.xAxis.labelPosition = .bottom
        horizontalBarChartView.leftAxis.enabled = false
        horizontalBarChartView.rightAxis.enabled = false
        horizontalBarChartView.legend.enabled = false
        horizontalBarChartView.animate(yAxisDuration: 1.0)
    }
    
}
