//
//  BasePresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import Foundation
import Combine
import UIKit

class BasePresenter: NSObject {
    var anyCancellable = Set<AnyCancellable>()
    private let router = BaseRouter()
}

extension BasePresenter {
    
    func navigateToDetailDocument(navigation: UINavigationController, file: String?, type: DocumentType = .image) {
        router.navigateToDetailDocument(navigation: navigation, file: file ?? "", type: type)
    }
    
    func showSelectActionBottomSheet(
        _ navigation: UINavigationController,
        type: WorkSheetStatus,
        delegate: WorkSheetOnsitePreventiveDelegate,
        id: String?) {
            router.showSelectActionBottomSheet(
                navigation,
                type: type,
                delegate: delegate)
        }
    
    func navigateToDetailWorkSheet(
        _ navigation: UINavigationController,
        data: WorkSheetRequestEntity,
        type: WorkSheetDetailType,
        activity: WorkSheetActivityType = .view,
        delegate: WorkSheetDetailViewDelegate? = nil) {
            router.navigateToDetailWorkSheet(
                navigation,
                data: data,
                type: type,
                activity: activity,
                delegate: delegate)
        }
    
    func showUploadMediaBottomSheet(navigation: UINavigationController, delegate: UploadMediaBottomSheetDelegate) {
        let bottomSheet = UploadMediaBottomSheet(nibName: String(describing: UploadMediaBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func navigateToScan(from navigation: UINavigationController, _ type: ScanType, data: WorkSheetListEntity? = nil, request: WorkSheetRequestEntity? = nil, delegate: ScanViewDelegate? = nil) {
        router.navigateToScan(from: navigation, type, data: data, request: request, delegate: delegate)
    }
    
    func showConfirmDeleteDelegateLk(navigation: UINavigationController, delegate: DeleteComplaintBottomSheetDelegate, data: Complaint) {
        let bottomSheet = DeleteComplaintBottomSheet(nibName: String(describing: DeleteComplaintBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        bottomSheet.data = data
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showRatingBottomSheet(navigation: UINavigationController, data: HistoryDetailEntity.HistoryDetailData?, _ delegate: RatingBottomSheetDelegate) {
        let bottomSheet = RatingBottomSheet(nibName: String(describing: RatingBottomSheet.self), bundle: nil)
        bottomSheet.data = data
        bottomSheet.delegate = delegate
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func backToPreviousPage(from navigation: UINavigationController, _ view: UIViewController) {
        router.backToPreviousPage(from: navigation, view)
    }
    
    func navigateToLoginPage(navigation: UINavigationController, data: HospitalTheme) {
        router.goToLoginPage(navigation: navigation, data: data)
    }
    
    func navigateToDetailAsset(from navigation: UINavigationController, _ type: AssetType, id: String?) {
        router.navigateToDetailAsset(from: navigation, type, id: id ?? "")
    }
    
    func navigateToAssetFilter(from navigation: UINavigationController) {
        router.navigateToAssetFilter(from: navigation)
    }
    
    func navigateToComplaintDetail(navigation: UINavigationController, id: String?) {
        router.navigateToComplaintDetail(navigation: navigation, id: id ?? "")
    }
    
    func navigateToDetailDelayCorrective(from navigation: UINavigationController, id: String?) {
        router.navigateToDetailDelayCorrective(from: navigation, id: id ?? "")
    }
    
    func navigateToHistoryDetail(navigation: UINavigationController, id: String?) {
        router.navigateToHistoryDetail(navigation: navigation, id: id ?? "")
    }
    
    func navigateToHomeScreen(navigation: UINavigationController) {
        router.goToHomeScreen(navigation: navigation)
    }
    
    func navigateToDetailWorkSheetCorrective(navigation: UINavigationController, _ idAsset: String?, _ idComplaint: String?, valType: String?) {
        router.navigateToDetailWorkSheetCorrective(navigation: navigation, idAsset ?? "", idComplaint ?? "", valType: valType ?? "")
    }
    
    func navigateToLoadPreventive(_ navigation: UINavigationController, idAsset: String?, idLk: String?) {
        router.navigateToLoadPreventive(navigation, idAsset: idAsset ?? "", idLk: idLk ?? "")
    }
    
    func navigateToWorkSheetApprovalDetail(from navigation: UINavigationController, id: String?) {
        router.navigateToWorkSheetApprovalDetail(from: navigation, id: id ?? "")
    }
    
}
