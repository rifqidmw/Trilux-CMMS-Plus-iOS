//
//  WorkSheetCorrectiveListView+Delegate.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 20/07/24.
//

import UIKit

extension WorkSheetCorrectiveListView: WorkSheetCorrectiveBottomSheetDelegate {
    
    func didTapScanQR(_ data: WorkSheetListEntity, request: WorkSheetRequestEntity) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToScan(from: navigation, .monitoring, data: data, delegate: self)
    }
    
    func didTapContinue(_ request: WorkSheetRequestEntity) {
        guard let presenter, let navigation = self.navigationController else { return }
        presenter.navigateToDetailWorkSheet(navigation, data: request, type: .monitoring, activity: .working, delegate: self)
    }
    
    func didTapDetailCorrective(data: WorkOrder) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToDetailWorkSheetCorrective(navigation: navigation, data: data)
    }
    
    func didTapDownload(_ id: String) {
        openPDF(with: id) { errorMessage in
            self.showAlert(title: errorMessage)
        }
    }
    
}

extension WorkSheetCorrectiveListView: ActionBarViewDelegate {
    
    func didTapFirstAction() {
        AppLogger.log("FIRST ACTION TAPPED")
    }
    
    func didTapSecondAction() {
        AppLogger.log("SECOND ACTION TAPPED")
    }
    
}

extension WorkSheetCorrectiveListView: WorkSheetDetailViewDelegate {
    
    func didSaveWorkSheet() {
        guard let navigation = self.navigationController else { return }
        navigation.popViewController(animated: true)
    }
    
}

extension WorkSheetCorrectiveListView: ScanViewDelegate {
    
    func didNavigateAfterSaveWorkSheet() {
        guard let presenter, let navigation = self.navigationController else { return }
        let view = WorkSheetCorrectiveListRouter().showView()
        presenter.backToPreviousPage(from: navigation, view)
    }
    
}
