// 
//  RegistrationHospitalView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 06/01/24.
//

import UIKit

class RegistrationHospitalView: BaseViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
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
        backgroundImageView.makeCornerRadius(24, .bottomCurve)
        containerView.makeCornerRadius(8)
        buttonRegister.configure(title: "Pasang", type: .normalWithShadow)
    }
    
    private func setupAction() {
        buttonRegister.gesture()
            .sink { [weak self] _ in
                guard self != nil else { return }
                AppLogger.log("TO DO REGISTER HOSPITAL")
            }
            .store(in: &anyCancellable)
    }
    
}
