//
//  ComplaintListInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/03/24.
//

import Combine

class ComplaintListInteractor: BaseInteractor {
    
    func getComplaintList(
        page: Int? = nil,
        limit: Int? = nil,
        equipmentId: String? = nil,
        status: String? = nil,
        dateFilter: String? = nil) -> AnyPublisher<ComplaintEntity, Error> {
            return api.requestApiPublisher(.getComplaintList(
                page: page,
                limit: limit,
                equipmentId: equipmentId,
                status: status,
                dateFilter: dateFilter))
            
        }
    
}
