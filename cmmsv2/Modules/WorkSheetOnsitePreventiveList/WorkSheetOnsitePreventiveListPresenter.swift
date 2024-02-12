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
    
    func navigateToDetailPage(navigation: UINavigationController, type: WorkSheetOnsitePreventiveDetailType) {
        router.navigateToDetailPage(navigation: navigation, type: type)
    }
    
    func showBottomSheetAction(navigation: UINavigationController, type: WorkSheetActionType, delegate: WorkSheetOnsitePreventiveDelegate) {
        router.showActionBottomSheet(navigation: navigation, type: type, delegate: delegate)
    }
    
}
