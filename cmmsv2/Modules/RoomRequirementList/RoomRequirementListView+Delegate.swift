//
//  RoomRequirementListView+Delegate.swift
//  cmmsv2
//
//  Created by macbook  on 04/10/24.
//

import UIKit

extension RoomRequirementListView: FloatingButtonDelegate {
    
    func didTapButton() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToEquipmentProcurement(from: navigation)
    }
    
}

extension RoomRequirementListView: SearchTextFieldDelegate {
    
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

extension RoomRequirementListView: ActionBarViewDelegate {
    
    func didTapFirstAction() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.showDatePickerBottomSheet(from: navigation, delegate: self)
    }
    
    func didTapSecondAction() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.showConditionFilterBottomSheet(from: navigation, self)
    }
    
    func didTapThirdAction() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.showSortBottomSheet(from: navigation, self)
    }
    
}

extension RoomRequirementListView: SortingBottomSheetDelegate, ConditionFilterBottomSheetDelegate, DatePickerBottomSheetDelegate {
    
    func didSelectDate(_ date: Date, type: DatePickerBottomSheetType) {
        guard let presenter else { return }
        self.showLoadingPopup()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let dateString = dateFormatter.string(from: date)
        presenter.fetchInitData(year: dateString)
    }
    
    func didTapApplyFilterCondition(_ asset: AssetConditionEntity?, _ status: CalibrationConditionEntity?) {
        guard let presenter else { return }
        self.showLoadingPopup()
        presenter.fetchInitData(condition: asset?.assetCondition?.getStringValue().lowercased())
    }
    
    func didTapApplySort(_ sort: SortingEntity, type: SortingBottomSheetType) {
        guard let presenter else { return }
        self.showLoadingPopup()
        presenter.fetchInitData(sort: sort.sortType?.getStringValue().lowercased())
    }
    
}

extension RoomRequirementListView: ActionRoomReqBottomSheetDelegate {
    
    func didTapProgress(_ data: RoomRequirementListData) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.showProgressRoomBottomSheet(from: navigation, for: data.myProgress ?? [])
    }
    
    func didTapDetail(_ data: RoomRequirementListData) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToEquipmentProcurement(from: navigation, data)
    }
    
    func didTapUpdate(_ data: RoomRequirementListData) {
        AppLogger.log("UPDATE")
    }
    
    func didTapDelete(_ data: RoomRequirementListData) {
        AppLogger.log("DELETE")
    }
    
}
