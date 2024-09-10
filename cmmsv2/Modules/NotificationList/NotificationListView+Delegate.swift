//
//  NotificationListView+Delegate.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 08/06/24.
//

import UIKit

extension NotificationListView: WorkSheetCorrectiveBottomSheetDelegate {
    
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

extension NotificationListView: ScanViewDelegate {
    
    func didNavigateAfterSaveWorkSheet() {
        guard let presenter, let navigation = self.navigationController else { return }
        let view = WorkSheetCorrectiveListRouter().showView()
        presenter.backToPreviousPage(from: navigation, view)
    }
    
}

extension NotificationListView: WorkSheetDetailViewDelegate {
    
    func didSaveWorkSheet() {
        guard let navigation = self.navigationController else { return }
        navigation.popViewController(animated: true)
    }
    
}

extension NotificationListView: RatingBottomSheetDelegate {
    
    func didTapPicture(img: String) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToDetailDocument(navigation: navigation, file: img, type: .image)
    }
    
    func didTapRating(isCanRating: String) {
        if isCanRating == "0" {
            self.showAlert(title: "Terjadi kesalahan", message: "Maaf, lembar kerja ini belum bisa diberikan Rating.")
        } else {
            self.showAlert(title: "Pemberitahuan", message: "Lembar kerja ini sudah bisa diberikan Rating.")
        }
    }
    
}
