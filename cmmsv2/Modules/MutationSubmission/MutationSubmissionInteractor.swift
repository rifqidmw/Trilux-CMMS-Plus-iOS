//
//  MutationSubmissionInteractor.swift
//  cmmsv2
//
//  Created by macbook  on 10/10/24.
//

import Combine

class MutationSubmissionInteractor: BaseInteractor {
    
    func getListInstallation() -> AnyPublisher<InstallationListEntity, Error> {
        return api.requestApiPublisher(.getInstallation)
    }
    
    func getListEquipment(_ id: String?) -> AnyPublisher<EquipmentListEntity, Error> {
        return api.requestApiPublisher(.getListEquipment(id: id ?? ""))
    }
    
    func createSubmissionMutation(_ data: MutationSubmissionRequest?) -> AnyPublisher<MutationSubmissionResponse, Error> {
        return api.requestApiPublisher(.createMutationSubmission(data: data))
    }
    
}
