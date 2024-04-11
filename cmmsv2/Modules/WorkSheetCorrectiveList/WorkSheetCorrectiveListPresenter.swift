// 
//  WorkSheetCorrectivePresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/03/24.
//

import Foundation

class WorkSheetCorrectiveListPresenter: BasePresenter {
    
    private let interactor: WorkSheetCorrectiveListInteractor
    private let router = WorkSheetCorrectiveListRouter()
    
    init(interactor: WorkSheetCorrectiveListInteractor) {
        self.interactor = interactor
    }
    
}
