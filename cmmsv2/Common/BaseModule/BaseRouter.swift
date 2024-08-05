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
    
    func navigateToDetailDocument(navigation: UINavigationController, file: String?, type: DocumentType) {
        let vc = DocumentRouter().showView(file: file ?? "", type: type)
        navigation.pushViewController(vc, animated: true)
    }
    
    func showSelectActionBottomSheet(
        _ navigation: UINavigationController,
        type: WorkSheetStatus,
        delegate: WorkSheetOnsitePreventiveDelegate) {
            let bottomSheet = SelectActionBottomSheet(nibName: String(describing: SelectActionBottomSheet.self), bundle: nil)
            bottomSheet.delegate = delegate
            bottomSheet.type = type
            bottomSheet.modalPresentationStyle = .overCurrentContext
            navigation.present(bottomSheet, animated: true)
        }
    
    func navigateToDetailWorkSheet(
        _ navigation: UINavigationController,
        data: WorkSheetRequestEntity,
        type: WorkSheetDetailType,
        activity: WorkSheetActivityType,
        delegate: WorkSheetDetailViewDelegate? = nil) {
            let vc = WorkSheetDetailRouter().showView(type: type, data: data, activity: activity, delegate: delegate)
            navigation.dismiss(animated: true)
            navigation.pushViewController(vc, animated: true)
        }
    
    func showBottomSheet(navigation: UINavigationController, view: UIViewController) {
        view.loadViewIfNeeded()
        view.modalTransitionStyle = .coverVertical
        view.modalPresentationStyle = .overCurrentContext
        UIApplication.topViewController()?.present(view, animated: true, completion: nil)
    }
    
    func navigateToScan(from navigation: UINavigationController, _ type: ScanType, data: WorkSheetListEntity? = nil, request: WorkSheetRequestEntity? = nil, delegate: ScanViewDelegate? = nil) {
        let vc = ScanRouter().showView(type: type, data: data, request: request, delegate: delegate)
        navigation.pushViewController(vc, animated: true)
    }
    
    func backToPreviousPage(from navigation: UINavigationController, _ targetViewController: UIViewController) {
        let viewControllers = navigation.viewControllers
        for viewController in viewControllers {
            if viewController.isKind(of: targetViewController.classForCoder) {
                navigation.popToViewController(viewController, animated: true)
                return
            }
        }
    }
    
    func goToLoginPage(navigation: UINavigationController, data: HospitalTheme) {
        let vc = LoginRouter().showView()
        vc.data = data
        let rootViewController = UINavigationController(rootViewController: vc)
        UIApplication.shared.setRootViewController(rootViewController)
    }
    
    func navigateToDetailAsset(from navigation: UINavigationController, _ type: AssetType, data: Equipment) {
        let vc = AssetDetailRouter().showView(type: type, data: data)
        navigation.pushViewController(vc, animated: true)
    }
    
    func navigateToAssetFilter(from navigation: UINavigationController) {
        let vc = AssetFilterRouter().showView()
        navigation.pushViewController(vc, animated: true)
    }
    
}
