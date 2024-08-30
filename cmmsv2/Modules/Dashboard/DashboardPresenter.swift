// 
//  DashboardPresenter.swift
//  cmmsv2
//
//  Created by macbook  on 28/08/24.
//

import Foundation

class DashboardPresenter: BasePresenter {
    
    private let interactor: DashboardInteractor
    private let router = DashboardRouter()
    
    init(interactor: DashboardInteractor) {
        self.interactor = interactor
    }
    
}
