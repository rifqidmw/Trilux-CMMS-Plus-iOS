//
//  LoadPreventiveView+Delegate.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 26/06/24.
//

import UIKit

extension LoadPreventiveView: AddPreventiveBottomSheetDelegate {
    
    func didTapScheduling(from view: AddPreventiveBottomSheet) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        self.bottomSheet = view
        presenter.showDatePickerBottomSheet(from: navigation, delegate: self, type: .date)
    }
    
    func didTapPlanning(from view: AddPreventiveBottomSheet) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        self.bottomSheet = view
        presenter.showDatePickerBottomSheet(from: navigation, delegate: self, type: .monthYear)
    }
    
    func didSavePreventive(from view: AddPreventiveBottomSheet, request: CreatePreventiveRequest) {
        guard let presenter else { return }
        self.bottomSheet = view
        DispatchQueue.main.async {
            self.showLoadingPopup()
            presenter.createPreventive(data: request)
        }
    }
    
}

extension LoadPreventiveView: DatePickerBottomSheetDelegate {
    
    func didSelectDate(_ date: Date, type: DatePickerBottomSheetType) {
        if let bottomSheet = self.bottomSheet {
            switch type {
            case .date:
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let dateString = dateFormatter.string(from: date)
                bottomSheet.selectedDate = dateString
            case .monthYear:
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-yyyy"
                let monthString = dateFormatter.string(from: date)
                bottomSheet.selectedMonth = monthString
            }
            bottomSheet.updateSelectedData()
        }
    }
    
}
