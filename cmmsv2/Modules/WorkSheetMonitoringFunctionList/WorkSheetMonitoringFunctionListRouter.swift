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
    
    func showSelectActionBottomSheet(navigation: UINavigationController,
                                     type: WorkSheetStatus,
                                     delegate: WorkSheetOnsitePreventiveDelegate) {
        let bottomSheet = SelectActionBottomSheet(nibName: String(describing: SelectActionBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        bottomSheet.type = type
        bottomSheet.modalPresentationStyle = .overCurrentContext
        navigation.present(bottomSheet, animated: true)
    }
    
    func navigateToDetailWorkSheet(navigation: UINavigationController, data: WorkSheetRequestEntity) {
        let vc = WorkSheetDetailRouter().showView(type: .monitoring, data: data)
        navigation.dismiss(animated: true)
        navigation.pushViewController(vc, animated: true)
    }
    
}
