//
//  HistoryDetailInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 18/05/24.
//

import Combine

class HistoryDetailInteractor: BaseInteractor {
    
    func getHistoryDetail(id: String?) -> AnyPublisher<HistoryDetailEntity, Error> {
        return api.requestApiPublisher(.detailHistory(id: id))
    }
    
}
