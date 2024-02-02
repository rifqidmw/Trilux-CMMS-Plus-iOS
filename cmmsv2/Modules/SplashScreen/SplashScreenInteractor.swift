// 
//  SplashScreenInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 02/02/24.
//

import Combine

class SplashScreenInteractor: BaseInteractor {
    
    func getUserProfile() -> AnyPublisher<UserProfileEntity, Error> {
        return api.requestApiPublisher(.getProfile)
    }
    
}
