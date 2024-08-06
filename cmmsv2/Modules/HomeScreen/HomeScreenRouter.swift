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
    
    func navigateToWorkSheetMonitoringList(from navigation: UINavigationController) {
        let vc = WorkSheetMonitoringFunctionListRouter().showView()
        navigation.dismiss(animated: true)
        navigation.pushViewController(vc, animated: true)
    }
    
    func navigateToWorkSheetCorrective(navigation: UINavigationController) {
        let vc = WorkSheetCorrectiveListRouter().showView()
        navigation.dismiss(animated: true)
        navigation.pushViewController(vc, animated: true)
    }
    
    func goToUserProfile(navigation: UINavigationController) {
        let vc = UserProfileRouter().showView()
        navigation.pushViewController(vc, animated: true)
    }
    
    func navigateToAssetMedicList(navigation: UINavigationController) {
        let vc = AssetListRouter().showView(type: .medic)
        navigation.dismiss(animated: true)
        navigation.pushViewController(vc, animated: true)
    }
    
    func navigateToAssetNonMedicList(navigation: UINavigationController) {
        let vc = AssetListRouter().showView(type: .nonMedic)
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
    
    func navigateToComplaintList(navigation: UINavigationController) {
        let vc = ComplaintListRouter().showView()
        navigation.pushViewController(vc, animated: true)
    }
    
    func navigateToCalibrationList(navigation: UINavigationController) {
        let vc = CalibrationListRouter().showView()
        navigation.dismiss(animated: true)
        navigation.pushViewController(vc, animated: true)
    }
    
    func navigateToPreventiveMaintenanceList(navigation: UINavigationController) {
        let vc = PreventiveMaintenanceListRouter().showView()
        navigation.dismiss(animated: true)
        navigation.pushViewController(vc, animated: true)
    }
    
    func navigateToDelayCorrectiveList(navigation: UINavigationController) {
        let vc = DelayCorrectiveListRouter().showView()
        navigation.pushViewController(vc, animated: true)
    }
    
    func navigateToHistoryList(navigation: UINavigationController) {
        let vc = HistoryListRouter().showView()
        navigation.pushViewController(vc, animated: true)
    }
    
    func navigateToLogBook(navigation: UINavigationController) {
        let vc = LogBookListRouter().showView()
        navigation.pushViewController(vc, animated: true)
    }
    
    func navigateToCalendarPreventive(navigation: UINavigationController) {
        let vc = PreventiveCalendarListRouter().showView()
        navigation.pushViewController(vc, animated: true)
    }
    
    func navigateToWorkSheetApproval(from navigation: UINavigationController) {
        let vc = WorkSheetApprovalListRouter().showView()
        navigation.pushViewController(vc, animated: true)
    }
    
}
