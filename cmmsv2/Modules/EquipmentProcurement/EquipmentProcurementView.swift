//
//  EquipmentProcurementView.swift
//  cmmsv2
//
//  Created by macbook  on 05/10/24.
//

import UIKit

class EquipmentProcurementView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var equipmentImageView: UIImageView!
    @IBOutlet weak var workUnitSelectView: SelectView!
    @IBOutlet weak var roomSelectView: SelectView!
    @IBOutlet weak var medicalAssetSelectView: SelectView!
    @IBOutlet weak var suggestionCountSelectView: GeneralTextField!
    @IBOutlet weak var suggestionTypeSelectView: SelectView!
    @IBOutlet weak var dateSelectView: SelectView!
    @IBOutlet weak var characteristicSelectView: SelectView!
    @IBOutlet weak var caseCountTextField: GeneralTextField!
    @IBOutlet weak var patientCountTextField: GeneralTextField!
    @IBOutlet weak var referenceCountTextField: GeneralTextField!
    @IBOutlet weak var utilityCountTextField: GeneralTextField!
    @IBOutlet weak var productServiceCountTextField: GeneralTextField!
    @IBOutlet weak var specificationTextField: GeneralTextField!
    @IBOutlet weak var addButton: GeneralButton!
    
    var presenter: EquipmentProcurementPresenter?
    
    override func didLoad() {
        super.didLoad()
        self.validateUser()
        self.setupBody()
    }
    
}

extension EquipmentProcurementView {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        customNavigationView.configure(toolbarTitle: "Kebutuhan Ruangan", type: .plain)
        equipmentImageView.makeCornerRadius(8)
        workUnitSelectView.configure(title: "Instalasi Unit Kerja", placeHolder: "Pilih Instalasi")
        roomSelectView.configure(title: "Ruangan Sub Unit", placeHolder: "Pilih Ruangan")
        medicalAssetSelectView.configure(title: "Alat Medik", placeHolder: "Pilih Alat Medik")
        suggestionCountSelectView.configure(title: "Jumlah Usulan", placeholder: "Masukan Jumlah Usulan")
        suggestionTypeSelectView.configure(title: "Tipe Usulan", placeHolder: "Pilih Tipe Usulan")
        dateSelectView.configure(title: "Tanggal", placeHolder: "Pilih Tanggal")
        characteristicSelectView.configure(title: "Sifat", placeHolder: "Pilih Sifat")
        specificationTextField.configure(title: "Spesifikasi", placeholder: "Masukan Spesifikasi")
        addButton.configure(title: "TAMBAHKAN")
    }
    
    private func setupAction() {
        customNavigationView.arrowLeftBackButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                navigation.popViewController(animated: true)
            }
            .store(in: &anyCancellable)
    }
    
}
