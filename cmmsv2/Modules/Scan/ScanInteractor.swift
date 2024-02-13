//
//  ScanInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/02/24.
//

import Foundation
import Combine

class ScanInteractor: BaseInteractor {
    
    func getDetailEquipment(id: String) -> AnyPublisher<ScanEquipmentEntity, Error> {
        api.requestApiPublisher(.detailAssetEquipment(id: id))
    }
    
}
