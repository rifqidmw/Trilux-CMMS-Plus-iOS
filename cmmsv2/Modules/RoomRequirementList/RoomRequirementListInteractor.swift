//
//  RoomRequirementListInteractor.swift
//  cmmsv2
//
//  Created by macbook  on 03/10/24.
//

import Combine

class RoomRequirementListInteractor: BaseInteractor {
    
    func getRoomRequirementList(
        condition: String? = nil,
        keyword: String? = nil,
        year: String? = nil,
        type: String? = nil,
        page: Int,
        sort: String? = nil
    ) -> AnyPublisher<RoomRequirementListEntity, Error> {
        return api.requestApiPublisher(.roomRequirementList(
            condition: condition,
            keyword: keyword,
            year: year,
            type: type,
            page: page,
            sort: sort))
    }
    
}
