//
//  WorkSheetListPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/01/24.
//

import UIKit

class WorkSheetMonitoringFunctionListPresenter: BasePresenter {
    
    private let interactor: WorkSheetMonitoringFunctionListInteractor
    private let router = WorkSheetMonitoringFunctionListRouter()
    
    init(interactor: WorkSheetMonitoringFunctionListInteractor) {
        self.interactor = interactor
    }
    
}

extension WorkSheetMonitoringFunctionListPresenter {
    
    func showBottomSheetPreviewWorkSheet(navigation: UINavigationController, delegate: WorkSheetListDelegate) {
        router.showPreviewWorkSheetBottomSheet(navigation: navigation, delegate: delegate)
    }
    
    func navigateToDetailWorkSheet(navigation: UINavigationController) {
        router.navigateToDetailWorkSheet(navigation: navigation)
    }
    
}
