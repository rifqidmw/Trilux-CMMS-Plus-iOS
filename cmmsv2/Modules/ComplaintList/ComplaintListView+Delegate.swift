//
//  ComplaintListView+Delegate.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/06/24.
//

import UIKit

extension ComplaintListView: CorrectiveCellDelegate {
    
    func didTapContinueCorrective(data: Complaint, title: CorrectiveTitleType) {
        guard let presenter, let navigation = self.navigationController else { return }
        presenter.showAddComplaintBottomSheet(from: navigation, data: data, self, type: title)
    }
    
    func didTapDeleteLk(data: Complaint) {
        guard let presenter, let navigation = self.navigationController else { return }
        presenter.showConfirmDeleteDelegateLk(navigation: navigation, delegate: self, data: data)
    }
    
}

extension ComplaintListView: DeleteComplaintBottomSheetDelegate {
    
    func didDeleteLk(data: Complaint) {
        guard let presenter else { return }
        presenter.deleteWorkSheet(idLk: data.idLkActive ?? "")
        self.showLoadingPopup()
    }
    
}

extension ComplaintListView: AddComplaintBottomSheetDelegate {
    
    func didTapCreateAdvanceWorkSheet(_ view: AddComplaintBottomSheet, engineerId: String, complainId: String, dueDate: String, engineerPendamping: [String], title: CorrectiveTitleType) {
        guard let presenter else { return }
        self.bottomSheet = view
        self.showLoadingPopup()
        switch title {
        case .advanced:
            presenter.createAdvanceWorkSheet(engineerId: engineerId, complainId: complainId, dueDate: dueDate, engineerPendamping: engineerPendamping)
        case .accept, .partner:
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

extension ComplaintListView: SelectTechnicianBottomSheetDelegate, DatePickerBottomSheetDelegate {
    
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

extension ComplaintListView: ActionBarViewDelegate, SearchTextFieldDelegate, FilterStatusBottomSheetDelegate {
    
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
    
    func didTapFourthAction() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.showFilterStatusBottomSheet(from: navigation, delegate: self)
    }
    
    func didSelectStatusFilter(_ multiple: [StatusFilterEntity], single: StatusFilterEntity) {
        guard let presenter else { return }
        self.showLoadingPopup()
        let statusString = multiple.map { $0.status?.rawValue ?? "" }.joined(separator: ",").lowercased()
        presenter.fetchInitData(status: statusString)
        self.reloadTableViewWithAnimation(self.tableView)
    }
    
}

extension ComplaintListView: SelectComplaintActionBottomSheetDelegate {
    
    func didTapDetailComplaint(_ id: String?) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToComplaintDetail(navigation: navigation, id: id ?? "")
    }
    
    func didTapEditComplaint(_ id: String?, valType: String?) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToEditComplaint(from: navigation, id ?? "", valType: valType ?? "")
    }
    
    func didTapDeleteComplaint(_ id: String?) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.showDeleteConfirmationPopUp(from: navigation, delegate: self, id ?? "")
    }
    
    func didTapDetailComplaintDelegatable(_ id: String?) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToComplaintDetail(navigation: navigation, id: id ?? "")
    }
    
}

extension ComplaintListView: DeleteComplaintConfirmBottomSheetDelegate {
    
    func didConfirmationDeleteComplaint(_ id: String?) {
        guard let presenter else { return }
        presenter.deleteComplaint(id: id ?? "")
        self.showLoadingPopup()
    }
    
}
