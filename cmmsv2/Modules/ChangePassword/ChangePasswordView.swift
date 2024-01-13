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
    }

}

extension ChangePasswordView {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        navigationView.configure(plainTitle: "Ganti Password", type: .plain)
        containerView.makeCornerRadius(12)
        containerView.addShadow(6, opacity: 0.2)
        oldPasswordTextField.configure(title: "Password Lama", placeholder: "Masukan password lama", type: .password)
        newPasswordTextField.configure(title: "Password Baru", placeholder: "Masukan password baru", type: .password)
        newPasswordConfirmTextField.configure(title: "Ulangi Password Baru", placeholder: "Masukan konfirmasi password", type: .password)
        bottomContainerView.addShadow(1, position: .top, opacity: 0.2)
        saveButton.configure(title: "Simpan")
    }
    
    private func setupAction() {
        navigationView.arrowLeftBackButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let presenter,
                      let navigation = self.navigationController
                else { return }
                
                presenter.backToPreviousPage(navigation: navigation)
            }
            .store(in: &anyCancellable)
    }
    
}
