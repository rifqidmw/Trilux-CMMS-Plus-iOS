//
//  AssetFilterInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 25/07/24.
//

import Foundation
import Combine

class AssetFilterInteractor: BaseInteractor {
    
    func getListAsset(
        search: String? = nil,
        condition: String? = nil,
        limit: Int? = nil,
        type: String? = nil,
        sttKalibrasi: String? = nil,
        category: String? = nil,
        sort: String? = nil,
        sttQr: String? = nil,
        idInstallation: String? = nil,
        idRoom: String? = nil,
        page: Int? = nil) -> AnyPublisher<EquipmentEntity, Error> {
            return api.requestApiPublisher(.assetList(
                search: search,
                condition: condition,
                limit: limit,
                type: type,
                sttKalibrasi: sttKalibrasi,
                category: category,
                sort: sort,
                sttQr: sttQr,
                idInstallation: idInstallation,
                idRoom: idRoom,
                page: page))
        }
    
    func getInstallationList() -> AnyPublisher<InstallationEntity, Error> {
        return api.requestApiPublisher(.getInstallation)
    }
    
}
