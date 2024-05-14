//
//  WorkSheetCorrectiveDetailInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/05/24.
//

import Combine

class WorkSheetCorrectiveDetailInteractor: BaseInteractor {
    
    func getDetailCorrective(id: Int?) -> AnyPublisher<WorkSheetCorrectiveDetailEntity, Error> {
        return api.requestApiPublisher(.complaintDetail(id: id))
    }
    
}
