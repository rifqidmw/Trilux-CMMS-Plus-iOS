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
    
    func configure(_ data: MonthlyData?, _ quarter: Quarter?) {
        self.dateLabel.text = String.getCurrentDateString("MMMM yyyy")
        
        let currentTarget = data?.targetKalibrasi ?? 0
        let quarterTarget = quarter?.targetPreventif
        let isTargetDown = currentTarget < quarterTarget ?? 0
        
        let currentRealization = data?.realisasiKalibrasi ?? 0
        let quarterRealization = quarter?.realisasiPreventif ?? 0
        let isRealizationDown = currentRealization < quarterRealization
        
        let currentLaik = data?.laikKalibrasi ?? 0
        let quarterLaik = quarter?.open ?? 0
        let isLaikDown = currentLaik < quarterLaik
        
        let currentNotLaik = data?.tidakLaikKalibrasi ?? 0
        let quarterNotLaik = quarter?.kendala ?? 0
        let isNotLaikDown = currentNotLaik < quarterNotLaik
        
        let currentAchievement = Double(data?.persenKalibrasi ?? 0)
        let quarterAchievement = Double(quarter?.persenPreventif ?? 0)
        let isAchievementDown = currentAchievement < quarterAchievement
        
        self.targetPanelView.configure(
            icon: "ic_target_rounded_fill",
            title: "Target",
            iconStatistic: isTargetDown ? "ic_statistic_arrow_down" : "ic_statistic_arrow_up",
            description: "\(abs(currentTarget - (quarterTarget ?? 0)))% dibanding bulan lalu",
            summary: String(currentTarget)
        )
        
        self.realizationPanelView.configure(
            icon: "ic_diagnostic_rounded_fill",
            title: "Realisasi",
            iconStatistic: isRealizationDown ? "ic_statistic_arrow_down" : "ic_statistic_arrow_up",
            description: "\(abs(currentRealization - quarterRealization))% dibanding bulan lalu",
            summary: String(currentRealization)
        )
        
        self.laikPanelView.configure(
            icon: "ic_thumb_up_rounded_fill",
            title: "Laik",
            iconStatistic: isLaikDown ? "ic_statistic_arrow_down" : "ic_statistic_arrow_up",
            description: "\(abs(currentLaik - quarterLaik))% dibanding bulan lalu",
            summary: String(currentLaik)
        )
        
        self.notLaikPanelView.configure(
            icon: "ic_thumb_down_rounded_fill",
            title: "Tidak Laik",
            iconStatistic: isNotLaikDown ? "ic_statistic_arrow_down" : "ic_statistic_arrow_up",
            description: "\(abs(currentNotLaik - quarterNotLaik))% dibanding bulan lalu",
            summary: String(currentNotLaik)
        )
        
        self.achievementPanelView.configure(
            icon: "ic_percentage_rounded_fill",
            title: "Pencapaian",
            iconStatistic: isAchievementDown ? "ic_statistic_arrow_down" : "ic_statistic_arrow_up",
            description: "\(abs(currentAchievement - quarterAchievement))% dibanding bulan lalu",
            summary: "\(String(currentAchievement)) %"
        )
    }
    
}
