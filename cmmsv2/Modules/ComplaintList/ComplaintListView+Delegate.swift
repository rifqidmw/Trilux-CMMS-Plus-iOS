//
//  ComplaintListView+Delegate.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/06/24.
//

import UIKit

extension ComplaintListView: CorrectiveCellDelegate {
    
    func didTapContinueCorrective(index: Int) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.showAddComplaintBottomSheet(from: navigation, self, index: index)
    }
    
}

extension ComplaintListView: AddComplaintBottomSheetDelegate {
    
    func didTapSelectTechnician() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.showSelectTechnicianBottomSheet(from: navigation, type: .selectOne)
    }
    
    func didTapSelectPartner() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.showSelectTechnicianBottomSheet(from: navigation, type: .selectMultiple)
    }
    
    func didTapSelectDate() {
        AppLogger.log("-- TAPPED")
    }
    
}
