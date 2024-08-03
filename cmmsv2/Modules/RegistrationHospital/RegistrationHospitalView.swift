//
//  RegistrationHospitalView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 06/01/24.
//

import UIKit

class RegistrationHospitalView: BaseViewController {
    
    @IBOutlet weak var backgroundView: BackgroundView!
    @IBOutlet weak var buttonRegister: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var containerView: UIView!
    
    var presenter: RegistrationHospitalPresenter?
    private var code: String = ""
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension RegistrationHospitalView {
    
    private func setupBody() {
        setupView()
        setupAction()
        bindingData()
        showFailMessage()
    }
    
    private func setupView() {
        guard let presenter else { return }
        backgroundView.backgroundType = .splash
        backgroundView.makeCornerRadius(24, .bottomCurve)
        containerView.makeCornerRadius(8)
        buttonRegister.makeCornerRadius(8)
        buttonRegister.addShadow(8, color: UIColor.customPrimaryColor.cgColor)
        
        presenter.$isLoading
            .sink { [weak self] isLoading in
                guard let self else { return }
                isLoading ? self.showLoadingPopup() : self.hideLoadingPopup()
            }
            .store(in: &anyCancellable)
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
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$hospitalData
            .sink { [weak self] data in
                guard let self,
                      let navigation = self.navigationController,
                      let data = data,
                      let hospital = data.data,
                      let hospitalDetail = hospital.hospital
                else { return }
                switch data.message {
                case .success:
                    AppManager.setIsRegistered(true)
                    AppManager.setHospital(hospitalDetail)
                    let data = HospitalTheme(logo: hospitalDetail.logo, tagline: hospitalDetail.tagline)
                    presenter.navigateToLoginPage(navigation: navigation, data: data)
                default: break
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
