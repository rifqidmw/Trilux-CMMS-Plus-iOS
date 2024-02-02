//
//  RegistrationHospitalView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 06/01/24.
//

import UIKit

class RegistrationHospitalView: BaseViewController {
    
    @IBOutlet weak var backgroundView: BackgroundView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var buttonRegister: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var containerView: UIView!
    
    var presenter: RegistrationHospitalPresenter?
    private var code: String = ""
    
    override func didLoad() {
        super.didLoad()
        setupBody()
    }
    
}

extension RegistrationHospitalView {
    
    private func setupBody() {
        setupView()
        setupAction()
        showFailMessage()
    }
    
    private func setupView() {
        backgroundView.backgroundType = .splash
        backgroundView.makeCornerRadius(24, .bottomCurve)
        containerView.makeCornerRadius(8)
        buttonRegister.makeCornerRadius(8)
        buttonRegister.addShadow(8, color: UIColor.customPrimaryColor.cgColor)
        
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
        buttonRegister.gesture()
            .sink { [weak self] _ in
                guard let self = self,
                      let presenter = self.presenter,
                      let navigation = self.navigationController,
                      let code = self.textField.text
                else { return }
                
                if code.isEmpty {
                    self.showAlert(title: "Terjadi Kesalahan", message: "Mohon masukkan kode rumah sakit!")
                } else {
                    presenter.registerHospital(code: code, navigation: navigation)
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
                    self.showAlert(title: "Terjadi Kesalahan", message: "Gagal registrasi, kode tidak sesuai!")
                }
            }
            .store(in: &anyCancellable)
    }
    
}
