//
//  ChangePasswordView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/01/24.
//

import UIKit

class ChangePasswordView: BaseViewController {
    
    @IBOutlet weak var navigationView: CustomNavigationView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var oldPasswordTextField: GeneralTextField!
    @IBOutlet weak var newPasswordTextField: GeneralTextField!
    @IBOutlet weak var newPasswordConfirmTextField: GeneralTextField!
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var saveButton: GeneralButton!
    
    var presenter: ChangePasswordPresenter?
    
    override func didLoad() {
        super.didLoad()
        setupBody()
        configureKeyboard()
    }
    
}

extension ChangePasswordView {
    
    private func setupBody() {
        setupView()
        setupAction()
        showFailMessage()
    }
    
    private func setupView() {
        navigationView.configure(toolbarTitle: "Ganti Password", type: .plain)
        containerView.makeCornerRadius(12)
        containerView.addShadow(6, opacity: 0.2)
        oldPasswordTextField.configure(title: "Password Lama", placeholder: "Masukan password lama", type: .password)
        newPasswordTextField.configure(title: "Password Baru", placeholder: "Masukan password baru", type: .password)
        newPasswordConfirmTextField.configure(title: "Ulangi Password Baru", placeholder: "Masukan konfirmasi password", type: .password)
        bottomContainerView.addShadow(1, position: .top, opacity: 0.2)
        saveButton.configure(title: "Simpan")
        
        presenter?.$isLoading
            .sink { [weak self] isLoading in
                guard let self else { return }
                isLoading ? self.showLoadingPopup() : self.hideLoadingPopup()
            }
            .store(in: &anyCancellable)
    }
    
    private func setupAction() {
        navigationView.arrowLeftBackButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                navigation.popViewController(animated: true)
            }
            .store(in: &anyCancellable)
        
        saveButton.gesture()
            .sink { [weak self] _ in
                guard let self = self,
                      let presenter = self.presenter,
                      let navigation = self.navigationController,
                      let oldPassword = self.oldPasswordTextField.textField.text,
                      let newPassword = self.newPasswordTextField.textField.text,
                      let confirmPassword = self.newPasswordConfirmTextField.textField.text
                else { return }
                
                if oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty {
                    self.showAlert(title: "Terjadi Kesalahan", message: "Harap untuk mengisi semua bidang!")
                } else {
                    presenter.changeUserPassword(
                        oldPassword: oldPassword,
                        confirmPassword: confirmPassword,
                        password: newPassword,
                        navigation: navigation)
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
                    self.showAlert(title: "Terjadi Kesalahan", message: "Pastikan Anda memasukan konfirmasi password yang sesuai!")
                }
            }
            .store(in: &anyCancellable)
    }
    
}
