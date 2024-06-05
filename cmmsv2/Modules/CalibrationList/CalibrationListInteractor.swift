//
//  CalibrationListInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 12/03/24.
//

import Combine

class CalibrationListInteractor: BaseInteractor {
    
    func getCalibrationList(keyword: String? = nil, limit: Int? = nil, page: Int? = nil) -> AnyPublisher<WorkSheetEntity, Error> {
        return api.requestApiPublisher(.calibrationList(keyword: keyword, limit: limit, page: page))
    }
    
}
