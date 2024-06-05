//
//  BaseRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import Foundation
import UIKit

class BaseRouter {
    
    func backToHomeScreen() {
        let vc = HomeScreenRouter().showView()
        let rootController = UINavigationController(rootViewController: vc)
        UIApplication.shared.windows.first?.rootViewController = rootController
    }
    
    func navigateToDetailPicture(navigation: UINavigationController, image: String) {
        let vc = FullScreenPictureRouter().showView(image: image)
        navigation.pushViewController(vc, animated: true)
    }
    
    func showSelectActionBottomSheet(_ navigation: UINavigationController,
                                     type: WorkSheetStatus,
                                     delegate: WorkSheetOnsitePreventiveDelegate) {
        let bottomSheet = SelectActionBottomSheet(nibName: String(describing: SelectActionBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        bottomSheet.type = type
        bottomSheet.modalPresentationStyle = .overCurrentContext
        navigation.present(bottomSheet, animated: true)
    }
    
    func navigateToDetailWorkSheet(_ navigation: UINavigationController,
                                   data: WorkSheetRequestEntity,
                                   type: WorkSheetDetailType) {
        let vc = WorkSheetDetailRouter().showView(type: type, data: data)
        navigation.dismiss(animated: true)
        navigation.pushViewController(vc, animated: true)
    }
    
}
