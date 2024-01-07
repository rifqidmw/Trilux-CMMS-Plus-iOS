// 
//  LoginView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/01/24.
//

import UIKit

class LoginView: BaseViewController {
    
    @IBOutlet weak var usernameTextField: GeneralTextField!
    @IBOutlet weak var passwordTextField: GeneralTextField!
    @IBOutlet weak var loginButton: GeneralButton!
    @IBOutlet var backgroundView: BackgroundView!
    @IBOutlet weak var containerView: UIStackView!
    
    var presenter: LoginPresenter?

    override func didLoad() {
        super.didLoad()
        setupBody()
    }

}

extension LoginView {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        containerView.makeCornerRadius(24, .topCurve)
        containerView.addShadow(6, position: .top, color: UIColor.darkGray.cgColor)
        backgroundView.logoImageView.isHidden = true
        
        usernameTextField.configure(title: "Username", placeholder: "Masukan username Anda", type: .normal)
        passwordTextField.configure(title: "Password", placeholder: "Masukan password Anda", type: .password)

        loginButton.configure(title: "Masuk")
    }
    
    private func setupAction() {
        loginButton.gesture()
            .sink { [weak self] _ in
                guard self != nil else { return }
                AppLogger.log("TO DO LOGIN")
            }
            .store(in: &anyCancellable)
    }
    
}
