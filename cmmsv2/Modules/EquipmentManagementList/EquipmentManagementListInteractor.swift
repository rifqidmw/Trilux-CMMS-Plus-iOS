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
    
    func getMutationSubmissionList() -> AnyPublisher<MutationRequestEntity, Error> {
        return api.requestApiPublisher(.mutationSubmission)
    }
    
    func getMutationRequestList() -> AnyPublisher<MutationRequestEntity, Error> {
        return api.requestApiPublisher(.mutationRequest)
    }
    
    func getAmprahList(limit: Int, page: Int) -> AnyPublisher<AmprahListEntity, Error> {
        return api.requestApiPublisher(.amprahList(limit: limit, page: page))
    }
    
    func getAmprahRoomList() -> AnyPublisher<AmprahRoomEntity, Error> {
        return api.requestApiPublisher(.getRoomList)
    }
    
    func amprahMutation(data: AmprahMutationRequest?) -> AnyPublisher<AmprahMutationResponse, Error> {
        return api.requestApiPublisher(.amprahMutation(data: data))
    }
    
}
