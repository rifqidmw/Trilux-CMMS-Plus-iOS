// 
//  RegistrationHospitalPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 06/01/24.
//

import Foundation
import UIKit

class RegistrationHospitalPresenter: BasePresenter {
    
    private let interactor: RegistrationHospitalInteractor
    private let router = RegistrationHospitalRouter()
    
    init(interactor: RegistrationHospitalInteractor) {
        self.interactor = interactor
    }
    
}

extension RegistrationHospitalPresenter {
    
    func navigateToLoginPage(navigation: UINavigationController) {
        router.goToLoginPage(navigation: navigation)
    }
    
}
