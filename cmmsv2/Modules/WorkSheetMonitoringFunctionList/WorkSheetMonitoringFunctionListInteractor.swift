//
//  WorkSheetListInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/01/24.
//

import Combine

class WorkSheetMonitoringFunctionListInteractor: BaseInteractor {
    
    func getWorkSheetMonitoringFunctionList(limit: Int? = nil,
                                            page: Int? = nil,
                                            tipe: Int? = nil,
                                            keyboard: String? = nil,
                                            status: String? = nil) -> AnyPublisher<MaintenanceDataLK, Error> {
        return api.requestApiPublisher(.workSheetMonitoringFunction(
            limit: limit,
            page: page,
            tipe: tipe,
            keyboard: keyboard,
            status: status))
    }
    
}
