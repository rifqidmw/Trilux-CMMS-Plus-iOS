//
//  DelayCorrectiveListView+Delegate.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/06/24.
//

import UIKit

extension DelayCorrectiveListView: CorrectiveCellDelegate {
    
    func didTapContinueCorrective(data: Complaint, title: CorrectiveTitleType) {
        guard let presenter, let navigation = self.navigationController else { return }
        presenter.showAddComplaintBottomSheet(from: navigation, data: data, self, type: title)
    }
    
    func didTapDeleteLk(data: Complaint) {
        guard let presenter, let navigation = self.navigationController else { return }
        presenter.showConfirmDeleteDelegateLk(navigation: navigation, delegate: self, data: data)
    }
    
}

extension DelayCorrectiveListView: DeleteComplaintBottomSheetDelegate {
    
    func didDeleteLk(data: Complaint) {
        guard let presenter else { return }
        presenter.deleteWorkSheet(idLk: data.idLkActive ?? "")
        self.showLoadingPopup()
    }
    
}

extension DelayCorrectiveListView: AddComplaintBottomSheetDelegate {
    
    func didTapCreateAdvanceWorkSheet(_ view: AddComplaintBottomSheet, engineerId: String, complainId: String, dueDate: String, engineerPendamping: [String], title: CorrectiveTitleType) {
        guard let presenter else { return }
        self.bottomSheet = view
        self.showLoadingPopup()
        switch title {
        case .advanced:
            presenter.createAdvanceWorkSheet(engineerId: engineerId, complainId: complainId, dueDate: dueDate, engineerPendamping: engineerPendamping)
        case .accept:
            presenter.createAcceptCorrective(engineerId: engineerId, complainId: complainId, dueDate: dueDate, engineerPendamping: engineerPendamping)
        default: break
        }
    }
    
    func didTapSelectTechnician(_ view: AddComplaintBottomSheet) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        self.bottomSheet = view
        presenter.showSelectTechnicianBottomSheet(from: navigation, type: .selectOne, self)
    }
    
    func didTapSelectPartner(_ view: AddComplaintBottomSheet) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        self.bottomSheet = view
        if let selectedTechnician = view.selectedTechnician?.name {
            if !selectedTechnician.isEmpty {
                presenter.showSelectTechnicianBottomSheet(from: navigation, type: .selectMultiple, self)
            }
        } else {
            view.showAlert(title: "Peringatan", message: "Anda harus memilih teknisi terlebih dahulu")
        }
    }
    
    func didTapSelectDate(_ view: AddComplaintBottomSheet) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        self.bottomSheet = view
        presenter.showDatePickerBottomSheet(from: navigation, delegate: self)
    }
    
}

extension DelayCorrectiveListView: SelectTechnicianBottomSheetDelegate, DatePickerBottomSheetDelegate {
    
    func selectMultipleTechnician(_ names: [TechnicianEntity]) {
        if let bottomSheet = self.bottomSheet {
            bottomSheet.selectedPartner = names
            bottomSheet.updateSelectedValues()
        }
    }
    
    func didSelectTechnician(_ name: TechnicianEntity) {
        if let bottomSheet = self.bottomSheet {
            bottomSheet.selectedTechnician = name
            bottomSheet.updateSelectedValues()
        }
    }
    
    func didSelectDate(_ date: Date, type: DatePickerBottomSheetType) {
        if let bottomSheet = self.bottomSheet {
            bottomSheet.selectedDate = date
            bottomSheet.updateSelectedValues()
        }
    }
    
}

extension DelayCorrectiveListView: SearchTextFieldDelegate {
    
    func searchTextField(_ searchTextField: SearchTextField, didChangeText text: String) {
        guard let presenter = presenter else { return }
        self.showLoadingPopup()
        if text.isEmpty {
            presenter.fetchInitData(keyword: "")
            self.reloadTableViewWithAnimation(self.tableView)
        } else {
            presenter.fetchInitData(keyword: text)
            self.reloadTableViewWithAnimation(self.tableView)
            
        }
    }
    
}
