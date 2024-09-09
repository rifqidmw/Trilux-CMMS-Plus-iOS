// 
//  RoomRequirementPresenter.swift
//  cmmsv2
//
//  Created by macbook  on 10/09/24.
//

import Foundation

class RoomRequirementPresenter: BasePresenter {
    
    private let interactor: RoomRequirementInteractor
    private let router = RoomRequirementRouter()
    
    init(interactor: RoomRequirementInteractor) {
        self.interactor = interactor
    }
    
}
