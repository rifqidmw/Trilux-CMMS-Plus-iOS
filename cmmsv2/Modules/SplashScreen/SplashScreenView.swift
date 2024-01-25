//
//  SplashScreenView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import UIKit

class SplashScreenView: BaseNonNavigationController {
    
    @IBOutlet var backgroundView: BackgroundView!
    @IBOutlet weak var containerView: UIStackView!
    var isGestureEnabled = true
    
    override func didLoad() {
        super.didLoad()
        self.backgroundView.backgroundType = .splash
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        let isRegistered = UserDefaults.standard.bool(forKey: "isRegistered")
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        let logo = UserDefaults.standard.string(forKey: "triluxLogo") ?? ""
        let tagline = UserDefaults.standard.string(forKey: "tagLine") ?? ""
        let data = HospitalTheme(logo: logo, tagline: tagline)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            if isLoggedIn && isRegistered {
                self.navigateToHomeScreen()
            } else if isRegistered {
                self.navigateToLoginPage(data: data)
            } else {
                self.navigateToRegistrationHospital()
            }
        }
    }
    
}

extension SplashScreenView {
    
    private func navigateToRegistrationHospital() {
        let vc = RegistrationHospitalRouter().showView()
        let rootViewController = UINavigationController(rootViewController: vc)
        UIApplication.shared.setRootViewController(rootViewController)
    }
    
    private func navigateToLoginPage(data: HospitalTheme) {
        let vc = LoginRouter().showView()
        vc.data = data
        let rootViewController = UINavigationController(rootViewController: vc)
        UIApplication.shared.setRootViewController(rootViewController)
    }
    
    private func navigateToHomeScreen() {
        let vc = HomeScreenRouter().showView()
        let rootViewController = UINavigationController(rootViewController: vc)
        UIApplication.shared.setRootViewController(rootViewController)
    }
    
}
