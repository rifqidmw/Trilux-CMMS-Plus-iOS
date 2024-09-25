//
//  HomeScreenView+Delegate.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 03/02/24.
//

import UIKit

extension HomeScreenView: HomeScreenCategoryDelegate {
    
    func didTapAllCategory() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.showBottomSheetAllCategories(navigation: navigation, delegate: self)
    }
    
    func didTapAsset() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
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
        presenter.showBottomSheetWorkSheet(navigation: navigation, delegate: self)
    }
    
    func didTapHistory() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToHistoryList(navigation: navigation)
    }
    
    func didTapDelayCorrective() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToDelayCorrectiveList(navigation: navigation)
    }
    
    func didTapLogBook() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToLogBook(navigation: navigation)
    }
    
    func didTapPreventiveCalendar() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToCalendarPreventive(navigation: navigation)
    }
    
    func didTapMaintenanceCategory() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.showBottomSheetWorkSheet(navigation: navigation, delegate: self)
    }
    
    func didTapWorkSheetApprovalCategory() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToWorkSheetApproval(from: navigation)
    }
    
    func didTapComplaintHistoryCategory() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToHistoryList(navigation: navigation)
    }
    
    func didTapMonitoringFunctionCategory() {
        self.showAlert(title: "Pemeliharaan Fungsi")
    }
    
    func didTapPreventiveCategory() {
        self.showAlert(title: "Preventif")
    }
    
    func didTapAssetInfoCategory() {
        self.showAlert(title: "Informasi Asset")
    }
    
    func didTapPrintRoomCategory() {
        self.showAlert(title: "Informasi Ruangan")
    }
    
    func didTapMaintenanceInfoCategory() {
        self.showAlert(title: "Informasi Pemeliharaan")
    }
    
    func didTapMutationInfoCategory() {
        self.showAlert(title: "Informasi Mutasi")
    }
    
    func didTapCalibrationCategory() {
        self.showAlert(title: "Kalibrasi")
    }
    
    func didTapMutatingCategory() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.showBottomSheetMutation(navigation: navigation, delegate: self)
    }
    
    func didTapHistoryComplaintListCategory() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.showBottomSheetComplaintHistory(navigation: navigation, delegate: self)
    }
    
    func didTapRoomRequirementCategory() {
        self.showAlert(title: "Kebutuhan Ruangan")
    }
    
    func didTapAssetSuggestCategory() {
        self.showAlert(title: "Usulan Alat")
    }
    
    func didTapRatingCategory() {
        self.showAlert(title: "Rating")
    }
    
}

extension HomeScreenView: WorkSheetBottomSheetDelegate {
    
    func didTapWorkSheetFunctionMonitoring() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToWorkSheetMonitoringList(from: navigation)
    }
    
    func didTapWorkSheetCorrective() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        if RoleManager.shared.currentUserRole == .ipsrs {
            presenter.navigateToComplaintList(navigation: navigation)
        } else {
            presenter.navigateToWorkSheetCorrective(navigation: navigation)
        }
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

extension HomeScreenView: AllCategoriesBottomSheetDelegate {
    
    func didTapAssetCategory() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        navigation.dismiss(animated: true) {
            presenter.showBottomSheetAsset(navigation: navigation, delegate: self)
        }
    }
    
    func didTapComplaintCategory() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        navigation.dismiss(animated: true) {
            presenter.navigateToComplaintList(navigation: navigation)
        }
    }
    
    func didTapWorkSheetCategory() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.showBottomSheetWorkSheet(navigation: navigation, delegate: self)
    }
    
    func didTapHistoryCategory() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        navigation.dismiss(animated: true) {
            presenter.navigateToHistoryList(navigation: navigation)
        }
    }
    
    func didTapDelayCorrectiveCategory() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        navigation.dismiss(animated: true) {
            presenter.navigateToDelayCorrectiveList(navigation: navigation)
        }
    }
    
    func didTapLogBookCategory() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        navigation.dismiss(animated: true) {
            presenter.navigateToLogBook(navigation: navigation)
        }
    }
    
    func didTapPreventiveCalendarCategory() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        navigation.dismiss(animated: true) {
            presenter.navigateToCalendarPreventive(navigation: navigation)
        }
    }
    
    func didTapComplaintHistoryList() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        navigation.dismiss(animated: true) {
            presenter.showBottomSheetComplaintHistory(navigation: navigation, delegate: self)
        }
    }
    
}

extension HomeScreenView: ComplaintHistoryBottomSheetDelegate {
    
    func didTapComplaintList() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToComplaintList(navigation: navigation, type: .room)
    }
    
    func didTapComplaintRoomHistoryList() {
        AppLogger.log("-- GO TO COMPLAINT ROOM HISTORY LIST")
    }
    
}

extension HomeScreenView: ReminderPreventiveBottomSheetDelegate, ScanViewDelegate {
    
    func didTapDetailPreventive(_ data: WorkSheetRequestEntity, wo: WorkSheetListEntity) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToScan(from: navigation, .monitoring, data: wo, request: data, delegate: self)
    }
    
    func didNavigateAfterSaveWorkSheet() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        let view = HomeScreenRouter().showView()
        presenter.backToPreviousPage(from: navigation, view)
    }
    
}

extension HomeScreenView: DashboardChartViewDelegate {
    
    func didTapBarChart(type: DashboardChartType) {
        guard let presenter, let navigation = self.navigationController else { return }
        switch type {
        case .complaint:
            presenter.navigateToComplaintList(navigation: navigation)
        case .corrective:
            presenter.navigateToDelayCorrectiveList(navigation: navigation)
        case .medic:
            presenter.navigateToAssetMedicList(navigation: navigation)
        case .nonMedic:
            presenter.navigateToAssetNonMedicList(navigation: navigation)
        }
    }
    
}

extension HomeScreenView: MutationBottomSheetDelegate {
    
    func didTapAssetLoan() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToEquipmentManagement(from: navigation, .loan)
    }
    
    func didTapAssetReturning() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToEquipmentManagement(from: navigation, .returning)
    }
    
    func didTapMutation() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToEquipmentManagement(from: navigation, .mutation)
    }
    
    func didTapAmprah() {
        self.showAlert(title: "Amprah")
    }
    
}
