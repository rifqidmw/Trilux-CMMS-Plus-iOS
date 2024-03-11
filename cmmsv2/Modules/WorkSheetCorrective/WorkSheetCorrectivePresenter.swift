// 
//  WorkSheetCorrectivePresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/03/24.
//

import Foundation

class WorkSheetCorrectivePresenter: BasePresenter {
    
    private let interactor: WorkSheetCorrectiveInteractor
    private let router = WorkSheetCorrectiveRouter()
    
    init(interactor: WorkSheetCorrectiveInteractor) {
        self.interactor = interactor
    }
    
}
