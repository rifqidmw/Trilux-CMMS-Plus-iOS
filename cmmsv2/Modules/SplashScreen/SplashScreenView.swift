//
//  SplashScreenView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import UIKit

class SplashScreenView: BaseNonNavigationController {
    
    @IBOutlet weak var containerView: UIStackView!
    var isGestureEnabled = true
    
    override func didLoad() {
        super.didLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.navigateToRegistrationHospital()
        }
    }
    
}

extension SplashScreenView {
    
    private func navigateToRegistrationHospital() {
        let vc = RegistrationHospitalRouter().showView()
        let rootController = UINavigationController(rootViewController: vc)
        
        UIView.animate(withDuration: 0.1, animations: {
            UIApplication.shared.windows.first?.alpha = 0
        }) { (_) in
            UIView.animate(withDuration: 0.1) {
                UIApplication.shared.windows.first?.alpha = 1
                UIApplication.shared.windows.first?.makeKeyAndVisible()
                UIApplication.shared.windows.first?.rootViewController = rootController
            }
        }
    }
    
}
