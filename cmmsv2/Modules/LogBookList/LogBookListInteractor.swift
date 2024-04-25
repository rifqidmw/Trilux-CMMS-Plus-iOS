//
//  LogBookInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 17/03/24.
//

import Combine

class LogBookListInteractor: BaseInteractor {
    
    func getListLogBook(limit: Int? = nil,
                        page: Int? = nil,
                        date: String? = nil) -> AnyPublisher<LogBookListEntity, Error> {
        return api.requestApiPublisher(.logBookList(limit: limit, page: page, date: date))
    }
    
}
