// 
//  ChangePasswordInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/01/24.
//

import Combine

class ChangePasswordInteractor: BaseInteractor {
    
    func changeUserPassword(oldPassword: String, confirmPassword: String, password: String) -> AnyPublisher<UserProfileEntity, Error> {
        return api.requestApiPublisher(.changePassword(oldPassword: oldPassword, passwordConfirm: confirmPassword, password: password))
    }
    
}
