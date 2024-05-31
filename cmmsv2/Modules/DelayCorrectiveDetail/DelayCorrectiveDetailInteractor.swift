// 
//  DelayCorrectiveDetailInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 31/05/24.
//

import Combine

class DelayCorrectiveDetailInteractor: BaseInteractor {
    
    func getDetailCorrective(id: String?) -> AnyPublisher<DelayCorrectiveDetailEntity, Error> {
        return api.requestApiPublisher(.delayCorrectiveDetail(id: id ?? ""))
    }
    
}
