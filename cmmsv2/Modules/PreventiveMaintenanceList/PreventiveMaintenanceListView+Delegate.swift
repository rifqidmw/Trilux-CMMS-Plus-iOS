//
//  PreventiveMaintenanceListView+Delegate.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 26/06/24.
//

import UIKit

extension PreventiveMaintenanceListView: WorkSheetOnsitePreventiveDelegate {
    
    func didTapDownloadPDF() {
        if let id = self.id {
            openPDF(with: id) { errorMessage in
                self.showAlert(title: errorMessage)
            }
        } else {
            self.showAlert(title: "Invalid ID or base URL.")
        }
    }
    
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
              let workSheet,
              let id
        else { return }
        let request = WorkSheetRequestEntity(id: id, action: title)
        presenter.navigateToScan(from: navigation, .monitoring, data: workSheet, request: request, delegate: self)
    }
    
}

extension PreventiveMaintenanceListView: ActionBarViewDelegate {
    
    func didTapFirstAction() {
        AppLogger.log("-- INSTALLATION CLICKED")
    }
    
    func didTapSecondAction() {
        guard let presenter, let navigation = self.navigationController else { return }
        presenter.showFilterStatusBottomSheet(from: navigation, delegate: self)
    }
    
    func didTapThirdAction() {
        guard let presenter, let navigation = self.navigationController else { return }
        presenter.showHistorySortBottomSheet(from: navigation, self)
    }
    
}

extension PreventiveMaintenanceListView: ScanViewDelegate {
    
    func didNavigateAfterSaveWorkSheet() {
        guard let presenter, let navigation = self.navigationController else { return }
        let view = PreventiveMaintenanceListRouter().showView()
        presenter.backToPreviousPage(from: navigation, view)
    }
    
}

extension PreventiveMaintenanceListView: SearchTextFieldDelegate {
    
    func searchTextField(_ searchTextField: SearchTextField, didChangeText text: String) {
        guard let presenter = presenter else { return }
        self.showLoadingPopup()
        if text.isEmpty {
            presenter.fetchInitData(keyword: "")
            self.reloadCollectionViewWithAnimation(self.collectionView)
        } else {
            presenter.fetchInitData(keyword: text)
            self.reloadCollectionViewWithAnimation(self.collectionView)
        }
    }
    
}

extension PreventiveMaintenanceListView: FilterStatusBottomSheetDelegate {
    
    func didSelectStatusFilter(_ status: [StatusFilterEntity]) {
        guard let presenter else { return }
        self.showLoadingPopup()
        let statusString = status.map { $0.id ?? "" }.first
        presenter.fetchInitData(status: statusString)
        self.reloadCollectionViewWithAnimation(self.collectionView)
    }
    
}

extension PreventiveMaintenanceListView: SortingBottomSheetDelegate {
    
    func didTapApplySort(_ sort: SortingEntity) {
        guard let presenter else { return }
        self.showLoadingPopup()
        presenter.fetchInitData(sort: sort.sortType?.getStringValue().lowercased())
        self.reloadCollectionViewWithAnimation(self.collectionView)
    }
    
}
