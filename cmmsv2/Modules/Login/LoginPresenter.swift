// 
//  LoginPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/01/24.
//

import Foundation
import UIKit

class LoginPresenter: BasePresenter {
    
    private let interactor: LoginInteractor
    private let router = LoginRouter()
    
    init(interactor: LoginInteractor) {
        self.interactor = interactor
    }
    
}

extension LoginPresenter {
    
    func navigateToHomeScreen(navigation: UINavigationController) {
        router.goToHomeScreen(navigation: navigation)
    }
    
}
