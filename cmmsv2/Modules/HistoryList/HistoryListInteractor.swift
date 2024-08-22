//
//  HistoryListInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/03/24.
//

import Combine

class HistoryListInteractor: BaseInteractor {
    
    func getComplaintHistoryList(
        woType: Int? = nil,
        woStatus: String? = nil,
        limit: Int? = nil,
        hasObstacle: Int? = nil,
        page: Int? = nil) -> AnyPublisher<WorkSheetCorrectiveListEntity, Error> {
            return api.requestApiPublisher(.workSheetCorrective(
                woType: woType,
                woStatus: woStatus,
                limit: limit,
                hasObstacle: hasObstacle,
                page: page))
        }
    
}
