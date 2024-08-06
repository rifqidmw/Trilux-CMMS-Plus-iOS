// 
//  WorkSheetDetailPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 21/01/24.
//

import UIKit

class WorkSheetMonitoringFunctionDetailPresenter: BasePresenter {
    
    private let interactor: WorkSheetMonitoringFunctionDetailInteractor
    private let router = WorkSheetMonitoringFunctionDetailRouter()
    
    init(interactor: WorkSheetMonitoringFunctionDetailInteractor) {
        self.interactor = interactor
    }
    
}

extension WorkSheetMonitoringFunctionDetailPresenter {
    
    func showBottomSheetAllEvidence(navigation: UINavigationController) {
        router.showAllEvidenceBottomSheet(navigation: navigation)
    }
    
}
