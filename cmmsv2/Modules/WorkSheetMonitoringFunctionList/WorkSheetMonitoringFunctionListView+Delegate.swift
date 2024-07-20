//
//  WorkSheetMonitoringFunctionListView+Delegate.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 20/07/24.
//

import UIKit

extension WorkSheetMonitoringFunctionListView: WorkSheetOnsitePreventiveDelegate {
    
    func didTapDetail(title: String) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        let data = WorkSheetRequestEntity(id: self.id, action: title)
        presenter.navigateToDetailWorkSheet(navigation, data: data, type: .monitoring)
    }
    
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
              let workSheet,
              let id
        else { return }
        let request = WorkSheetRequestEntity(id: id, action: title)
        presenter.navigateToScan(from: navigation, .monitoring, data: workSheet, request: request, delegate: self)
    }
    
}

extension WorkSheetMonitoringFunctionListView: ScanViewDelegate {
    
    func didNavigateAfterSaveWorkSheet() {
        guard let presenter, let navigation = self.navigationController else { return }
        let view = WorkSheetMonitoringFunctionListRouter().showView()
        presenter.backToPreviousPage(from: navigation, view)
    }
    
}

