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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if isRegistered {
                self.navigateToLoginPage()
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
    
    private func navigateToLoginPage() {
        let vc = LoginRouter().showView()
        let rootViewController = UINavigationController(rootViewController: vc)
        UIApplication.shared.setRootViewController(rootViewController)
    }
    
}
