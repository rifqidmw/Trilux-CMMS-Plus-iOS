//
//  CalibrationListView+Delegate.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 20/07/24.
//

import UIKit

extension CalibrationListView: WorkSheetOnsitePreventiveDelegate {
    
    func didTapDownloadPDF() {
        if let id = self.id {
            openPDF(with: id) { errorMessage in
                self.showAlert(title: errorMessage)
            }
        } else {
            self.showAlert(title: "Invalid ID or base URL.")
        }
    }
    
    func didTapContinueWorking(title: String) {
        guard let presenter,
              let navigation = self.navigationController,
              let id,
              let worksheet
        else { return }
        let request = WorkSheetRequestEntity(id: id, action: title)
        presenter.navigateToScan(from: navigation, .monitoring, data: worksheet, request: request, delegate: self)
    }
    
    func didTapDetail(title: String) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        let data = WorkSheetRequestEntity(id: self.id, action: title)
        presenter.navigateToDetailWorkSheet(navigation, data: data, type: .calibration)
    }
    
}

extension CalibrationListView: ScanViewDelegate {
    
    func didNavigateAfterSaveWorkSheet() {
        guard let presenter, let navigation = self.navigationController else { return }
        let view = CalibrationListRouter().showView()
        presenter.backToPreviousPage(from: navigation, view)
    }
    
}
