//
//  ComplaintDetailView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/05/24.
//

import UIKit

class ComplaintDetailView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var containerAssetView: UIView!
    @IBOutlet weak var assetNameLabel: UILabel!
    @IBOutlet weak var serialNumberView: InformationCardView!
    @IBOutlet weak var brandView: InformationCardView!
    @IBOutlet weak var typeView: InformationCardView!
    @IBOutlet weak var roomView: InformationCardView!
    
    @IBOutlet weak var containerTroubleView: UIView!
    @IBOutlet weak var damageTopicView: InformationCardView!
    @IBOutlet weak var damageChronologyView: InformationCardView!
    
    @IBOutlet weak var containerWorkSheetView: UIView!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var containerDamagePictureView: UIView!
    @IBOutlet weak var emptyPictureView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var medias: [Media] = []
    var presenter: ComplaintDetailPresenter?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension ComplaintDetailView {
    
    private func setupBody() {
        fetchInitialData()
        bindingData()
        setupView()
        setupAction()
        setupCollectionView()
    }
    
    private func fetchInitialData() {
        guard let presenter else { return }
        presenter.fetchInitialData()
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$complaintData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self,
                      let data,
                      let media = data.medias
                else { return }
                self.assetNameLabel.text = data.equipment?.txtName ?? ""
                
                self.serialNumberView.configureView(title: "Serial Number", value: data.equipment?.txtSerial ?? "-")
                self.brandView.configureView(title: "Merk", value: data.equipment?.txtBrand ?? "-")
                self.typeView.configureView(title: "Tipe", value: data.equipment?.txtType ?? "-")
                self.roomView.configureView(title: "Ruangan", value: data.equipment?.txtRuangan ?? "-")
                
                self.damageTopicView.configureView(title: "Topik Kerusakan", value: data.txtTitle ?? "-")
                self.damageChronologyView.configureView(title: "Kronologi Kerusakan", value: data.txtDescriptions ?? "-")
                
                self.serialNumberLabel.text = data.valWoList?.first?.lkNumber ?? "-"
                self.dateLabel.text = "\(data.valWoList?.first?.engineerName ?? "-") • \(data.valWoList?.first?.lkDate ?? "-")"
                self.configureStatus(status: CorrectiveStatusType(rawValue: ((data.valWoList?.first?.statusText ?? .none) ?? "")) ?? .none)
                
                self.medias = media
                self.collectionView.reloadData()
                
                if media.isEmpty {
                    self.emptyPictureView.isHidden = false
                    self.collectionView.isHidden = true
                } else {
                    self.emptyPictureView.isHidden = true
                    self.collectionView.isHidden = false
                }
            }
            .store(in: &anyCancellable)
    }
    
    private func setupView() {
        customNavigationView.configure(plainTitle: "Detail Pengaduan", type: .plain)
        containerView.makeCornerRadius(8)
        containerView.addShadow(0.4)
        
        containerAssetView.makeCornerRadius(8)
        containerAssetView.addShadow(0.4)
        
        containerTroubleView.makeCornerRadius(8)
        containerTroubleView.addShadow(0.4)
        
        containerWorkSheetView.makeCornerRadius(8)
        containerWorkSheetView.addShadow(0.4)
        
        containerDamagePictureView.makeCornerRadius(8)
        containerDamagePictureView.addShadow(0.4)
        
        statusView.makeCornerRadius(4)
    }
    
    private func configureStatus(status: CorrectiveStatusType) {
        statusLabel.text = status.getStringValue().capitalized
        
        switch status {
        case .open:
            statusView.backgroundColor = UIColor.customLightGreenColor
            statusLabel.textColor = UIColor.customIndicatorColor8
        case .closed:
            statusView.backgroundColor = UIColor.customSecondaryColor
            statusLabel.textColor = UIColor.customPrimaryColor
        case .progress:
            statusView.backgroundColor = UIColor.customIndicatorColor2
            statusLabel.textColor = UIColor.customIndicatorColor11
        case .delay:
            statusView.backgroundColor = UIColor.customIndicatorColor2
            statusLabel.textColor = UIColor.customIndicatorColor11
        case .none:
            statusView.isHidden = true
        }
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
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EvidenceEquipmentCVC.nib, forCellWithReuseIdentifier: EvidenceEquipmentCVC.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
}

extension ComplaintDetailView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.medias.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EvidenceEquipmentCVC.identifier, for: indexPath) as? EvidenceEquipmentCVC
        else {
            return UICollectionViewCell()
        }
        
        cell.setupCell(url: self.medias[indexPath.row].valUrl ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = self.medias[indexPath.row]
        guard let presenter,
              let navigation = self.navigationController,
              let image = selectedItem.valUrl
        else { return }
        presenter.navigateToDetailPicture(navigation: navigation, image: image)
    }
    
}
