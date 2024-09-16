//
//  EquipmentManagementView+Delegate.swift
//  cmmsv2
//
//  Created by macbook  on 16/09/24.
//

import UIKit

extension EquipmentManagementListView: FloatingActionButtonDelegate, ConfirmationReturningBottomDelegate {
    
    func didTapActionItem(_ idx: Int) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        switch idx {
        case 0:
            presenter.navigateToAssetMedicList(navigation: navigation)
        case 1:
            presenter.navigateToScan(from: navigation, .asset)
        default: break
        }
    }
    
    func didTapConfirm(_ idx: String) {
        guard let presenter else { return }
        self.showLoadingPopup()
        presenter.approveRequested(id: idx)
    }
    
}
