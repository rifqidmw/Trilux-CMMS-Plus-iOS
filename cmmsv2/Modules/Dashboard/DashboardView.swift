//
//  DashboardView.swift
//  cmmsv2
//
//  Created by macbook  on 28/08/24.
//

import UIKit

class DashboardView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var profileSectionView: ProfileSectionView!
    @IBOutlet weak var complaintSectionView: ComplaintSectionView!
    @IBOutlet weak var repairSectionView: RepairSectionView!
    @IBOutlet weak var monitoringSectionView: MonitoringFunctionSectionView!
    @IBOutlet weak var calibrationSectionView: CalibrationDashboardSectionView!
    @IBOutlet weak var workLoadSectionView: WorkLoadSectionView!
    
    var presenter: DashboardPresenter?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.validateUser()
    }
    
}

extension DashboardView {
    
    private func setupBody() {
        setupView()
        setupAction()
        fetchInitialData()
        bindingData()
    }
    
    private func fetchInitialData() {
        guard let presenter else { return }
        self.showLoadingPopup()
        presenter.fetchPerformanceDashboard(String.getCurrentDateString("MM"), String.getCurrentDateString("yyyy"), id: "0")
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$performanceData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self, let data else { return }
                self.hideLoadingPopup()
                self.profileSectionView.configureView(data.engineer)
                self.profileSectionView.delegate = self
                self.profileSectionView.layoutIfNeeded()
                self.complaintSectionView.configure(data.bulanIni)
                self.complaintSectionView.layoutIfNeeded()
                self.repairSectionView.configure(data.bulanIni)
                self.repairSectionView.layoutIfNeeded()
                self.calibrationSectionView.configure(data.bulanIni, data.kwartal)
                self.calibrationSectionView.layoutIfNeeded()
                self.workLoadSectionView.configure(String(data.beban?.alat?.first?.value ?? 0), totalWorkLoad: String(data.beban?.beban?.first?.value ?? 0))
                self.workLoadSectionView.layoutIfNeeded()
                self.monitoringSectionView.configure(data)
                self.monitoringSectionView.layoutIfNeeded()
            }
            .store(in: &anyCancellable)
    }
    
    private func setupView() {
        self.customNavigationView.configure(toolbarTitle: "Dashboard", type: .plain)
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
    
}
