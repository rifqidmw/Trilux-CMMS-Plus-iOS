//
//  DashboardInteractor.swift
//  cmmsv2
//
//  Created by macbook  on 28/08/24.
//

import Combine

class DashboardInteractor: BaseInteractor {
    
    func getDashboardPerformance(
        month: String?,
        year: String?,
        id: String?) -> AnyPublisher<DashboardEngineerEntity, Error> {
            return api.requestApiPublisher(.engineerDashboardStatistic(
                month: month ?? "",
                year: year ?? "",
                id: id ?? ""))
        }
    
}
