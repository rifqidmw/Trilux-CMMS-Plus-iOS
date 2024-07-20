//
//  WorkSheetOnsitePreventiveDetailRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/02/24.
//

import UIKit

class WorkSheetDetailRouter: BaseRouter {
    
    func showView(type: WorkSheetDetailType, data: WorkSheetRequestEntity, activity: WorkSheetActivityType = .view, delegate: WorkSheetDetailViewDelegate? = nil) -> WorkSheetDetailView {
        let interactor = WorkSheetDetailInteractor()
        let router = WorkSheetDetailRouter()
        let presenter = WorkSheetDetailPresenter(interactor: interactor, router: router, type: type, data: data, activity: activity)
        let view = WorkSheetDetailView(nibName: String(describing: WorkSheetDetailView.self), bundle: nil)
        view.presenter = presenter
        view.delegate = delegate
        return view
    }
    
}

extension WorkSheetDetailRouter {
    
    func showBottomSheet(nav: UINavigationController, bottomSheetView: UIViewController) {
        bottomSheetView.loadViewIfNeeded()
        bottomSheetView.modalPresentationStyle = .overCurrentContext
        UIApplication.topViewController()?.present(bottomSheetView, animated: true, completion: nil)
    }
    
}
