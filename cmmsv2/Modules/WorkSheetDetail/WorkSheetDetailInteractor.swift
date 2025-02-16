//
//  WorkSheetOnsitePreventiveDetailInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/02/24.
//

import Combine

class WorkSheetDetailInteractor: BaseInteractor {
    
    func getDetailMonitoringFunction(id: String?, action: String?) -> AnyPublisher<MonitoringFunctionEntity, Error> {
        return api.requestApiPublisher(.workSheetDetail(id: id ?? "", action: action ?? ""))
    }
    
    func getCalibratorList() -> AnyPublisher<KalibratorEntity, Error> {
        return api.requestApiPublisher(.calibrator)
    }
    
    func saveWorkSheet(data: LKStartRequest) -> AnyPublisher<SaveWorkSheetResponseEntity, Error> {
        return api.requestApiPublisher(.saveWorkSheet(data: data))
    }
    
    func getSparePartList(key: String? = nil) -> AnyPublisher<SearchSparePartEntity, Error> {
        return api.requestApiPublisher(.searchSparePart(key: key ?? ""))
    }
    
}
