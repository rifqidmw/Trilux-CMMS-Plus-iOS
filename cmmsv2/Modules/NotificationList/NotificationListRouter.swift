//
//  NotificationListRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 18/02/24.
//

import UIKit

class NotificationListRouter: BaseRouter {
    
    func showView() -> NotificationListView {
        let interactor = NotificationListInteractor()
        let presenter = NotificationListPresenter(interactor: interactor)
        let view = NotificationListView(nibName: String(describing: NotificationListView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}

extension NotificationListRouter {
    
    func showBottomSheetCorrective(navigation: UINavigationController, data: WorkOrder, delegate: WorkSheetCorrectiveBottomSheetDelegate) {
        let bottomSheet = WorkSheetCorrectiveBottomSheet(nibName: String(describing: WorkSheetCorrectiveBottomSheet.self), bundle: nil)
        bottomSheet.modalPresentationStyle = .overCurrentContext
        bottomSheet.delegate = delegate
        bottomSheet.data = data
        navigation.present(bottomSheet, animated: true)
    }
    
    func navigateToDetailWorkSheetCorrective(navigation: UINavigationController, data: WorkOrder) {
        let vc = WorkSheetCorrectiveDetailRouter().showView(data: data)
        navigation.pushViewController(vc, animated: true)
    }
    
    func navigateToComplaintDetail(navigation: UINavigationController, data: Complaint) {
        let vc = ComplaintDetailRouter().showView(data: data)
        navigation.pushViewController(vc, animated: true)
    }
    
}
