// 
//  HistoryListPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/03/24.
//

import Foundation

class HistoryListPresenter: BasePresenter {
    
    private let interactor: HistoryListInteractor
    private let router = HistoryListRouter()
    
    init(interactor: HistoryListInteractor) {
        self.interactor = interactor
    }
    
}
