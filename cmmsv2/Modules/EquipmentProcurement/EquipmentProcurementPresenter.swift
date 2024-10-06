// 
//  EquipmentProcurementPresenter.swift
//  cmmsv2
//
//  Created by macbook  on 05/10/24.
//

import Foundation

class EquipmentProcurementPresenter: BasePresenter {
    
    private let interactor: EquipmentProcurementInteractor
    private let router = EquipmentProcurementRouter()
    
    init(interactor: EquipmentProcurementInteractor) {
        self.interactor = interactor
    }
    
}
