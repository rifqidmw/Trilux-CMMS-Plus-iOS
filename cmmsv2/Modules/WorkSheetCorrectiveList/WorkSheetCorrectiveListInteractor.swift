//
//  WorkSheetCorrectiveInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/03/24.
//

import Combine

class WorkSheetCorrectiveListInteractor: BaseInteractor {
    
    func getWorkSheetCorrectiveList(woType: Int? = nil,
                                    woStatus: String? = nil,
                                    limit: Int? = nil,
                                    sort: String? = nil,
                                    hasObstacle: Int? = nil,
                                    keyword: String? = nil,
                                    page: Int? = nil) -> AnyPublisher<WorkSheetCorrectiveListEntity, Error> {
        return api.requestApiPublisher(.workSheetCorrective(
            woType: woType,
            woStatus: woStatus,
            limit: limit,
            sort: sort,
            hasObstacle: hasObstacle,
            keyword: keyword,
            page: page))
    }
    
}
