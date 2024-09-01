//
//  CalibrationDashboardSectionView.swift
//  cmmsv2
//
//  Created by macbook  on 29/08/24.
//

import UIKit

class CalibrationDashboardSectionView: UIView {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var containerContentStackView: UIStackView!
    @IBOutlet weak var targetPanelView: StatusOverviewPanelView!
    @IBOutlet weak var realizationPanelView: StatusOverviewPanelView!
    @IBOutlet weak var laikPanelView: StatusOverviewPanelView!
    @IBOutlet weak var notLaikPanelView: StatusOverviewPanelView!
    @IBOutlet weak var achievementPanelView: StatusOverviewPanelView!
    
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
        self.containerContentStackView.makeCornerRadius(16)
        self.containerContentStackView.addShadow(2.0, opacity: 0.2)
    }
    
}

extension CalibrationDashboardSectionView {
    
    func configure(_ data: MonthlyData?) {
        self.dateLabel.text = String.getCurrentDateString("MMMM yyyy")
        self.targetPanelView.configure(
            icon: "ic_target_rounded_fill",
            title: "Target",
            iconStatistic: "ic_statistic_arrow_down",
            description: "5% dibanding bulan lalu",
            summary: String(data?.targetKalibrasi ?? 0))
        
        self.realizationPanelView.configure(
            icon: "ic_diagnostic_rounded_fill",
            title: "Realisasi",
            iconStatistic: "ic_statistic_arrow_down",
            description: "5% dibanding bulan lalu",
            summary: String(data?.realisasiKalibrasi ?? 0))
        
        self.laikPanelView.configure(
            icon: "ic_thumb_up_rounded_fill",
            title: "Laik",
            iconStatistic: "ic_statistic_arrow_down",
            description: "5% dibanding bulan lalu",
            summary: String(data?.laikKalibrasi ?? 0))
        
        self.notLaikPanelView.configure(
            icon: "ic_thumb_down_rounded_fill",
            title: "Tidak Laik",
            iconStatistic: "ic_statistic_arrow_down",
            description: "5% dibanding bulan lalu",
            summary: String(data?.tidakLaikKalibrasi ?? 0))
        
        self.achievementPanelView.configure(
            icon: "ic_percentage_rounded_fill",
            title: "Pencapaian",
            iconStatistic: "ic_statistic_arrow_down",
            description: "5% dibanding bulan lalu",
            summary: String(data?.persenKalibrasi ?? 0))
    }
    
}
