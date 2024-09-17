//
//  EquipmentManagementDetailInteractor.swift
//  cmmsv2
//
//  Created by macbook  on 16/09/24.
//

import Combine

class EquipmentManagementDetailInteractor: BaseInteractor {
    
    func getSubmissionDetail(id: String?) -> AnyPublisher<SubmissionDetailEntity, Error> {
        return api.requestApiPublisher(.submissionDetail(id: id ?? ""))
    }
    
    func deleteSubmission(id: String?) -> AnyPublisher<ReturningEntity, Error> {
        return api.requestApiPublisher(.submissionDelete(id: id ?? ""))
    }
    
}
