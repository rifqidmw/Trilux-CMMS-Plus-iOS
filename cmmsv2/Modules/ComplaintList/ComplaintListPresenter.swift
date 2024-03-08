//
//  ComplaintListPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/03/24.
//

import Foundation

class ComplaintListPresenter: BasePresenter {
    
    private let interactor: ComplaintListInteractor
    private let router = ComplaintListRouter()
    
    init(interactor: ComplaintListInteractor) {
        self.interactor = interactor
    }
    
}
