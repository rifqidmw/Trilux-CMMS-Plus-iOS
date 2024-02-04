//
//  HomeScreenInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/01/24.
//

import Combine

class HomeScreenInteractor: BaseInteractor {
    
    func getInfoExpired() -> AnyPublisher<ExpiredEntity, Error> {
        return api.requestApiPublisher(.infoExpired)
    }
    
}
