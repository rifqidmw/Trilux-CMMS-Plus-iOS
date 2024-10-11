//
//  MutationSubmissionView+Delegate.swift
//  cmmsv2
//
//  Created by macbook  on 11/10/24.
//

import UIKit

extension MutationSubmissionView: MutationSubmissionBottomSheetDelegate {
    
    func didSelectData(_ id: String?, title: String?, for type: MutationSubmissionBottomSheetType) {
        guard let id, let title else { return }
        switch type {
        case .installation:
            self.toInstallation = id
            self.installationSelectView.configure(title: "Instalasi/Ruangan", placeHolder: "Pilih instalasi atau ruangan yang diinginkan", value: title)
        case .equipment:
            self.equipmentSelectView.configure(title: "Alat", placeHolder: "Pilih alat yang diinginkan", value: title)
            self.equipmentId = id
        }
    }
    
}
