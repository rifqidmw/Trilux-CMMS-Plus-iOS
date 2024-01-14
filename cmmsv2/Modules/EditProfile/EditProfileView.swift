// 
//  EditProfileView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/01/24.
//

import UIKit

class EditProfileView: BaseViewController {
    
    @IBOutlet weak var navigationView: CustomNavigationView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameTextField: GeneralTextField!
    @IBOutlet weak var jobTextField: GeneralTextField!
    @IBOutlet weak var workUnitTextField: GeneralTextField!
    @IBOutlet weak var phoneNumberTextField: GeneralTextField!
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var saveButton: GeneralButton!
    
    var presenter: EditProfilePresenter?

    override func didLoad() {
        super.didLoad()
        setupBody()
    }
    
}

extension EditProfileView {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        navigationView.configure(plainTitle: "Ubah Profil", type: .plain)
        containerView.makeCornerRadius(12)
        containerView.addShadow(6, opacity: 0.2)
        nameTextField.configure(title: "Nama", placeholder: "Masukan nama Anda")
        jobTextField.configure(title: "Pekerjaan", placeholder: "Masukan pekerjaan Anda")
        workUnitTextField.configure(title: "Unit Kerja", placeholder: "Masukan unit kerja")
        phoneNumberTextField.configure(title: "Nomor Handphone", placeholder: "Masukan nomor handphone Anda", type: .phoneNumber)
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
