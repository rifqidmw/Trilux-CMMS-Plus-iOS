//
//  EditComplaintInteractor.swift
//  cmmsv2
//
//  Created by macbook  on 22/09/24.
//

import Combine

class EditComplaintInteractor: BaseInteractor {
    
    func getComplaintDetail(id: Int?) -> AnyPublisher<ComplaintDetailEntity, Error> {
        return api.requestApiPublisher(.complaintDetail(id: id))
    }
    
    func updateComplaint(_ request: UpdateComplaintRequestEntity?, id: String?) -> AnyPublisher<UpdateComplaintResponseEntity, Error> {
        return api.requestApiPublisher(.updateComplaint(data: request, id: id ?? ""))
    }
    
}
