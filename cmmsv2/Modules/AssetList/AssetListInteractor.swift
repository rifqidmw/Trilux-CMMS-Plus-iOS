//
//  AssetListInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/02/24.
//

import Combine

class AssetListInteractor: BaseInteractor {
    
    func getListAsset(serial: String ,
                      locationId: String,
                      limit: Int,
                      page: Int,
                      search: String,
                      type: String,
                      sstMedic: String) -> AnyPublisher<EquipmentEntity, Error> {
        return api.requestApiPublisher(.assetList(
            serial: serial,
            locationId: locationId,
            limit: limit,
            page: page,
            search: search,
            type: type,
            sstMedic: sstMedic))
    }
    
}
