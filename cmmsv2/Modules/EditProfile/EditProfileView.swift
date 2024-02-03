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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
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
        showFailMessage()
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
        
        presenter?.$isLoading
            .sink { [weak self] isLoading in
                guard let self else { return }
                self.showSpinner(isLoading)
            }
            .store(in: &anyCancellable)
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
        
        saveButton.gesture()
            .sink { [weak self] _ in
                guard let self = self,
                      let presenter = self.presenter,
                      let navigation = self.navigationController,
                      let name = self.nameTextField.textField.text,
                      let job = self.jobTextField.textField.text,
                      let workUnit = self.workUnitTextField.textField.text,
                      let phoneNumber = self.phoneNumberTextField.textField.text
                else { return }
                let imageId = UserDefaults.standard.integer(forKey: "valImageId")
                
                if name.isEmpty || job.isEmpty || workUnit.isEmpty || phoneNumber.isEmpty {
                    self.showAlert(title: "Terjadi Kesalahan", message: "Harap untuk mengisi semua bidang!")
                } else {
                    presenter.updateUserProfile(
                        name: name,
                        position: job,
                        workUnit: workUnit,
                        imageId: imageId,
                        phoneNumber: "+62" + phoneNumber,
                        navigation: navigation)
                }
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
