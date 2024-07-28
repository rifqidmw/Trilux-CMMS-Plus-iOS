//
//  UserProfileRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/01/24.
//

import UIKit

class UserProfileRouter: BaseRouter {
    
    func showView() -> UserProfileView {
        let interactor = UserProfileInteractor()
        let presenter = UserProfilePresenter(interactor: interactor)
        let view = UserProfileView(nibName: String(describing: UserProfileView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}

extension UserProfileRouter {
    
    func goToChangePassword(navigation: UINavigationController) {
        let vc = ChangePasswordRouter().showView()
        navigation.pushViewController(vc, animated: true)
    }
    
    func goToEditProfile(navigation: UINavigationController, data: User) {
        let vc = EditProfileRouter().showView()
        vc.data = data
        navigation.pushViewController(vc, animated: true)
    }
    
}
