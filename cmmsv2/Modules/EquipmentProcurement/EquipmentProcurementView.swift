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
    @IBOutlet weak var suggestionCountTextField: GeneralTextField!
    @IBOutlet weak var suggestionTypeSelectView: SelectView!
    @IBOutlet weak var dateSelectView: SelectView!
    @IBOutlet weak var characteristicSelectView: SelectView!
    @IBOutlet weak var caseCountTextField: GeneralTextField!
    @IBOutlet weak var patientCountTextField: GeneralTextField!
    @IBOutlet weak var referenceCountTextField: GeneralTextField!
    @IBOutlet weak var utilityCountTextField: GeneralTextField!
    @IBOutlet weak var productServiceCountTextField: GeneralTextField!
    @IBOutlet weak var specificationTextField: GeneralTextField!
    @IBOutlet weak var mediaSectionView: MediaSectionView!
    @IBOutlet weak var addButton: GeneralButton!
    
    @IBOutlet weak var additionContainerStackView: UIStackView!
    @IBOutlet weak var justificationTextField: GeneralTextField!
    @IBOutlet weak var replacementContainerStackView: UIStackView!
    @IBOutlet weak var equipmentAgeTextField: GeneralTextField!
    @IBOutlet weak var equipmentConditionSelectView: SelectView!
    
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
        guard let presenter,
              let data = presenter.data
        else { return }
        if let image =  data.fotoAlat {
            equipmentImageView.loadImageUrl(image)
        } else {
            equipmentImageView.image = UIImage(named: "add_room_requirement_background")
        }
        
        customNavigationView.configure(toolbarTitle: "Kebutuhan Ruangan", type: .plain)
        equipmentImageView.makeCornerRadius(8)
        workUnitSelectView.configure(title: "Instalasi Unit Kerja", placeHolder: "Pilih Instalasi", value: data.namaInstalasi)
        roomSelectView.configure(title: "Ruangan Sub Unit", placeHolder: "Pilih Ruangan", value: data.namaRoom)
        medicalAssetSelectView.configure(title: "Alat Medik", placeHolder: "Pilih Alat Medik", value: data.namaAlat)
        let isSuggestionDisabled = data.jumlah != nil && !data.jumlah!.isEmpty
        suggestionCountTextField.configure(title: "Jumlah Usulan", placeholder: data.jumlah ?? "Masukan Jumlah Usulan", isDisabled: isSuggestionDisabled)
        suggestionTypeSelectView.configure(title: "Tipe Usulan", placeHolder: "Pilih Tipe Usulan", value: data.satuan)
        dateSelectView.configure(title: "Tanggal", placeHolder: "Pilih Tanggal", value: data.tglKebutuhan, type: .date)
        characteristicSelectView.configure(title: "Sifat", placeHolder: "Pilih Sifat", value: data.namaSifat)
        specificationTextField.configure(title: "Spesifikasi", placeholder: data.keterangan ?? "Masukan Spesifikasi")
        
        let isCaseDisabled = data.tambahKasus != nil && !data.tambahKasus!.isEmpty
        caseCountTextField.configure(title: "Jumlah Kasus", placeholder: data.tambahKasus ?? "Masukan Jumlah Kasus", isDisabled: isCaseDisabled)
        
        let isPatientCountDisabled = data.tambahPasien != nil && !data.tambahPasien!.isEmpty
        patientCountTextField.configure(title: "Jumlah Pasien", placeholder: data.tambahPasien ?? "Masukan Jumlah Pasien", isDisabled: isPatientCountDisabled)
        
        let isReferenceCountDisabled = data.tambahRujuk != nil && !data.tambahRujuk!.isEmpty
        referenceCountTextField.configure(title: "Jumlah Rujukan", placeholder: data.tambahRujuk ?? "Masukan Jumlah Rujukan", isDisabled: isReferenceCountDisabled)
        
        let isUtilityCountDisabled = data.tambahUtil != nil && !data.tambahUtil!.isEmpty
        utilityCountTextField.configure(title: "Jumlah Utilitas", placeholder: data.tambahUtil ?? "Masukan Jumlah Utilitas", isDisabled: isUtilityCountDisabled)
        
        let isProductCountDisabled = data.tambahProduk != nil && !data.tambahProduk!.isEmpty
        productServiceCountTextField.configure(title: "Jumlah Produk Layanan", placeholder: data.tambahProduk ?? "Masukan Jumlah Produk Layanan", isDisabled: isProductCountDisabled)
        
        let isJustificationDisabled = data.baruInfo != nil && !data.baruInfo!.isEmpty
        justificationTextField.configure(title: "Justifikasi", placeholder: data.baruInfo ?? "Masukan Justifikasi", isDisabled: isJustificationDisabled)
        
        let isAgeEquipmentDisabled = data.gantiUsia != nil && !data.gantiUsia!.isEmpty
        equipmentAgeTextField.configure(title: "Usia Alat", placeholder: data.gantiUsia ?? "Masukan Usia Alat", isDisabled: isAgeEquipmentDisabled)
        
        equipmentConditionSelectView.configure(title: "Kondisi Alat", placeHolder: "Pilih Kondisi Alat", value: data.namaKondisi)
        
        addButton.configure(title: "TAMBAHKAN")
        mediaSectionView.delegate = self
        mediaSectionView.configure(data: [], activity: .working)
        
        // MARK: - VISIBILITY
        additionContainerStackView.isHidden = data.namaSifat == "Tambahan" ? false : true
        justificationTextField.isHidden = data.namaSifat == "Baru" ? false : true
        replacementContainerStackView.isHidden = data.namaSifat == "Penggantian" ? false : true
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
