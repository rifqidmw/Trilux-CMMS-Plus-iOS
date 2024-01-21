// 
//  WorkSheetOnsitePreventiveListPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 22/01/24.
//

import UIKit

class WorkSheetOnsitePreventiveListPresenter: BasePresenter {
    
    private let interactor: WorkSheetOnsitePreventiveListInteractor
    private let router = WorkSheetOnsitePreventiveListRouter()
    
    init(interactor: WorkSheetOnsitePreventiveListInteractor) {
        self.interactor = interactor
    }
    
}

extension WorkSheetOnsitePreventiveListPresenter {
    
    func backToPreviousPage() {
        router.backToHomeScreen()
    }
    
    func showBottomSheetAction(navigation: UINavigationController, type: WorkSheetActionType) {
        router.showActionBottomSheet(navigation: navigation, type: type)
    }
    
}
