//
//  EquipmentMaintenanceView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/08/24.
//

import UIKit
import XLPagerTabStrip

class EquipmentMaintenanceView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var stripTabBarView: UIView!
    
    @Published public var technicalInfoData: EquipmentTechnical?
    @Published public var costInfoData: EquipmentMainCoast?
    
    var presenter: EquipmentMaintenancePresenter?
    
    override func didLoad() {
        super.didLoad()
        self.validateUser()
        self.setupBody()
        self.setupStripTabBar(in: stripTabBarView)
    }
    
}

extension EquipmentMaintenanceView {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupStripView()
        bindingData()
        fetchInitialData()
    }
    
    private func setupView() {
        self.customNavigationView.configure(toolbarTitle: "Info Pemeliharaan Aset", type: .plain)
        self.stripTabBarView.makeCornerRadius(8)
        self.stripTabBarView.addShadow(1.0)
    }
    
    private func fetchInitialData() {
        guard let presenter else { return }
        presenter.fetchInitialData()
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$technicalInfoData
            .sink { [weak self] data in
                guard let self else { return }
                self.technicalInfoData = data
            }
            .store(in: &anyCancellable)
        
        presenter.$assetCostInfoData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self = self, let data else { return }
                self.costInfoData = data
            }
            .store(in: &anyCancellable)
    }
    
    private func setupAction() {
        customNavigationView.arrowLeftBackButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                navigation.popViewController(animated: true)
            }
            .store(in: &anyCancellable)
    }
    
    private func setupStripView() {
        let generalInformation = InformationSectionView(nibName: String(describing: InformationSectionView.self), bundle: nil)
        generalInformation.parentView = self
        
        let complaintInfo = ComplaintInformationView(nibName: String(describing: ComplaintInformationView.self), bundle: nil)
        
        let monitoringInfo = MonitoringInformationView(nibName: String(describing: MonitoringInformationView.self), bundle: nil)
        
        let preventiveInfo = PreventiveInformationView(nibName: String(describing: PreventiveInformationView.self), bundle: nil)
        
        let calibrationInfo = CalibrationInformationView(nibName: String(describing: CalibrationInformationView.self), bundle: nil)
        
        self.views = [generalInformation, complaintInfo, monitoringInfo, preventiveInfo, calibrationInfo]
    }
    
}
