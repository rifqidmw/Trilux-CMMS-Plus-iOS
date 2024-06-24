//
//  WorkSheetCorrectiveDetailView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/05/24.
//

import UIKit
import SkeletonView

class WorkSheetCorrectiveDetailView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var containerHeaderView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var serialLabel: UILabel!
    @IBOutlet weak var moreDetailButton: UIView!
    @IBOutlet weak var seeProgressButton: GeneralButton!
    
    @IBOutlet weak var containerDetailContentView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var damagedLabel: UILabel!
    @IBOutlet weak var chronologyLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var workSheetView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var technicianLabel: UILabel!
    
    @IBOutlet weak var workSheetSerialLabel: UILabel!
    @IBOutlet weak var workSheetDateLabel: UILabel!
    
    var medias: [Media] = []
    var presenter: WorkSheetCorrectiveDetailPresenter?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.validateUser()
    }
    
}

extension WorkSheetCorrectiveDetailView {
    
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
                      let equipment = data.equipment,
                      let media = data.medias
                else { return }
                self.hideAnimationSkeleton()
                self.headerImageView.loadImageUrl(equipment.valImage ?? "")
                self.titleLabel.text = equipment.txtName
                self.roomLabel.text = equipment.txtRuangan
                self.serialLabel.text = "\(equipment.txtSerial ?? "") - \(equipment.txtBrand ?? "" )"
                self.dateLabel.text = data.txtComplainTime
                self.damagedLabel.text = data.txtTitle
                self.chronologyLabel.text = data.txtDescriptions
                self.workSheetSerialLabel.text = data.valWoList?.first?.lkNumber
                self.workSheetDateLabel.text = data.valWoList?.first?.lkDate
                self.statusLabel.text = data.valWoList?.first?.statusText
                self.technicianLabel.text = data.valWoList?.first?.engineerName
                
                self.medias = media
                self.collectionView.reloadData()
                
                if media.isEmpty {
                    self.emptyView.isHidden = false
                    self.collectionView.isHidden = true
                } else {
                    self.emptyView.isHidden = true
                    self.collectionView.isHidden = false
                }
                
            }
            .store(in: &anyCancellable)
    }
    
    private func setupView() {
        customNavigationView.configure(toolbarTitle: "Detail Pengaduan", type: .plain)
        headerImageView.makeCornerRadius(12)
        containerHeaderView.makeCornerRadius(12)
        containerHeaderView.addShadow(0.8)
        moreDetailButton.makeCornerRadius(6)
        seeProgressButton.configure(title: "Lihat Progres", type: .bordered, backgroundColor: .white, titleColor: UIColor.customDarkGrayColor)
        containerDetailContentView.makeCornerRadius(12)
        containerDetailContentView.addShadow(0.8)
        emptyView.makeCornerRadius(12)
        workSheetView.makeCornerRadius(12)
        DispatchQueue.main.async {
            self.showAnimationSkeleton()
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
    }
    
    private func showAnimationSkeleton() {
        [self.headerImageView,
         self.titleLabel,
         self.roomLabel,
         self.serialLabel,
         self.dateLabel,
         self.damagedLabel,
         self.chronologyLabel,
         self.workSheetSerialLabel,
         self.workSheetDateLabel,
         self.statusLabel,
         self.technicianLabel
        ].forEach {
            $0.isSkeletonable = true
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideAnimationSkeleton() {
        [self.headerImageView,
         self.titleLabel,
         self.roomLabel,
         self.serialLabel,
         self.dateLabel,
         self.damagedLabel,
         self.chronologyLabel,
         self.workSheetSerialLabel,
         self.workSheetDateLabel,
         self.statusLabel,
         self.technicianLabel
        ].forEach {
            $0.hideSkeleton()
        }
    }
    
}

extension WorkSheetCorrectiveDetailView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
        return CGSize(width: CGSize.widthDevice / 2, height: collectionView.frame.height)
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
