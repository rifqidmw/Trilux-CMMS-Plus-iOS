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
    
    func navigateToDetailPicture(navigation: UINavigationController, image: String) {
        router.navigateToDetailPicture(navigation: navigation, image: image)
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
    
    func backToPreviousPage(from navigation: UINavigationController, _ view: UIViewController) {
        router.backToPreviousPage(from: navigation, view)
    }
    
}
