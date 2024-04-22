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
                                            keyword: String? = nil,
                                            status: Int? = nil) -> AnyPublisher<WorkSheetEntity, Error> {
        return api.requestApiPublisher(.workSheetMonitoringFunction(
            limit: limit,
            page: page,
            tipe: tipe,
            keyword: keyword,
            status: status))
    }
    
}
