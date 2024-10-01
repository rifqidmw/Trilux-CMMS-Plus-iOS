//
//  RatingListInteractor.swift
//  cmmsv2
//
//  Created by macbook  on 01/10/24.
//

import Combine

class RatingListInteractor: BaseInteractor {
    
    func getRatingList(woStatus: String?, limit: Int, page: Int) -> AnyPublisher<RatingListEntity, Error> {
        return api.requestApiPublisher(.ratingList(woStatus: woStatus, limit: limit, page: page))
    }
    
    func getWorkSheetNotification(id: String?) -> AnyPublisher<HistoryDetailEntity, Error> {
        return api.requestApiPublisher(.detailHistory(id: id ?? ""))
    }
    
}
