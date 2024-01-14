// 
//  ChangePasswordRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/01/24.
//

import UIKit

class ChangePasswordRouter: BaseRouter {
    
    func showView() -> ChangePasswordView {
        let interactor = ChangePasswordInteractor()
        let presenter = ChangePasswordPresenter(interactor: interactor)
        let view = ChangePasswordView(nibName: String(describing: ChangePasswordView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
