//
//  EditTechnicalView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 02/08/24.
//

import UIKit
import Combine

class EditTechnicalView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var containerTechnicalDataStackView: UIStackView!
    @IBOutlet weak var technicalDataHeaderView: CustomHeaderView!
    @IBOutlet weak var serialNumberTextField: GeneralTextField!
    @IBOutlet weak var selectTechnologyView: SelectView!
    @IBOutlet weak var powerConsumptionTextField: GeneralTextField!
    @IBOutlet weak var selectPriorityView: SelectView!
    @IBOutlet weak var classRiskTextField: GeneralTextField!
    
    @IBOutlet weak var containerEquipmentManagementStackView: UIStackView!
    @IBOutlet weak var equipmentManagementHeaderView: CustomHeaderView!
    @IBOutlet weak var functionTextField: GeneralTextField!
    @IBOutlet weak var riskTextField: GeneralTextField!
    @IBOutlet weak var maintenanceTextField: GeneralTextField!
    @IBOutlet weak var incidentTextField: GeneralTextField!
    @IBOutlet weak var selectMaintenanceFrequencyView: SelectView!
    
    @IBOutlet weak var containerMMELStackView: UIStackView!
    @IBOutlet weak var mmelHeaderView: CustomHeaderView!
    @IBOutlet weak var yearBuyTextField: GeneralTextField!
    @IBOutlet weak var technicalAgeTextField: GeneralTextField!
    @IBOutlet weak var selectMELFactorView: SelectView!
    @IBOutlet weak var replacementValueTextField: GeneralTextField!
    
    @IBOutlet weak var containerBottomButtonView: UIView!
    @IBOutlet weak var cancelButton: GeneralButton!
    @IBOutlet weak var saveButton: GeneralButton!
    
    var presenter: EditTechnicalPresenter?
    var data: TechnicalEntity?
    var selectedTech: String?
    var selectedPriority: String?
    var selectedFrequency: String?
    var selectedMelopsi: String?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.validateUser()
    }
    
}

extension EditTechnicalView {
    
    private func setupBody() {
        setupView()
        setupAction()
        fetchInitialData()
        bindingData()
    }
    
    private func setupView() {
        customNavigationView.configure(toolbarTitle: "Update Data Teknis", type: .plain)
        containerBottomButtonView.addShadow(1, position: .top, opacity: 0.2)
        cancelButton.configure(title: "Batal", type: .bordered)
        saveButton.configure(title: "Simpan")
        
        containerTechnicalDataStackView.makeCornerRadius(8)
        containerTechnicalDataStackView.addShadow(1, position: .bottom, opacity: 0.2)
        technicalDataHeaderView.configure(title: "Data Teknis", type: .formHeader)
        serialNumberTextField.configure(title: "Nomor Urut Medik", placeholder: "Masukan Nomor Urut")
        serialNumberTextField.textField.keyboardType = .numberPad
        powerConsumptionTextField.configure(title: "Konsumsi Daya", placeholder: "Masukan Nilai")
        powerConsumptionTextField.textField.keyboardType = .numberPad
        classRiskTextField.configure(title: "Kelas Resiko", placeholder: "Tidak Ditemukan Data")
        
        containerEquipmentManagementStackView.makeCornerRadius(8)
        containerEquipmentManagementStackView.addShadow(1, position: .bottom, opacity: 0.2)
        equipmentManagementHeaderView.configure(title: "Equipment Management", type: .formHeader)
        functionTextField.configure(title: "Fungsi", placeholder: "Tidak Ditemukan Data")
        riskTextField.configure(title: "Resiko", placeholder: "Tidak Ditemukan Data")
        maintenanceTextField.configure(title: "Pemeliharaan", placeholder: "Tidak Ditemukan Data")
        incidentTextField.configure(title: "Insiden", placeholder: "Tidak Ditemukan Data")
        
        containerMMELStackView.makeCornerRadius(8)
        containerMMELStackView.addShadow(1, position: .bottom, opacity: 0.2)
        mmelHeaderView.configure(title: "MMEL", type: .formHeader)
        yearBuyTextField.configure(title: "Tahun Pembelian", placeholder: "Tidak Ditemukan Data")
        technicalAgeTextField.configure(title: "Usia Teknis", placeholder: "Tidak Ditemukan Data")
        replacementValueTextField.configure(title: "Nilai Pengganti", placeholder: "Masukan Nilai")
        replacementValueTextField.textField.keyboardType = .numberPad
        
    }
    
    private func setupAction() {
        guard let presenter else { return }
        Publishers.Merge(
            customNavigationView.arrowLeftBackButton.gesture(),
            cancelButton.gesture())
        .sink { [weak self] _ in
            guard let self,
                  let navigation = self.navigationController
            else { return }
            navigation.popViewController(animated: true)
        }
        .store(in: &anyCancellable)
        
        selectTechnologyView.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                presenter.showSelectTechnologyBottomSheet(from: navigation, delegate: self)
            }
            .store(in: &anyCancellable)
        
        selectPriorityView.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                presenter.showSelectPriorityBottomSheet(from: navigation, delegate: self)
            }
            .store(in: &anyCancellable)
        
        selectMaintenanceFrequencyView.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                presenter.showSelectFrequencyBottomSheet(from: navigation, delegate: self)
            }
            .store(in: &anyCancellable)
        
        selectMELFactorView.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                presenter.showSelectMelopsiBottomSheet(from: navigation, delegate: self)
            }
            .store(in: &anyCancellable)
        
        saveButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let data,
                      let detail = data.data,
                      let reff = data.reff
                else { return }
                self.showLoadingPopup()
                let funcData = reff.fungsi?.first(where: { $0.value == self.functionTextField.textField.text })
                let insiden = reff.insiden?.first(where: { $0.value == self.incidentTextField.textField.text })
                let clsRisk = reff.kelasResiko?.first(where: { $0.value == self.classRiskTextField.textField.text })
                let maintenanceData = reff.pemeliharaan?.first(where: { $0.value == self.maintenanceTextField.textField.text })
                let riskData = reff.resiko?.first(where: { $0.value == self.riskTextField.textField.text })
                
                let request = EditTechnicalRequestEntity(
                    frekuensi: self.selectedFrequency ?? "",
                    fungsi:  funcData?.key ?? "",
                    idAsset: presenter.id ?? "",
                    insiden:  insiden?.key ?? "",
                    klsresiko: clsRisk?.key ?? "",
                    melopsi: self.selectedMelopsi ?? "",
                    pemeliharaan: maintenanceData?.key ?? "",
                    pengganti: self.replacementValueTextField.textField.text ?? "",
                    power: self.powerConsumptionTextField.textField.text ?? "",
                    priority: self.selectedPriority ?? "",
                    recpengganti: detail.recpengganti ?? "",
                    resiko: riskData?.value ?? "",
                    tech: self.selectedTech ?? "",
                    urutMedik: self.serialNumberTextField.textField.text ?? "",
                    usia: self.technicalAgeTextField.textField.text ?? "",
                    year: self.yearBuyTextField.textField.text ?? "")
                
                presenter.saveTechnicalData(data: request)
            }
            .store(in: &anyCancellable)
    }
    
    private func fetchInitialData() {
        guard let presenter else { return }
        presenter.fetchInitData()
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$technicalData
            .sink { [weak self] data in
                guard let self,
                      let data,
                      let reference = data.reff,
                      let detail = data.data
                else { return }
                self.data = data
                self.hideLoadingPopup()
                // MARK: - TECHNICAL DATA
                self.serialNumberTextField.textField.text = detail.urutMedik ?? ""
                let techData = reference.tech?.first(where: { $0.key == detail.tech })
                self.selectTechnologyView.configure(title: "Teknologi", placeHolder: "Pilih Teknologi", value: techData?.value)
                self.powerConsumptionTextField.textField.text = detail.power ?? ""
                let priority = reference.priority?.first(where: { $0.key == detail.priority })
                self.selectPriorityView.configure(title: "Prioritas", placeHolder: "Pilih Prioritas", value: priority?.value)
                let classRisk = reference.kelasResiko?.first(where: { $0.key == detail.klsresiko })
                self.classRiskTextField.textField.text = classRisk?.value
                self.disabledTextField(self.classRiskTextField.textField)
                
                // MARK: - EQUIPMENT DATA
                let funcData = reference.fungsi?.first(where: { $0.key == detail.fungsi })
                self.functionTextField.textField.text = funcData?.value
                self.disabledTextField(self.functionTextField.textField)
                let riskData = reference.resiko?.first(where: { $0.key == detail.resiko })
                self.riskTextField.textField.text = riskData?.value
                self.disabledTextField(self.riskTextField.textField)
                let maintenanceData = reference.pemeliharaan?.first(where: { $0.key == detail.pemeliharaan })
                self.maintenanceTextField.textField.text = maintenanceData?.value
                self.disabledTextField(self.maintenanceTextField.textField)
                let incidentData = reference.insiden?.first(where: { $0.key == detail.insiden })
                self.incidentTextField.textField.text = incidentData?.value
                self.disabledTextField(self.incidentTextField.textField)
                let frequency = reference.frekuensi?.first(where: { $0.key == detail.frekuensi })
                self.selectMaintenanceFrequencyView.configure(title: "Frekuensi Pemeliharaan", placeHolder: "Pilih Frekuensi", value: frequency?.value)
                
                // MARK: - MMEL
                self.yearBuyTextField.textField.text = detail.year ?? ""
                self.disabledTextField(self.yearBuyTextField.textField)
                self.technicalAgeTextField.textField.text = detail.usia ?? ""
                self.disabledTextField(self.technicalAgeTextField.textField)
                let melopsiData = reference.melopsi?.first(where: { $0.key == detail.melopsi })
                self.selectMELFactorView.configure(title: "MEL Faktor", placeHolder: "Pilih Faktor", value: melopsiData?.value)
                self.replacementValueTextField.textField.text = detail.pengganti ?? ""
            }
            .store(in: &anyCancellable)
        
        presenter.$saveTechnicalData
            .sink { [weak self] data in
                guard let self,
                      let data,
                      let navigation = self.navigationController
                else { return }
                self.hideLoadingPopup()
                if data.message == "Success" {
                    navigation.popViewController(animated: true)
                } else {
                    self.showAlert(title: data.message ?? "")
                }
            }
            .store(in: &anyCancellable)
    }
    
    private func disabledTextField(_ textField: UITextField) {
        textField.isEnabled = false
        textField.textColor = UIColor.customPlaceholderColor
    }
    
}

extension EditTechnicalView: SelectTechnicalDataBottomSheetDelegate {
    
    func didSelectItem(_ key: String, type: SelectTechnicalDataBottomSheetType) {
        guard let data,
              let reff = data.reff
        else { return }
        switch type {
        case .frequency:
            self.selectedFrequency = key
            let displayFrequency = reff.frekuensi?.first(where: { $0.key == key })
            self.selectMaintenanceFrequencyView.configure(title: "Frekuensi Pemeliharaan", placeHolder: "Pilih Frekuensi", value: displayFrequency?.value ?? "")
        case .melopsi:
            self.selectedMelopsi = key
            let displayMelopsi = reff.melopsi?.first(where: { $0.key == key })
            self.selectMELFactorView.configure(title: "MEL Faktor", placeHolder: "Pilih Faktor", value: displayMelopsi?.value ?? "")
        case .priority:
            self.selectedPriority = key
            let displayPriority = reff.priority?.first(where: { $0.key == key })
            self.selectPriorityView.configure(title: "Prioritas", placeHolder: "Pilih Prioritas", value: displayPriority?.value ?? "")
        case .technology:
            self.selectedTech = key
            let displayTechnology = reff.tech?.first(where: { $0.key == key })
            self.selectTechnologyView.configure(title: "Teknologi", placeHolder: "Pilih Teknologi", value: displayTechnology?.value ?? "")
        }
    }
    
}
