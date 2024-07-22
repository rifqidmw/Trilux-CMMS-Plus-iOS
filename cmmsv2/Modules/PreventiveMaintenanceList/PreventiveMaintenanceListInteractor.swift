//
//  PreventiveMaintenanceListInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 11/03/24.
//

import Combine

class PreventiveMaintenanceListInteractor: BaseInteractor {
    
    func getWorkSheetPreventive(
        limit: Int? = nil,
        sort: String? = nil,
        keyword: String? = nil,
        idInstallation: String? = nil,
        status: String? = nil,
        page: Int? = nil) -> AnyPublisher<WorkSheetEntity, Error> {
            return api.requestApiPublisher(.workSheetPreventive(limit: limit, sort: sort, keyword: keyword, idInstallation: idInstallation, status: status, page: page))
        }
    
}
