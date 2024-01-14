// 
//  EditProfilePresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/01/24.
//

import UIKit

class EditProfilePresenter: BasePresenter {
    
    private let interactor: EditProfileInteractor
    private let router = EditProfileRouter()
    
    init(interactor: EditProfileInteractor) {
        self.interactor = interactor
    }
    
}

extension EditProfilePresenter {
    
    func backToPreviousPage(navigation: UINavigationController) {
        router.backToPreviousPage(navigation: navigation)
    }
    
}
