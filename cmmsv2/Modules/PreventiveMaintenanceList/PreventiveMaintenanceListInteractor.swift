//
//  PreventiveMaintenanceListInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 11/03/24.
//

import Combine

class PreventiveMaintenanceListInteractor: BaseInteractor {
    
    func getWorkSheetPreventive(limit: Int? = nil,
                                page: Int? = nil,
                                engineer: Int? = nil) -> AnyPublisher<PreventiveMaintenanceData, Error> {
        return api.requestApiPublisher(.workSheetPreventive(limit: limit, page: page, engineer: engineer))
    }
    
}
