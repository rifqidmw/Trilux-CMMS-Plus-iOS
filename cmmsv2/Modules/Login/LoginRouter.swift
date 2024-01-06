// 
//  LoginRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/01/24.
//

import UIKit

class LoginRouter: BaseRouter {
    
    func showView() -> LoginView {
        let interactor = LoginInteractor()
        let presenter = LoginPresenter(interactor: interactor)
        let view = LoginView(nibName: String(describing: LoginView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
