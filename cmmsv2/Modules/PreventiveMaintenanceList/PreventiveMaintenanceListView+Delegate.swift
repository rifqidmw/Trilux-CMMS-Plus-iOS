//
//  PreventiveMaintenanceListView+Delegate.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 26/06/24.
//

import UIKit

extension PreventiveMaintenanceListView: WorkSheetOnsitePreventiveDelegate {
    
    func didTapDownloadPDF() {
        if let id = self.id {
            openPDF(with: id) { errorMessage in
                self.showAlert(title: errorMessage)
            }
        } else {
            self.showAlert(title: "Invalid ID or base URL.")
        }
    }
    
    func didTapDetail(title: String) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        let data = WorkSheetRequestEntity(id: self.id, action: title)
        presenter.navigateToDetailWorkSheet(navigation, data: data, type: .preventive)
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

extension PreventiveMaintenanceListView: ActionBarViewDelegate {
    
    func didTapFirstAction() {
        AppLogger.log("-- INSTALLATION CLICKED")
    }
    
    func didTapSecondAction() {
        AppLogger.log("-- STATUS CLICKED")
    }
    
    func didTapThirdAction() {
        AppLogger.log("-- SORT CLICKED")
    }
    
}

extension PreventiveMaintenanceListView: ScanViewDelegate {
    
    func didNavigateAfterSaveWorkSheet() {
        guard let presenter, let navigation = self.navigationController else { return }
        let view = PreventiveMaintenanceListRouter().showView()
        presenter.backToPreviousPage(from: navigation, view)
    }
    
}
