//
//  HomeScreenView+Delegate.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 03/02/24.
//

extension HomeScreenView: HomeScreenCategoryDelegate {
    
    func didTapAllCategory() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        self.showOverlay()
        presenter.showBottomSheetAllCategories(navigation: navigation)
    }
    
    func didTapAsset() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        self.showOverlay()
        presenter.showBottomSheetAsset(navigation: navigation, delegate: self)
    }
    
    func didTapComplaint() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToComplaintList(navigation: navigation)
    }
    
    func didTapWorkSheet() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        self.showOverlay()
        presenter.showBottomSheetWorkSheet(navigation: navigation, delegate: self)
    }
    
    func didTapHistory() {
        AppLogger.log("CLICKED")
    }
    
    func didTapDelayCorrective() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToDelayCorrectiveList(navigation: navigation)
    }
    
    func didTapLogBook() {
        AppLogger.log("CLICKED")
    }
    
    func didTapPreventiveCalendar() {
        AppLogger.log("CLICKED")
    }
    
}

extension HomeScreenView: WorkSheetBottomSheetDelegate {
    
    func didTapWorkSheetFunctionMonitoring() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToWorkSheetList(navigation: navigation)
    }
    
    func didTapWorkSheetCorrective() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToWorkSheetCorrective(navigation: navigation)
    }
    
    func didTapMaintenancePreventive() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToPreventiveMaintenanceList(navigation: navigation)
    }
    
    func didTapCalibration() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToCalibrationList(navigation: navigation)
    }
    
}

extension HomeScreenView: AssetBottomSheetDelegate {
    
    func didTapAssetMedic() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToAssetMedicList(navigation: navigation)
    }
    
    func didTapAssetNonMedic() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToAssetNonMedicList(navigation: navigation)
    }
    
}
