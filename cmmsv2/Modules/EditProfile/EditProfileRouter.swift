// 
//  EditProfileRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/01/24.
//

import UIKit

class EditProfileRouter: BaseRouter {
    
    func showView() -> EditProfileView {
        let interactor = EditProfileInteractor()
        let presenter = EditProfilePresenter(interactor: interactor)
        let view = EditProfileView(nibName: String(describing: EditProfileView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
