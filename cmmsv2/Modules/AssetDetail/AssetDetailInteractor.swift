//
//  AssetDetailInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 01/05/24.
//

import Combine

class AssetDetailInteractor: BaseInteractor {
    
    func getAssetDetailInformation(id: String?) -> AnyPublisher<AssetDetailEntity, Error> {
        return api.requestApiPublisher(.assetDetail(id: id))
    }
    
    func getAssetFiles(id: String?) -> AnyPublisher<EquipmentFilesEntity, Error> {
        return api.requestApiPublisher(.assetFiles(id: id))
    }
    
    func getAssetMainCost(id: String?) -> AnyPublisher<EquipmentMainCoastEntity, Error> {
        return api.requestApiPublisher(.assetMainCost(id: id))
    }
    
    func getAssetTechnical(id: String?) -> AnyPublisher<EquipmentTechnicalEntity, Error> {
        return api.requestApiPublisher(.assetTechnical(id: id))
    }
    
    func getAssetAcceptance(id: String?) -> AnyPublisher<DeliveryAcceptanceEntity, Error> {
        return api.requestApiPublisher(.assetAcceptance(id: id))
    }
    
    func getComplaintTracking(id: String?) -> AnyPublisher<TrackComplaintEntity, Error> {
        return api.requestApiPublisher(.trackComplaint(id: id ?? ""))
    }
    
}
