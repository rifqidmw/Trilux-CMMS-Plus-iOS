//
//  EquipmentMaintenanceInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/08/24.
//

import Combine

class EquipmentMaintenanceInteractor: BaseInteractor {
    
    func getAssetTechnical(id: String?) -> AnyPublisher<EquipmentTechnicalEntity, Error> {
        return api.requestApiPublisher(.assetTechnical(id: id ?? ""))
    }
    
    func getAssetMainStatus(id: String?) -> AnyPublisher<EquipmentMainStatusEntity, Error> {
        return api.requestApiPublisher(.equipmentMainStatus(id: id ?? ""))
    }
    
    func getAssetMainCost(id: String?) -> AnyPublisher<EquipmentMainCoastEntity, Error> {
        return api.requestApiPublisher(.assetMainCost(id: id))
    }
    
}
