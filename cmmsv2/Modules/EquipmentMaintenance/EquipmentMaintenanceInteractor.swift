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
    
    func getInspection(limit: Int, id: String?, page: Int) -> AnyPublisher<InspectionEntity, Error> {
        return api.requestApiPublisher(.inspection(limit: limit, id: id, page: page))
    }
    
    func getPreventive(limit: Int, id: String?, page: Int) -> AnyPublisher<InspectionEntity, Error> {
        return api.requestApiPublisher(.equipmentPreventive(limit: limit, id: id, page: page))
    }
    
    func getCalibration(limit: Int, id: String?, page: Int) -> AnyPublisher<EquipmentCalibrationEntity, Error> {
        return api.requestApiPublisher(.equipmentCalibration(limit: limit, id: id, page: page))
    }
    
    func getEquipmentComplaint(limit: Int, id: String?, page: Int) -> AnyPublisher<EquipmentComplaintEntity, Error> {
        return api.requestApiPublisher(.equipmentComplaint(limit: limit, id: id, page: page))
    }
    
}
