//
//  WorkSheetCorrectiveListView+Delegate.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 20/07/24.
//

import UIKit

extension WorkSheetCorrectiveListView: WorkSheetCorrectiveBottomSheetDelegate {
    
    func didTapScanQR(_ data: WorkSheetListEntity, request: WorkSheetRequestEntity) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToScan(from: navigation, .monitoring, data: data, delegate: self)
    }
    
    func didTapContinue(_ request: WorkSheetRequestEntity) {
        guard let presenter, let navigation = self.navigationController else { return }
        presenter.navigateToDetailWorkSheet(navigation, data: request, type: .monitoring, activity: .working, delegate: self)
    }
    
    func didTapDetailCorrective(data: WorkOrder) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToDetailWorkSheetCorrective(navigation: navigation, String(data.id ?? 0), String(data.complain?.id ?? 0), valType: data.valType ?? "")
    }
    
    func didTapDownload(_ id: String) {
        openPDF(with: id) { errorMessage in
            self.showAlert(title: errorMessage)
        }
    }
    
    func didTapAssetImage(_ id: String, type: AssetType) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToDetailAsset(from: navigation, type, id: id)
    }
    
}

extension WorkSheetCorrectiveListView: ActionBarViewDelegate {
    
    func didTapFirstAction() {
        guard let presenter, let navigation = self.navigationController else { return }
        presenter.showFilterStatusBottomSheet(from: navigation, delegate: self)
    }
    
    func didTapSecondAction() {
        guard let presenter, let navigation = self.navigationController else { return }
        presenter.showHistorySortBottomSheet(from: navigation, self)
    }
    
}

extension WorkSheetCorrectiveListView: WorkSheetDetailViewDelegate {
    
    func didSaveWorkSheet() {
        guard let navigation = self.navigationController else { return }
        navigation.popViewController(animated: true)
    }
    
}

extension WorkSheetCorrectiveListView: ScanViewDelegate {
    
    func didNavigateAfterSaveWorkSheet() {
        guard let presenter, let navigation = self.navigationController else { return }
        let view = WorkSheetCorrectiveListRouter().showView()
        presenter.backToPreviousPage(from: navigation, view)
    }
    
}

extension WorkSheetCorrectiveListView: SearchTextFieldDelegate {
    
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

extension WorkSheetCorrectiveListView: FilterStatusBottomSheetDelegate {
    
    func didSelectStatusFilter(_ multiple: [StatusFilterEntity], single: StatusFilterEntity) {
        guard let presenter else { return }
        self.showLoadingPopup()
        let woStatusString = multiple.map { $0.status?.rawValue ?? "" }.joined(separator: ",").lowercased()
        presenter.fetchInitData(woStatus: woStatusString)
        self.reloadCollectionViewWithAnimation(self.collectionView)
    }
    
}

extension WorkSheetCorrectiveListView: SortingBottomSheetDelegate {
    
    func didTapApplySort(_ sort: SortingEntity, type: SortingBottomSheetType) {
        guard let presenter else { return }
        self.showLoadingPopup()
        presenter.fetchInitData(sort: sort.sortType?.getStringValue().lowercased())
        self.reloadCollectionViewWithAnimation(self.collectionView)
    }
    
}
