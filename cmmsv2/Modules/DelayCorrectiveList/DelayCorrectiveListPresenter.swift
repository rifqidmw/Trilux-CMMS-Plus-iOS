//
//  CorrectiveHoldListPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/03/24.
//

import Foundation

class DelayCorrectiveListPresenter: BasePresenter {
    
    private let interactor: DelayCorrectiveListInteractor
    private let router = DelayCorrectiveListRouter()
    
    init(interactor: DelayCorrectiveListInteractor) {
        self.interactor = interactor
    }
    
}
