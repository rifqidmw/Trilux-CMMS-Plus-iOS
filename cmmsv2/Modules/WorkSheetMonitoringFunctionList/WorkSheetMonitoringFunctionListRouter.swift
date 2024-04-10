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
    
    func showPreviewWorkSheetBottomSheet(navigation: UINavigationController, delegate: WorkSheetListDelegate) {
        let bottomSheet = WorkSheetPreviewBottomSheet(nibName: String(describing: WorkSheetPreviewBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        //  bottomSheet.data = // entered data here
        bottomSheet.modalPresentationStyle = .overCurrentContext
        navigation.present(bottomSheet, animated: true)
    }
    
    func navigateToDetailWorkSheet(navigation: UINavigationController) {
        let vc = WorkSheetMonitoringFunctionDetailRouter().showView()
        navigation.dismiss(animated: true)
        navigation.pushViewController(vc, animated: true)
    }
    
}
