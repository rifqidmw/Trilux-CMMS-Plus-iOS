//
//  EquipmentManagementInteractor.swift
//  cmmsv2
//
//  Created by macbook  on 10/09/24.
//

import Combine

class EquipmentManagementListInteractor: BaseInteractor {
    
    func getLoanSubmissionList() -> AnyPublisher<EquipmentManagementSubmissionEntity, Error> {
        return api.requestApiPublisher(.submissionList)
    }
    
    func getLoanRequestList() -> AnyPublisher<EquipmentManagementRequestEntity, Error> {
        return api.requestApiPublisher(.requestList)
    }
    
    func getReturningLoanList(limit: Int, page: Int) -> AnyPublisher<EquipmentManagementRequestEntity, Error> {
        return api.requestApiPublisher(.returningLoan(limit: limit, page: page))
    }
    
    func getReturningBorrowedList(limit: Int, page: Int) -> AnyPublisher<EquipmentManagementRequestEntity, Error> {
        return api.requestApiPublisher(.returningBorrowed(limit: limit, page: page))
    }
    
    func approveRequested(id: String?) -> AnyPublisher<ReturningEntity, Error> {
        return api.requestApiPublisher(.approveRequest(id: id ?? ""))
    }
    
}
