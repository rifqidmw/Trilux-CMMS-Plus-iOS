// 
//  EquipmentProcurementPresenter.swift
//  cmmsv2
//
//  Created by macbook  on 05/10/24.
//

import Foundation

class EquipmentProcurementPresenter: BasePresenter {
    
    private let interactor: EquipmentProcurementInteractor
    private let router: EquipmentProcurementRouter
    let data: RoomRequirementListData?
    
    init(interactor: EquipmentProcurementInteractor, router: EquipmentProcurementRouter, data: RoomRequirementListData?) {
        self.interactor = interactor
        self.router = router
        self.data = data
    }
    
}
