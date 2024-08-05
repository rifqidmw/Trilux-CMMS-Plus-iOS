//
//  InformationSectionView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/08/24.
//

import UIKit
import XLPagerTabStrip

class InformationSectionView: BaseViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var containerTechnicalInfoStackView: UIStackView!
    @IBOutlet weak var assetConditionView: InformationCardView!
    @IBOutlet weak var priorityView: InformationCardView!
    @IBOutlet weak var technologyClassificationView: InformationCardView!
    @IBOutlet weak var ageTechnicalView: InformationCardView!
    
    @IBOutlet weak var containerAICMeasurementInfoStackView: UIStackView!
    @IBOutlet weak var iccCostInfoView: InformationCardView!
    @IBOutlet weak var annualAICInfoView: InformationCardView!
    @IBOutlet weak var maintenanceInfoView: InformationCardView!
    
    @IBOutlet weak var containerMMELMeasurementStackView: UIStackView!
    @IBOutlet weak var replacementValueView: InformationCardView!
    @IBOutlet weak var ageTechnicalMeasurementView: InformationCardView!
    @IBOutlet weak var melFactorView: InformationCardView!
    @IBOutlet weak var mmelValueView: InformationCardView!
    
    weak var parentView: EquipmentMaintenanceView?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: "Informasi")
    }
    
}

extension InformationSectionView {
    
    private func setupBody() {
        setupView()
        bindingData()
    }
    
    private func setupView() {
        self.containerTechnicalInfoStackView.makeCornerRadius(8)
        self.containerTechnicalInfoStackView.addShadow(0.2, position: .bottom, opacity: 0.2)
        
        self.containerAICMeasurementInfoStackView.makeCornerRadius(8)
        self.containerAICMeasurementInfoStackView.addShadow(0.2, position: .bottom, opacity: 0.2)
        
        self.containerMMELMeasurementStackView.makeCornerRadius(8)
        self.containerMMELMeasurementStackView.addShadow(0.2, position: .bottom, opacity: 0.2)
    }
    
    private func bindingData() {
        guard let view = self.parentView else { return }
        view.$technicalInfoData
            .sink { [weak self] data in
                guard let self, let data else { return }
                self.assetConditionView.configureView(title: "Kondisi", value: data.txtKondisi ?? "-")
                self.priorityView.configureView(title: "Prioritas", value: data.txtPrioritas ?? "-")
                self.technologyClassificationView.configureView(title: "Kelompok Teknologi", value: data.txtTeknologi ?? "-")
                self.ageTechnicalView.configureView(title: "Usia Teknis", value: "\(data.txtThnOperate ?? "-") Tahun")
            }
            .store(in: &anyCancellable)
        
        view.$costInfoData
            .sink { [weak self] data in
                guard let self, let data else { return }
                self.iccCostInfoView.configureView(title: "Biaya (IIC)", value: data.txtIIC ?? "-")
                self.annualAICInfoView.configureView(title: "Annual (AIC)", value: String(data.txtAIC ?? 0.0))
                self.maintenanceInfoView.configureView(title: "Maintenance (10%)", value: data.txtMaintenance ?? "-")
                
                self.replacementValueView.configureView(title: "Nilai Pengganti", value: data.txtPengganti ?? "-")
                self.ageTechnicalMeasurementView.configureView(title: "Usia Teknis", value: "\(data.txtUsiaTeknis ?? "-") Tahun")
                self.melFactorView.configureView(title: "Faktor MEL", value: data.txtFaktorMEL ?? "-")
                self.mmelValueView.configureView(title: "Nilai MMEL", value: data.txtNilaiMMEL ?? "-")
            }
            .store(in: &anyCancellable)
    }
    
}
