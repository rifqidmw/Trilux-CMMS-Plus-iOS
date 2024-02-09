//
//  WorkSheetOnsitePreventiveDetailPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/02/24.
//

import Foundation

class WorkSheetOnsitePreventiveDetailPresenter: BasePresenter {
    
    private let interactor: WorkSheetOnsitePreventiveDetailInteractor
    private let router: WorkSheetOnsitePreventiveDetailRouter
    let type: WorkSheetOnsitePreventiveDetailType
    
    init(interactor: WorkSheetOnsitePreventiveDetailInteractor, router: WorkSheetOnsitePreventiveDetailRouter, type: WorkSheetOnsitePreventiveDetailType) {
        self.interactor = interactor
        self.router = router
        self.type = type
    }
    
}
