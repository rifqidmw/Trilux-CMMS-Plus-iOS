//
//  MutationSubmissionView.swift
//  cmmsv2
//
//  Created by macbook  on 10/10/24.
//

import UIKit

class MutationSubmissionView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var installationSelectView: SelectView!
    @IBOutlet weak var equipmentSelectView: SelectView!
    @IBOutlet weak var equipmentCountTextField: GeneralTextField!
    @IBOutlet weak var saveButton: GeneralButton!
    
    var presenter: MutationSubmissionPresenter?
    var toInstallation: String?
    var equipmentId: String?
    
    override func didLoad() {
        super.didLoad()
        self.validateUser()
        self.setupBody()
    }
    
}

extension MutationSubmissionView {
    
    private func setupBody() {
        setupView()
        setupAction()
        bindingData()
    }
    
    private func setupView() {
        customNavigationView.configure(toolbarTitle: "Pengajuan Mutasi", type: .plain)
        installationSelectView.configure(title: "Instalasi/Ruangan", placeHolder: "Pilih instalasi atau ruangan yang diinginkan")
        equipmentSelectView.configure(title: "Alat", placeHolder: "Pilih alat yang diinginkan")
        equipmentCountTextField.configure(title: "Jumlah Alat", placeholder: "Masukan Jumlah Alat")
        saveButton.configure(title: "Simpan")
        containerStackView.makeCornerRadius(8)
        containerStackView.addShadow(4, opacity: 0.2)
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$mutationResponse
            .sink { [weak self] data in
                guard let self,
                      let data,
                      let navigation = self.navigationController
                else { return }
                self.hideLoadingPopup()
                if data.message == "Success" {
                    navigation.popViewController(animated: true)
                } else {
                    self.showAlert(title: "Terjadi Kesalahan", message: data.message)
                }
            }
            .store(in: &anyCancellable)
    }
    
    private func setupAction() {
        guard let presenter else { return }
        customNavigationView.arrowLeftBackButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                navigation.popViewController(animated: true)
            }
            .store(in: &anyCancellable)
        
        installationSelectView.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                presenter.fetchInstallationList() { [weak self] in
                    guard let self = self,
                          let navigation = self.navigationController else { return }
                    self.showLoadingPopup()
                    
                    DispatchQueue.main.async {
                        self.hideLoadingPopup()
                        let installationList = presenter.installationList
                        let mutationData = installationList.compactMap { item in
                            return MutationSubmissionBottomSheetData(id: item.id, title: item.name)
                        }
                        presenter.showInstallationBottomSheet(from: navigation, for: mutationData, perfom: self)
                    }
                }
            }
            .store(in: &anyCancellable)
        
        equipmentSelectView.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                if let toInstallation {
                    presenter.fetchEquipmentList(toInstallation) { [weak self] in
                        guard let self = self,
                              let navigation = self.navigationController else { return }
                        self.showLoadingPopup()
                        
                        DispatchQueue.main.async {
                            self.hideLoadingPopup()
                            let installationList = presenter.equipmentList
                            let mutationData = installationList.compactMap { item in
                                return MutationSubmissionBottomSheetData(id: item.id, title: item.text)
                            }
                            presenter.showEquipmentBottomSheet(from: navigation, for: mutationData, perfom: self)
                        }
                    }
                } else {
                    self.showAlert(title: "Pemberitahuan", message: "Harap pilih instalasi/ruangan terlebih dahulu")
                }
            }
            .store(in: &anyCancellable)
        
        saveButton.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                if let toInstallation,
                   let equipmentId,
                   let qty = self.equipmentCountTextField.textField.text {
                    self.showLoadingPopup()
                    let data = MutationSubmissionRequest(
                        toInstallasi: toInstallation,
                        equipmentId: equipmentId,
                        qty: qty)
                    presenter.createSubmission(data)
                } else {
                    self.showAlert(title: "Pemberitahuan", message: "Harap lengkapi semua bidang")
                }
            }
            .store(in: &anyCancellable)
    }
    
}
