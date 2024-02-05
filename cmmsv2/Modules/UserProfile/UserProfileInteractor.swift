//
//  UserProfileInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/01/24.
//

import Combine
import Foundation

class UserProfileInteractor: BaseInteractor {
    
    func getUserProfile() -> AnyPublisher<UserProfileEntity, Error> {
        return api.requestApiPublisher(.getProfile)
    }
    
    func uploadProfile(file: URL) -> AnyPublisher<MediaProfileEntity, Error> {
        return api.requestApiPublisher(.uploadProfile(file: file))
    }
    
}
