// 
//  PreventiveCalendarListRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 18/03/24.
//

import UIKit

class PreventiveCalendarListRouter: BaseRouter {
    
    func showView() -> PreventiveCalendarListView {
        let interactor = PreventiveCalendarListInteractor()
        let presenter = PreventiveCalendarListPresenter(interactor: interactor)
        let view = PreventiveCalendarListView(nibName: String(describing: PreventiveCalendarListView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}

extension PreventiveCalendarListRouter {
    
    func navigateToLoadPreventive(_ navigation: UINavigationController, data: WorkSheetListEntity) {
        let vc = LoadPreventiveRouter().showView(data: data)
        navigation.pushViewController(vc, animated: true)
        
    }
    
    func showPreventiveBottomSheet(_ navigation: UINavigationController, delegate: PreventiveSchedulerBottomSheetDelegate) {
        let bottomSheet = PreventiveSchedulerBottomSheet(nibName: String(describing: PreventiveSchedulerBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        bottomSheet.modalTransitionStyle = .coverVertical
        bottomSheet.modalPresentationStyle = .overCurrentContext
        navigation.present(bottomSheet, animated: true)
    }
    
}

