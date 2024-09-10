//
//  EquipmentManagementPresenter.swift
//  cmmsv2
//
//  Created by macbook  on 10/09/24.
//

import Foundation

class EquipmentManagementPresenter: BasePresenter {
    
    private let interactor: EquipmentManagementInteractor
    private let router: EquipmentManagementRouter
    let type: EquipmentManagementType
    
    init(interactor: EquipmentManagementInteractor, router: EquipmentManagementRouter, type: EquipmentManagementType) {
        self.interactor = interactor
        self.router = router
        self.type = type
    }
    
}
