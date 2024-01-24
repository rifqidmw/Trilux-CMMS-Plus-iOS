//
//  LoginView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/01/24.
//

import UIKit

class LoginView: BaseViewController {
    
    @IBOutlet weak var triluxLogoImageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var usernameTextField: GeneralTextField!
    @IBOutlet weak var passwordTextField: GeneralTextField!
    @IBOutlet weak var loginButton: GeneralButton!
    @IBOutlet var backgroundView: BackgroundView!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var presenter: LoginPresenter?
    var data: HospitalTheme?
    
    var username: String?
    var password: String?
    
    override func didLoad() {
        super.didLoad()
        setupBody()
    }
    
}

extension LoginView {
    
    private func setupBody() {
        setupView()
        setupAction()
        showFailMessage()
    }
    
    private func setupView() {
        backgroundView.backgroundType = .splash
        backgroundView.triluxLogoImageView.isHidden = true
        containerView.makeCornerRadius(24, .topCurve)
        containerView.addShadow(6, position: .top, color: UIColor.darkGray.cgColor)
        taglineLabel.text = data?.tagline ?? ""
        
        usernameTextField.configure(title: "Username", placeholder: "Masukan username Anda")
        passwordTextField.configure(title: "Password", placeholder: "Masukan password Anda", type: .password)
        loginButton.configure(title: "Masuk")
        
        presenter?.$isLoading
            .sink { [weak self] isLoading in
                guard let self else { return }
                self.showSpinner(isLoading)
            }
            .store(in: &anyCancellable)
    }
    
    private func showSpinner(_ isShow: Bool) {
        DispatchQueue.main.async {
            self.spinner.isHidden = !isShow
            
            isShow ? self.showOverlay() : self.removeOverlay()
            isShow ? self.spinner.startAnimating() : self.spinner.stopAnimating()
        }
    }
    
    private func setupAction() {
        loginButton.gesture()
            .sink { [weak self] _ in
                guard let self = self,
                      let presenter = self.presenter,
                      let navigation = self.navigationController
                else { return }
                
                let username = self.usernameTextField.textField.text ?? ""
                let password = self.passwordTextField.textField.text ?? ""
                
                if username.isEmpty || password.isEmpty {
                    self.showAlert(title: "Terjadi Kesalahan", message: "Harap masukkan username dan password!")
                } else {
                    self.username = username
                    self.password = password
                    
                    presenter.loginUser(username: username, password: password, navigation: navigation)
                }
            }
            .store(in: &anyCancellable)
    }
    
    private func showFailMessage() {
        guard let presenter else { return }
        presenter.$isError
            .sink { [weak self] error in
                guard let self else { return}
                if error {
                    self.showAlert(title: "Terjadi Kesalahan", message: "Username atau password salah!")
                }
            }
            .store(in: &anyCancellable)
    }
    
}
