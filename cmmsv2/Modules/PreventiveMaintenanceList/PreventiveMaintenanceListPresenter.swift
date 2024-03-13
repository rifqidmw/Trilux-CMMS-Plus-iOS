// 
//  PreventiveMaintenanceListPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 11/03/24.
//

import Foundation

class PreventiveMaintenanceListPresenter: BasePresenter {
    
    private let interactor: PreventiveMaintenanceListInteractor
    private let router = PreventiveMaintenanceListRouter()
    
    init(interactor: PreventiveMaintenanceListInteractor) {
        self.interactor = interactor
    }
    
}
