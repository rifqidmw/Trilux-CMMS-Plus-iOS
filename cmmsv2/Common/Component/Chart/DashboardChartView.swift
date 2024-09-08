//
//  DashboardChartView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 22/08/24.
//

import UIKit
import Combine
import DGCharts

struct ChartAppearanceEntity {
    let titleSection: String
    let pieEntries: [PieChartDataEntry]?
    let pieDataSet: PieChartDataSet?
    let pieChartColors: [UIColor]
    let centerPieChartText: String?
    let pieChartTitleText: String?
    let chartCount: String?
    let barStatistic: [WOStatistic]?
}

enum DashboardChartType {
    case complaint
    case corrective
    case medic
    case nonMedic
}

protocol DashboardChartViewDelegate: AnyObject {
    func didTapBarChart(type: DashboardChartType)
}

class DashboardChartView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerPieChartView: UIView!
    @IBOutlet weak var pieChartTitleLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var containerPieChartWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerBarChartView: UIView!
    @IBOutlet weak var containerProgressBarStackView: UIStackView!
    
    var type: DashboardChartType?
    var anyCancellable = Set<AnyCancellable>()
    weak var delegate: DashboardChartViewDelegate?
    
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
        self.configureSharedComponent()
        self.setupAction()
    }
    
}

extension DashboardChartView {
    
    private func setupAction() {
        self.containerBarChartView.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate = self.delegate,
                      let type
                else { return }
                delegate.didTapBarChart(type: type)
            }
            .store(in: &anyCancellable)
    }
    
    private func configureSharedComponent() {
        self.containerView.makeCornerRadius(8)
        self.containerView.addShadow(4.0, opacity: 0.2)
        
        self.containerPieChartView.makeCornerRadius(8)
        self.containerPieChartView.addShadow(4, position: .bottom, opacity: 0.2)
        
        self.containerBarChartView.makeCornerRadius(8)
        self.containerBarChartView.addShadow(4, position: .bottom, opacity: 0.2)
        
        self.containerPieChartWidthConstraint.constant = CGSize.widthDevice / 3
    }
    
    func configure(_ appearance: ChartAppearanceEntity, from type: DashboardChartType) {
        self.type = type
        self.titleLabel.text = appearance.titleSection
        self.pieChartTitleLabel.text = appearance.pieChartTitleText
        self.setupPieChart(appearance)
        self.setupBarChart(appearance)
    }
    
    private func setupPieChart(_ appearance: ChartAppearanceEntity) {
        guard let pieDataSet = appearance.pieDataSet else { return }
        appearance.pieDataSet?.colors = appearance.pieChartColors
        appearance.pieDataSet?.valueTextColor = .clear
        appearance.pieDataSet?.entryLabelColor = .clear
        
        pieChartView.data = PieChartData(dataSet: pieDataSet)
        pieChartView.centerText = appearance.centerPieChartText ?? "-"
        pieChartView.legend.enabled = false
        pieChartView.holeRadiusPercent = 0.5
        pieChartView.frame = containerPieChartView.bounds
        pieChartView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func setupBarChart(_ appearance: ChartAppearanceEntity) {
        containerProgressBarStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        guard let barStatistic = appearance.barStatistic, !barStatistic.isEmpty else { return }
        
        for (index, statistic) in barStatistic.enumerated() {
            let progressValue = (Float(statistic.count ?? "") ?? 0) / 100.0
            let labelText = "\(statistic.name ?? "") - \(statistic.count ?? "")/\(appearance.chartCount ?? "")"
            
            let color = index < appearance.pieChartColors.count ? appearance.pieChartColors[index] : UIColor.gray
            
            let progressBarView = createProgressBar(value: progressValue, color: color, labelText: labelText)
            
            containerProgressBarStackView.addArrangedSubview(progressBarView)
        }
    }
    
}
