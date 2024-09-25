//
//  EditComplaintView.swift
//  cmmsv2
//
//  Created by macbook  on 22/09/24.
//

import UIKit
import Combine

class EditComplaintView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var containerHeaderView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var assetNameLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var seeDetailView: UIView!
    @IBOutlet weak var assetImageView: UIImageView!
    @IBOutlet weak var complaintTitleTextField: GeneralTextField!
    @IBOutlet weak var complaintDescriptionTextField: GeneralTextField!
    @IBOutlet weak var uploadButton: UIImageView!
    @IBOutlet weak var addMediaButton: UIImageView!
    @IBOutlet weak var mediaCollectionView: UICollectionView!
    @IBOutlet weak var saveButton: GeneralButton!
    @IBOutlet weak var addMediaUploadStackView: UIStackView!
    
    var presenter: EditComplaintPresenter?
    var complaintData: ComplaintDetail?
    var medias: [Media] = []
    var assetId: String?
    var mediaId: [String] = []
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.validateUser()
    }
    
}

extension EditComplaintView {
    
    private func setupBody() {
        setupView()
        setupAction()
        fetchInitialData()
        bindingData()
        setupCollectionView()
    }
    
    private func setupView() {
        self.uploadButton.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.showLoadingPopup()
        customNavigationView.configure(toolbarTitle: "Edit Pengaduan", type: .plain)
        assetImageView.makeCornerRadius(12)
        headerView.makeCornerRadius(12)
        headerView.addShadow(0.8)
        seeDetailView.makeCornerRadius(6)
        saveButton.configure(title: "Simpan")
        complaintTitleTextField.configure(title: "Judul Kerusakan", placeholder: "Masukan Judul Kerusakan")
        complaintDescriptionTextField.configure(title: "Keterangan Kerusakan", placeholder: "Masukan Keterangan Kerusakan")
        // MARK: - TEMPORARY
        seeDetailView.isHidden = true
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
        
        saveButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let titleText = self.complaintTitleTextField.textField.text,
                      let descriptionText = self.complaintDescriptionTextField.textField.text
                else { return }
                self.showLoadingPopup()
                let request = UpdateComplaintRequestEntity(
                    equipmentId: String(self.complaintData?.equipment?.id ?? 0),
                    title: titleText,
                    descriptions: descriptionText,
                    imageId: self.mediaId,
                    deleteImages: [])
                presenter.updateComplaintData(request, id: presenter.id ?? "")
            }
            .store(in: &anyCancellable)
        
        Publishers.Merge(uploadButton.gesture(), addMediaButton.gesture())
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                presenter.showUploadMediaBottomSheet(navigation: navigation, delegate: self)
            }
            .store(in: &anyCancellable)
    }
    
    private func fetchInitialData() {
        guard let presenter else { return }
        presenter.fetchInitialData()
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$complaintData
            .sink { [weak self] data in
                guard let self, let data else { return }
                self.hideLoadingPopup()
                self.complaintData = data
                self.assetId = String(data.equipment?.id ?? 0)
                self.assetImageView.loadImageUrl(data.equipment?.valImage ?? "")
                self.assetNameLabel.text = data.equipment?.txtName ?? "-"
                self.roomLabel.text = data.equipment?.txtRuangan ?? "-"
                self.complaintTitleTextField.textField.text = data.txtTitle ?? "-"
                self.complaintDescriptionTextField.textField.text = data.txtDescriptions ?? "-"
                self.serialNumberLabel.text = data.equipment?.txtSerial ?? "-"
                self.medias = data.medias ?? []
                let uploadedMediaIds = medias.compactMap { $0.id }
                self.mediaId = uploadedMediaIds
                self.updateUploadStackViewVisibility()
                self.reloadCollectionViewWithAnimation(self.mediaCollectionView)
            }
            .store(in: &anyCancellable)
        
        presenter.$updateComplaintData
            .sink { [weak self] data in
                guard let self,
                      let data,
                      let navigation = self.navigationController
                else { return }
                self.hideLoadingPopup()
                if data.message == "Success" {
                    navigation.popViewController(animated: true)
                } else {
                    self.showAlert(title: "Terjadi Kesalahan!", message: data.message)
                }
            }
            .store(in: &anyCancellable)
    }
    
    private func setupCollectionView() {
        mediaCollectionView.dataSource = self
        mediaCollectionView.delegate = self
        mediaCollectionView.register(EvidenceEquipmentCVC.nib, forCellWithReuseIdentifier: EvidenceEquipmentCVC.identifier)
        mediaCollectionView.isScrollEnabled = true
        mediaCollectionView.showsVerticalScrollIndicator = false
        mediaCollectionView.showsHorizontalScrollIndicator = false
        addMediaButton.makeCornerRadius(8)
        addMediaButton.makeCornerRadius(8)
    }
    
    func updateUploadStackViewVisibility() {
        self.reloadCollectionViewWithAnimation(self.mediaCollectionView)
        if self.medias.isEmpty {
            self.uploadButton.isHidden = false
            self.addMediaUploadStackView.isHidden = true
        } else {
            self.uploadButton.isHidden = true
            self.addMediaUploadStackView.isHidden = false
        }
    }
    
}

extension EditComplaintView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.medias.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EvidenceEquipmentCVC.identifier, for: indexPath) as? EvidenceEquipmentCVC else {
            return UICollectionViewCell()
        }
        
        let index = indexPath.row
        cell.setupCell(url: self.medias[index].valThumburl, type: .view)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToDetailDocument(navigation: navigation, file: self.medias[indexPath.row].valThumburl, type: .image)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGSize.widthDevice / 3.8, height: collectionView.frame.height)
    }
    
}
