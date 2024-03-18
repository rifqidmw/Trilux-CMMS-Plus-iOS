// 
//  PreventiveCalendarListPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 18/03/24.
//

import Foundation

class PreventiveCalendarListPresenter: BasePresenter {
    
    private let interactor: PreventiveCalendarListInteractor
    private let router = PreventiveCalendarListRouter()
    
    init(interactor: PreventiveCalendarListInteractor) {
        self.interactor = interactor
    }
    
}
