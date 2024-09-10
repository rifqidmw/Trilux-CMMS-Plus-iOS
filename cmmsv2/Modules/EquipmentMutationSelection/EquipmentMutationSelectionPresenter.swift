//
//  EquipmentMutationSelectionPresenter.swift
//  cmmsv2
//
//  Created by macbook  on 10/09/24.
//

import Foundation

class EquipmentMutationSelectionPresenter {
    
    private let interactor: EquipmentMutationSelectionInteractor
    private let router = EquipmentMutationSelectionRouter()
    
    init(interactor: EquipmentMutationSelectionInteractor) {
        self.interactor = interactor
    }
    
}
