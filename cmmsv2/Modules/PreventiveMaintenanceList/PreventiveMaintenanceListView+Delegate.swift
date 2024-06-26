//
//  PreventiveMaintenanceListView+Delegate.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 26/06/24.
//

import UIKit

extension PreventiveMaintenanceListView: WorkSheetOnsitePreventiveDelegate {
    
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
              let workSheet
        else { return }
        presenter.navigateToScan(from: navigation, data: workSheet)
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
