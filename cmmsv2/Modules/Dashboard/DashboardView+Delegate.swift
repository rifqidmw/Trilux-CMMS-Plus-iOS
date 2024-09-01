//
//  DashboardView+Delegate.swift
//  cmmsv2
//
//  Created by macbook  on 01/09/24.
//

import UIKit

extension DashboardView: ProfileSectionViewDelegate {
    
    func didTapSelectEngineer() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.showSelectTechnicianBottomSheet(from: navigation, self)
    }
    
    func didTapSelectDate() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.showDatePickerBottomSheet(from: navigation, delegate: self)
    }
    
}

extension DashboardView: SelectTechnicianBottomSheetDelegate, DatePickerBottomSheetDelegate {
    
    func selectMultipleTechnician(_ names: [TechnicianEntity]) {
        AppLogger.log(names)
    }
    
    func didSelectTechnician(_ name: TechnicianEntity) {
        self.profileSectionView.selectedTechnician = name
        self.profileSectionView.updateSelectedValues()
    }
    
    func didSelectDate(_ date: Date, type: DatePickerBottomSheetType) {
        guard let presenter else { return }
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MM"
        let monthString = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: date)
        
        self.profileSectionView.selectedDate = date
        self.profileSectionView.updateSelectedValues()
        
        presenter.fetchPerformanceDashboard(monthString, yearString, id: "0")
        self.profileSectionView.layoutIfNeeded()
    }
    
}
