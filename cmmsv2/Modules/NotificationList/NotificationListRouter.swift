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
    
    func showDetailNotificationBottomSheet(navigation: UINavigationController) {
        let bottomSheet = NotificationDetailBottomSheet(nibName: String(describing: NotificationDetailBottomSheet.self), bundle: nil)
        bottomSheet.modalPresentationStyle = .overCurrentContext
        navigation.present(bottomSheet, animated: true)
    }
    
}
