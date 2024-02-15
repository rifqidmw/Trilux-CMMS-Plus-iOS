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
    
    func uploadProfile(name: String, position: String, workUnit: String, imageId: Int, phoneNumber: String) -> AnyPublisher<EditProfileEntity, Error> {
        return api.requestApiPublisher(.updateProfile(name: name, position: position, workUnit: workUnit, imageId: imageId, phoneNumber: phoneNumber))
    }
    
}
