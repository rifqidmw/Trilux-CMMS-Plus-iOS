// 
//  RegistrationHospitalRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 06/01/24.
//

import UIKit

class RegistrationHospitalRouter: BaseRouter {
    
    func showView() -> RegistrationHospitalView {
        let interactor = RegistrationHospitalInteractor()
        let presenter = RegistrationHospitalPresenter(interactor: interactor)
        let view = RegistrationHospitalView(nibName: String(describing: RegistrationHospitalView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
