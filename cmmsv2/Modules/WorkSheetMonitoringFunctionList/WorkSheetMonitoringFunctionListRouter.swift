//
//  WorkSheetListRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/01/24.
//

import UIKit

class WorkSheetMonitoringFunctionListRouter: BaseRouter {
    
    func showView() -> WorkSheetMonitoringFunctionListView {
        let interactor = WorkSheetMonitoringFunctionListInteractor()
        let presenter = WorkSheetMonitoringFunctionListPresenter(interactor: interactor)
        let view = WorkSheetMonitoringFunctionListView(nibName: String(describing: WorkSheetMonitoringFunctionListView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}

extension WorkSheetMonitoringFunctionListRouter {
    
    func showSelectActionBottomSheet(navigation: UINavigationController, type: SelectActionBottomSheetType, delegate: WorkSheetOnsitePreventiveDelegate) {
        let bottomSheet = SelectActionBottomSheet(nibName: String(describing: SelectActionBottomSheet.self), bundle: nil)
        bottomSheet.type = type
        bottomSheet.delegate = delegate
        bottomSheet.modalPresentationStyle = .overCurrentContext
        navigation.present(bottomSheet, animated: true)
    }
    
    func navigateToDetailWorkSheet(navigation: UINavigationController) {
        let vc = WorkSheetMonitoringFunctionDetailRouter().showView()
        navigation.dismiss(animated: true)
        navigation.pushViewController(vc, animated: true)
    }
    
}
