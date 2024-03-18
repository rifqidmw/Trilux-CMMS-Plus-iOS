//
//  LogBookPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 17/03/24.
//

import Foundation

class LogBookPresenter: BasePresenter {
    
    private let interactor: LogBookInteractor
    private let router = LogBookRouter()
    
    init(interactor: LogBookInteractor) {
        self.interactor = interactor
    }
    
}
