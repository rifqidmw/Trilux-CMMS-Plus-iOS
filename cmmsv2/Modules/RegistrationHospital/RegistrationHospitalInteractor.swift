//
//  RegistrationHospitalInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 06/01/24.
//

import Combine
import Foundation

class RegistrationHospitalInteractor: BaseInteractor {
    
    func registerHospital(code: String) -> AnyPublisher<Hospital, Error> {
        return api.requestApiPublisher(.registerHospital(code: code))
    }
    
}
