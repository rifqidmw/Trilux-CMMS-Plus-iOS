//
//  EditTechnicalInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 02/08/24.
//

import Combine

class EditTechnicalInteractor: BaseInteractor {
    
    func getLoadTechnicalData(id: String?) -> AnyPublisher<TechnicalEntity, Error> {
        return api.requestApiPublisher(.loadTechnical(id: id ?? ""))
    }
    
    func saveTechnicalData(data: EditTechnicalRequestEntity?) -> AnyPublisher<SaveTechnicalEntity, Error> {
        return api.requestApiPublisher(.saveTechnical(data: data ?? EditTechnicalRequestEntity()))
    }
    
}
