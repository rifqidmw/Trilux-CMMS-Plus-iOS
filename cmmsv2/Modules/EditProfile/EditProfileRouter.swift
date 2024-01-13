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
    
    //Navigate to other xib-based router
    /*
    func navigateToOtherView(from navigation: UINavigationController, with data: Any) {
        let otherView = OtherViewRouter().showView(with: data)
        navigation.pushViewController(otherView, animated: true)
    }
    */
    
    //Navigate to other storyboard-based router
    /*
    func navigateToOtherView(from navigation: UINavigationController, with data: Any) {
        let otherView = OtherViewRouter().showView(with: data)
        navigation.pushViewController(otherView, animated: true)
    }
     */
    
}
