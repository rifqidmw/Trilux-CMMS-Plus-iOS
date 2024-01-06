// 
//  LoginPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/01/24.
//

import Foundation

class LoginPresenter: BasePresenter {
    
    private let interactor: LoginInteractor
    private let router = LoginRouter()
    
    init(interactor: LoginInteractor) {
        self.interactor = interactor
    }
    
}
