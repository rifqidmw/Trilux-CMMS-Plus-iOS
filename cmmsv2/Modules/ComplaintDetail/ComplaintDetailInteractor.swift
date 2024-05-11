//
//  ComplaintDetailInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/05/24.
//

import Combine

class ComplaintDetailInteractor: BaseInteractor {
    
    func getComplaintDetail(id: Int?) -> AnyPublisher<ComplaintDetailEntity, Error> {
        return api.requestApiPublisher(.complaintDetail(id: id))
    }
    
}
