// 
//  WorkSheetListPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/01/24.
//

import UIKit

class WorkSheetListPresenter: BasePresenter {
    
    private let interactor: WorkSheetListInteractor
    private let router = WorkSheetListRouter()
    
    init(interactor: WorkSheetListInteractor) {
        self.interactor = interactor
    }
    
}

extension WorkSheetListPresenter {
    
    func backToPreviousPage() {
        router.backToHomeScreen()
    }
    
    func showBottomSheetPreviewWorkSheet(navigation: UINavigationController) {
        router.showPreviewWorkSheetBottomSheet(navigation: navigation)
    }
    
}
