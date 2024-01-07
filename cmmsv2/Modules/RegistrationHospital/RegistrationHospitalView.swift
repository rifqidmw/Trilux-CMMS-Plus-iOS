// 
//  RegistrationHospitalView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 06/01/24.
//

import UIKit

class RegistrationHospitalView: BaseViewController {
    
    @IBOutlet weak var backgroundView: BackgroundView!
    @IBOutlet weak var buttonRegister: GeneralButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var containerView: UIView!
    
    var presenter: RegistrationHospitalPresenter?
    
    override func didLoad() {
        super.didLoad()
        setupBody()
    }
    
}

extension RegistrationHospitalView {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        backgroundView.makeCornerRadius(24, .bottomCurve)
        containerView.makeCornerRadius(8)
        buttonRegister.configure(title: "Pasang", type: .normalWithShadow)
    }
    
    private func setupAction() {
        buttonRegister.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                
                self.presenter?.navigateToLoginPage(navigation: navigation)
            }
            .store(in: &anyCancellable)
    }
    
}
