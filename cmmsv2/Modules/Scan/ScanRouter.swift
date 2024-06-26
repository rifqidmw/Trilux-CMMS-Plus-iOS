//
//  ScanRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/02/24.
//

import UIKit

class ScanRouter: BaseRouter {
    
    func showView(type: ScanType = .asset, data: WorkSheetListEntity? = nil) -> ScanView {
        let interactor = ScanInteractor()
        let presenter = ScanPresenter(interactor: interactor, router: self, type: type, data: data ?? .init(idAsset: ""))
        let view = ScanView(nibName: String(describing: ScanView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}

extension ScanRouter {
    
    func showBottomSheetDetailInformation(navigation: UINavigationController, data: ScanEquipment) {
        let bottomSheet = DetailAssetBottomSheet(nibName: String(describing: DetailAssetBottomSheet.self), bundle: nil)
        bottomSheet.modalPresentationStyle = .overCurrentContext
        bottomSheet.equipment = data
        navigation.present(bottomSheet, animated: true)
    }
    
    func navigateToLoadPreventive(_ navigation: UINavigationController, data: WorkSheetListEntity) {
        let vc = LoadPreventiveRouter().showView(data: data)
        navigation.pushViewController(vc, animated: true)
    }
    
}
