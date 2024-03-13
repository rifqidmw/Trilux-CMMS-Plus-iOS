// 
//  CalibrationListPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 12/03/24.
//

import Foundation

class CalibrationListPresenter: BasePresenter {
    
    private let interactor: CalibrationListInteractor
    private let router = CalibrationListRouter()
    
    init(interactor: CalibrationListInteractor) {
        self.interactor = interactor
    }
    
}
