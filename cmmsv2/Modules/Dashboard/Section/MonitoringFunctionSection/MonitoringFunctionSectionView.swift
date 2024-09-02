//
//  MonitoringFunctionSectionView.swift
//  cmmsv2
//
//  Created by macbook  on 29/08/24.
//

import UIKit
import DGCharts

class MonitoringFunctionSectionView: UIView {
    
    @IBOutlet weak var monitoringFunctionInspectionView: StatisticalSummaryCardView!
    @IBOutlet weak var monitoringFunctionQuarterView: StatisticalSummaryCardView!
    @IBOutlet weak var preventiveInspectionView: StatisticalSummaryCardView!
    @IBOutlet weak var preventiveQuarterView: StatisticalSummaryCardView!
    
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

extension MonitoringFunctionSectionView {
    
    func configure(_ data: DashboardEngineerContent) {
        self.setupInspectionMonitoring(data)
        self.setupTriwulanMonitoring(data)
        
        self.setupInspectionPreventive(data)
        self.setupTriwulanPreventive(data)
    }
    
    private func setupInspectionMonitoring(_ data: DashboardEngineerContent?) {
        let normalMonitoringText = NSAttributedString.stylizedText("Pemantauan Fungsi", font: UIFont.robotoRegular(12), color: UIColor.customPlaceholderColor)
        
        let firstTargetEntry = BarChartDataEntry(x: 0, y: Double(data?.bulanIni?.targetInspeksi ?? "") ?? 0)
        let firstRealizationEntry = BarChartDataEntry(x: 1, y: Double(data?.bulanIni?.realisasiInspeksi ?? 0))
        let inspectionMonitoringDataSet = StatisticalSummaryDataSet(targetEntry: firstTargetEntry, realizationEntry: firstRealizationEntry)
        
        self.monitoringFunctionInspectionView.configure(
            title: normalMonitoringText,
            description: "Inspeksi Bulan \(String.getCurrentDateString("MMMM yyyy"))",
            target: "\(data?.bulanIni?.targetInspeksi ?? "")",
            realization: "\(data?.bulanIni?.realisasiInspeksi ?? 0)",
            achievement: "\(data?.bulanIni?.persenInspeksi ?? 0)%",
            inspectionMonitoringDataSet)
    }
    
    private func setupTriwulanMonitoring(_ data: DashboardEngineerContent?) {
        let normalTriwulanMonitoringText = NSAttributedString.stylizedText("Pemantauan Fungsi ", font: UIFont.robotoRegular(12), color: UIColor.customPlaceholderColor)
        
        let boldTriwulanMonitoringText = NSAttributedString.stylizedText("Triwulan III \(String.getCurrentDateString("yyyy"))", font: UIFont.robotoBold(12), color: UIColor.customDarkGrayColor)
        
        let fullTriwulanMonitoringText = NSMutableAttributedString()
        fullTriwulanMonitoringText.append(normalTriwulanMonitoringText)
        fullTriwulanMonitoringText.append(boldTriwulanMonitoringText)
        
        let firstTargetEntry = BarChartDataEntry(x: 0, y: Double(data?.kwartal?.targetInspeksi ?? 0))
        let firstRealizationEntry = BarChartDataEntry(x: 1, y: Double(data?.kwartal?.realisasiInspeksi ?? 0))
        let inspectionMonitoringDataSet = StatisticalSummaryDataSet(targetEntry: firstTargetEntry, realizationEntry: firstRealizationEntry)
        
        self.monitoringFunctionQuarterView.configure(
            title: fullTriwulanMonitoringText,
            description: data?.kwartal?.data?.textBulan ?? "",
            target: "\(data?.kwartal?.targetInspeksi ?? 0)",
            realization: "\(data?.kwartal?.realisasiInspeksi ?? 0)",
            achievement: "\(data?.kwartal?.persenInspeksi ?? 0)%",
            inspectionMonitoringDataSet)
    }
    
    private func setupInspectionPreventive(_ data: DashboardEngineerContent?) {
        let normalPreventiveText = NSAttributedString.stylizedText("Pemantauan Fungsi", font: UIFont.robotoRegular(12), color: UIColor.customPlaceholderColor)
        
        let firstTargetEntry = BarChartDataEntry(x: 0, y: Double(data?.bulanIni?.targetPreventif ?? "") ?? 0)
        let firstRealizationEntry = BarChartDataEntry(x: 1, y: Double(data?.bulanIni?.realisasiPreventif ?? 0))
        let inspectionMonitoringDataSet = StatisticalSummaryDataSet(targetEntry: firstTargetEntry, realizationEntry: firstRealizationEntry)
        
        self.preventiveInspectionView.configure(
            title: normalPreventiveText,
            description: "Preventif Bulan \(String.getCurrentDateString("MMMM yyyy"))",
            target: "\(data?.bulanIni?.targetPreventif ?? "")",
            realization: "\(data?.bulanIni?.realisasiPreventif ?? 0)",
            achievement: "\(data?.bulanIni?.persenPreventif ?? 0)%",
            inspectionMonitoringDataSet)
    }
    
    private func setupTriwulanPreventive(_ data: DashboardEngineerContent?) {
        let normalTriwulanPreventiveText = NSAttributedString.stylizedText("Preventive ", font: UIFont.robotoRegular(12), color: UIColor.customPlaceholderColor)
        
        let boldTriwulanPreventiveText = NSAttributedString.stylizedText("Triwulan III \(String.getCurrentDateString("yyyy"))", font: UIFont.robotoBold(12), color: UIColor.customDarkGrayColor)
        
        let fullTriwulanPreventiveText = NSMutableAttributedString()
        fullTriwulanPreventiveText.append(normalTriwulanPreventiveText)
        fullTriwulanPreventiveText.append(boldTriwulanPreventiveText)
        
        let firstTargetEntry = BarChartDataEntry(x: 0, y: Double(data?.kwartal?.targetPreventif ?? 0))
        let firstRealizationEntry = BarChartDataEntry(x: 1, y: Double(data?.kwartal?.realisasiPreventif ?? 0))
        let inspectionMonitoringDataSet = StatisticalSummaryDataSet(targetEntry: firstTargetEntry, realizationEntry: firstRealizationEntry)
        
        self.preventiveQuarterView.configure(
            title: fullTriwulanPreventiveText,
            description: data?.kwartal?.data?.textBulan ?? "",
            target: "\(data?.kwartal?.targetPreventif ?? 0)",
            realization: "\(data?.kwartal?.realisasiPreventif ?? 0)",
            achievement: "\(data?.kwartal?.persenPreventif ?? 0)%",
            inspectionMonitoringDataSet)
    }
    
}
