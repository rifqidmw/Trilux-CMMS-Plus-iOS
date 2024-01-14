// 
//  ChangePasswordPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/01/24.
//

import UIKit

class ChangePasswordPresenter: BasePresenter {
    
    private let interactor: ChangePasswordInteractor
    private let router = ChangePasswordRouter()
    
    init(interactor: ChangePasswordInteractor) {
        self.interactor = interactor
    }
    
}

extension ChangePasswordPresenter {
    
    func backToPreviousPage(navigation: UINavigationController) {
        router.backToPreviousPage(navigation: navigation)
    }
    
}
