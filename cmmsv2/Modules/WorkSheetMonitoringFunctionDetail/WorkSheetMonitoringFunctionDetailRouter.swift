// 
//  WorkSheetDetailRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 21/01/24.
//

import UIKit

class WorkSheetMonitoringFunctionDetailRouter: BaseRouter {
    
    func showView() -> WorkSheetMonitoringFunctionDetailView {
        let interactor = WorkSheetMonitoringFunctionDetailInteractor()
        let presenter = WorkSheetMonitoringFunctionDetailPresenter(interactor: interactor)
        let view = WorkSheetMonitoringFunctionDetailView(nibName: String(describing: WorkSheetMonitoringFunctionDetailView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}

extension WorkSheetMonitoringFunctionDetailRouter {
    
    func showAllEvidenceBottomSheet(navigation: UINavigationController) {
        let bottomSheet = AllEvidenceBottomSheet(nibName: String(describing: AllEvidenceBottomSheet.self), bundle: nil)
        bottomSheet.modalPresentationStyle = .overCurrentContext
        navigation.present(bottomSheet, animated: true)
    }
    
}
