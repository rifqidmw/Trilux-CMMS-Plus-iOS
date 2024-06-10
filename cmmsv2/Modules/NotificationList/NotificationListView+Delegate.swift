//
//  NotificationListView+Delegate.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 08/06/24.
//

import UIKit

extension NotificationListView: WorkSheetCorrectiveBottomSheetDelegate {
    
    func didTapDetailCorrective(data: WorkOrder) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        self.dismiss(animated: true)
        presenter.navigateToDetailWorkSheetCorrective(navigation: navigation, data: data)
    }
    
}
