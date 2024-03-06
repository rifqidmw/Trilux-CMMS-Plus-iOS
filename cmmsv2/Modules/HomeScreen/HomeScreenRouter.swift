// 
//  HomeScreenRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/01/24.
//

import UIKit

class HomeScreenRouter: BaseRouter {
    
    func showView() -> HomeScreenView {
        let interactor = HomeScreenInteractor()
        let presenter = HomeScreenPresenter(interactor: interactor)
        let view = HomeScreenView(nibName: String(describing: HomeScreenView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}

extension HomeScreenRouter {
    
    func navigateToWorkSheetList(navigation: UINavigationController) {
        let vc = WorkSheetListRouter().showView()
        navigation.dismiss(animated: true)
        navigation.pushViewController(vc, animated: true)
    }
    
    func navigateToWorkSheetOnsitePreventive(navigation: UINavigationController) {
        let vc = WorkSheetOnsitePreventiveListRouter().showView()
        navigation.dismiss(animated: true)
        navigation.pushViewController(vc, animated: true)
    }
    
    func showBottomSheet(view: UIViewController, navigation: UINavigationController) {
        view.modalPresentationStyle = .overCurrentContext
        navigation.present(view, animated: true)
    }
    
    func goToUserProfile(navigation: UINavigationController) {
        let vc = UserProfileRouter().showView()
        navigation.pushViewController(vc, animated: true)
    }
    
    func navigateToAssetList(navigation: UINavigationController) {
        let vc = MedicAssetListRouter().showView()
        navigation.dismiss(animated: true)
        navigation.pushViewController(vc, animated: true)
    }
    
    func navigateToScan(navigation: UINavigationController) {
        let vc = ScanRouter().showView()
        navigation.pushViewController(vc, animated: true)
    }
    
    func navigateToNotificationList(navigation: UINavigationController) {
        let vc = NotificationListRouter().showView()
        navigation.pushViewController(vc, animated: true)
    }
    
}
