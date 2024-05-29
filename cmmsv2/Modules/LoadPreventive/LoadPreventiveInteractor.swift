//
//  LoadPreventiveInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 29/05/24.
//

import Combine

class LoadPreventiveInteractor: BaseInteractor {
    
    func getPreventiveLoadList(id: String?) -> AnyPublisher<LoadPreventiveEntity, Error> {
        return api.requestApiPublisher(.loadPreventive(id: id ?? ""))
    }
    
}
