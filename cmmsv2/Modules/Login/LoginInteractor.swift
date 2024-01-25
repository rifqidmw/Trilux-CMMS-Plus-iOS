//
//  LoginInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/01/24.
//

import Combine

class LoginInteractor: BaseInteractor {
    
    func loginUser(username: String, password: String) -> AnyPublisher<UserProfileEntity, Error> {
        return api.requestApiPublisher(.loginUser(username: username, password: password))
    }
    
}
