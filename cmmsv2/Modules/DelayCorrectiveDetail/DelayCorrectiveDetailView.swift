//
//  DelayCorrectiveDetailView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 31/05/24.
//

import UIKit

class DelayCorrectiveDetailView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var containerStackView: UIStackView!
    
    @IBOutlet weak var containerAssetView: UIView!
    @IBOutlet weak var headerAssetView: CustomHeaderView!
    @IBOutlet weak var serialNumberView: InformationCardView!
    @IBOutlet weak var brandView: InformationCardView!
    @IBOutlet weak var typeView: InformationCardView!
    @IBOutlet weak var roomView: InformationCardView!
    
    @IBOutlet weak var containerTroubleView: UIView!
    @IBOutlet weak var headerTroubleView: CustomHeaderView!
    @IBOutlet weak var troubleTopicView: InformationCardView!
    @IBOutlet weak var troubleChronologyView: InformationCardView!
    
    @IBOutlet weak var containerWorkSheetView: UIView!
    @IBOutlet weak var headerWorkSheetView: CustomHeaderView!
    
    @IBOutlet weak var detailWorkSheetView: UIView!
    @IBOutlet weak var detailWorkSheetStackView: UIStackView!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var containerDamagePictureView: UIView!
    @IBOutlet weak var headerDamagePictureView: CustomHeaderView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: DelayCorrectiveDetailPresenter?
    var media: [Media] = []
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.validateUser()
    }
    
}

extension DelayCorrectiveDetailView {
    
    private func setupBody() {
        fetchInitialData()
        bindingData()
        setupView()
        setupAction()
        setupCollectionView()
        showAnimationSkeleton()
    }
    
    private func fetchInitialData() {
        guard let presenter else { return }
        presenter.fetchInitialData()
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$complaintData
            .sink { [weak self] data in
                guard let self,
                      let data,
                      let equipment = data.equipment,
                      let workSheet = data.valWoList,
                      let medias = data.medias
                else { return }
                self.hideAnimationSkeleton()
                self.media = medias
                self.collectionView.reloadData()
                
                self.headerAssetView.configure(icon: "ic_notes_board", title: equipment.txtName ?? "-", type: .plain)
                self.serialNumberView.configureView(title: "Serial Number", value: equipment.txtSerial ?? "-")
                self.brandView.configureView(title: "Merk", value: equipment.txtBrand ?? "-")
                self.typeView.configureView(title: "Tipe", value: equipment.txtType ?? "-")
                self.roomView.configureView(title: "Ruangan", value: equipment.txtRuangan ?? "-")
                
                self.troubleTopicView.configureView(title: "Topik Kerusakan", value: data.txtTitle ?? "-")
                self.troubleChronologyView.configureView(title: "Kronologi Kerusakan", value: data.txtDescriptions ?? "-")
                
                self.serialNumberLabel.text = workSheet.first?.lkNumber ?? "-"
                self.dateLabel.text = "\(workSheet.first?.engineerName ?? "-") • \(workSheet.first?.lkDate ?? "-")"
                self.statusLabel.text = workSheet.first?.statusText ?? "-"
            }
            .store(in: &anyCancellable)
    }
    
    private func setupView() {
        customNavigationView.configure(toolbarTitle: "Detail Pengaduan", type: .plain)
        containerStackView.makeCornerRadius(8)
        containerStackView.addShadow(0.8)
        
        containerAssetView.makeCornerRadius(8)
        containerAssetView.addShadow(0.8)
        
        headerTroubleView.configure(icon: "ic_document_trouble", title: "Permasalahan", type: .plain)
        containerTroubleView.makeCornerRadius(8)
        containerTroubleView.addShadow(0.8)
        
        headerWorkSheetView.configure(icon: "ic_notes_board", title: "Lembar Kerja", type: .plain)
        containerWorkSheetView.makeCornerRadius(8)
        containerWorkSheetView.addShadow(0.8)
        detailWorkSheetView.makeCornerRadius(8)
        detailWorkSheetView.addShadow(0.8, position: .bottom)
        statusView.makeCornerRadius(8)
        
        headerDamagePictureView.configure(icon: "ic_image", title: "Foto Kerusakan", type: .plain)
        containerDamagePictureView.makeCornerRadius(8)
        containerDamagePictureView.addShadow(0.8)
    }
    
    private func setupAction() {
        customNavigationView.arrowLeftBackButton.gesture()
            .sink { [weak self] _ in
                guard let self, let navigation = self.navigationController else { return }
                navigation.popViewController(animated: true)
            }
            .store(in: &anyCancellable)
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EvidenceEquipmentCVC.nib, forCellWithReuseIdentifier: EvidenceEquipmentCVC.identifier)
    }
    
    private func showAnimationSkeleton() {
        [self.headerAssetView.iconImageView,
         self.headerAssetView.titleLabel,
         self.headerTroubleView.iconImageView,
         self.headerTroubleView.titleLabel,
         self.headerWorkSheetView.iconImageView,
         self.headerWorkSheetView.titleLabel,
         self.headerDamagePictureView.iconImageView,
         self.headerDamagePictureView.titleLabel
        ].forEach {
            $0.isSkeletonable = true
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideAnimationSkeleton() {
        [self.headerAssetView.iconImageView,
         self.headerAssetView.titleLabel,
         self.headerTroubleView.iconImageView,
         self.headerTroubleView.titleLabel,
         self.headerWorkSheetView.iconImageView,
         self.headerWorkSheetView.titleLabel,
         self.headerDamagePictureView.iconImageView,
         self.headerDamagePictureView.titleLabel
        ].forEach {
            $0.hideSkeleton()
        }
    }
    
}


extension DelayCorrectiveDetailView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.media.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EvidenceEquipmentCVC.identifier, for: indexPath) as? EvidenceEquipmentCVC else {
            return UICollectionViewCell()
        }
        cell.setupCell(url: self.media[indexPath.row].valUrl ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        let selectedPicture = self.media[indexPath.row].valUrl ?? ""
        presenter.navigateToDetailPicture(navigation: navigation, image: selectedPicture)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGSize.widthDevice / 3, height: collectionView.frame.height)
    }
    
}
