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
    
    func didTapPreventiveMaintenance() {
        AppLogger.log("CLICKED")
    }
    
    func didTapCalibration() {
        AppLogger.log("CLICKED")
    }
    
    func didTapHistory() {
        AppLogger.log("CLICKED")
    }
    
    func didTapLogBook() {
        AppLogger.log("CLICKED")
    }
    
    func didTapToolSuggestions() {
        AppLogger.log("CLICKED")
    }
    
    func didTapPreventiveCalendar() {
        AppLogger.log("CLICKED")
    }
    
}

extension HomeScreenView: WorkSheetBottomSheetDelegate {
    
    func didTapWorkSheetList() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToWorkSheetList(navigation: navigation)
    }
    
    func didTapWorkSheetOnsitePreventive() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToWorkSheetOnsitePreventive(navigation: navigation)
    }
    
    func didTapWorkSheetCorrective() {
        AppLogger.log("GO TO WORK SHEET CORRECTIVE")
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
