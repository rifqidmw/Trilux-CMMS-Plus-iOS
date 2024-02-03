//
//  SplashScreenRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 02/02/24.
//

import UIKit

class SplashScreenRouter {
    
    func showView() -> SplashScreenView {
        let interactor = SplashScreenInteractor()
        let presenter = SplashScreenPresenter(interactor: interactor)
        let view = SplashScreenView(nibName: String(describing: SplashScreenView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}

extension SplashScreenRouter {
    
    func navigateToRegistrationHospital() {
        let vc = RegistrationHospitalRouter().showView()
        let rootViewController = UINavigationController(rootViewController: vc)
        UIApplication.shared.setRootViewController(rootViewController)
    }
    
    func navigateToLoginPage(data: HospitalTheme) {
        let vc = LoginRouter().showView()
        vc.data = data
        let rootViewController = UINavigationController(rootViewController: vc)
        UIApplication.shared.setRootViewController(rootViewController)
    }
    
    func navigateToHomeScreen() {
        let vc = HomeScreenRouter().showView()
        let rootViewController = UINavigationController(rootViewController: vc)
        UIApplication.shared.setRootViewController(rootViewController)
    }
    
}
