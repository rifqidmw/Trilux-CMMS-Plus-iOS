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
    
    var data: User?
    var presenter: EditProfilePresenter?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.configureKeyboard()
        self.validateUser()
    }
    
}

extension EditProfileView {
    
    private func setupBody() {
        setupView()
        setupAction()
        showFailMessage()
    }
    
    private func setupView() {
        setupTextFieldValue()
        navigationView.configure(toolbarTitle: "Ubah Profil", type: .plain)
        containerView.makeCornerRadius(12)
        containerView.addShadow(6, opacity: 0.2)
        nameTextField.configure(title: "Nama", placeholder: "Masukan nama Anda")
        jobTextField.configure(title: "Pekerjaan", placeholder: "Masukan pekerjaan Anda")
        workUnitTextField.configure(title: "Unit Kerja", placeholder: "Masukan unit kerja")
        phoneNumberTextField.configure(title: "Nomor Handphone", placeholder: "Masukan nomor handphone Anda", type: .phoneNumber)
        bottomContainerView.addShadow(1, position: .top, opacity: 0.2)
        saveButton.configure(title: "Simpan")
        
        presenter?.$isLoading
            .sink { [weak self] isLoading in
                guard let self else { return }
                isLoading ? self.showLoadingPopup() : self.hideLoadingPopup()
            }
            .store(in: &anyCancellable)
    }
    
    private func setupTextFieldValue() {
        guard let data,
              var phoneNumber = data.txtTelepon
        else { return }
        if phoneNumber.hasPrefix("+62") {
            phoneNumber = String(phoneNumber.dropFirst(3))
        }
        let slicedPhoneNumber = phoneNumber
        nameTextField.textField.text = data.txtName
        jobTextField.textField.text = data.txtJabatan
        workUnitTextField.textField.text = data.txtUnitKerja
        phoneNumberTextField.textField.text = slicedPhoneNumber
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
                      let name = nameTextField.textField.text,
                      let job = jobTextField.textField.text,
                      let workUnit = workUnitTextField.textField.text,
                      var phoneNumber = phoneNumberTextField.textField.text,
                      let user = AppManager.getUser()
                else { return }
                if phoneNumber.hasPrefix("+62") {
                    phoneNumber = String(phoneNumber.dropFirst(3))
                }
                
                let imageId = Int(user.valImageId ?? "")
                let fullPhoneNumber = "+62" + phoneNumber
                
                if name.isEmpty || job.isEmpty || workUnit.isEmpty || phoneNumber.isEmpty {
                    self.showAlert(title: "Terjadi Kesalahan", message: "Harap untuk mengisi semua bidang!")
                } else {
                    presenter.updateUserProfile(
                        name: name,
                        position: job,
                        workUnit: workUnit,
                        imageId: imageId ?? 0,
                        phoneNumber: fullPhoneNumber,
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
                    self.showAlert(title: "Terjadi Kesalahan", message: "Mohon periksa input yang Anda masukan!")
                }
            }
            .store(in: &anyCancellable)
    }
    
}
