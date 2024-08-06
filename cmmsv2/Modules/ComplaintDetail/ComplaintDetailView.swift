//
//  ComplaintDetailView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/05/24.
//

import UIKit
import SkeletonView

class ComplaintDetailView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var containerContentStackView: UIStackView!
    @IBOutlet weak var containerAssetView: UIView!
    @IBOutlet weak var assetHeaderView: CustomHeaderView!
    @IBOutlet weak var serialNumberView: InformationCardView!
    @IBOutlet weak var brandView: InformationCardView!
    @IBOutlet weak var typeView: InformationCardView!
    @IBOutlet weak var roomView: InformationCardView!
    
    @IBOutlet weak var containerTroubleView: UIView!
    @IBOutlet weak var damageTopicView: InformationCardView!
    @IBOutlet weak var damageChronologyView: InformationCardView!
    @IBOutlet weak var topicHeaderView: CustomHeaderView!
    
    @IBOutlet weak var containerWorkSheetView: UIView!
    @IBOutlet weak var workSheetHeaderView: CustomHeaderView!
    @IBOutlet weak var emptyWorkSheetView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var initialHeightTableViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var pictureHeaderView: CustomHeaderView!
    @IBOutlet weak var containerDamagePictureView: UIView!
    @IBOutlet weak var emptyPictureView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var medias: [Media] = []
    var workSheet: [WoList] = []
    var presenter: ComplaintDetailPresenter?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.validateUser()
    }
    
}

extension ComplaintDetailView {
    
    private func setupBody() {
        fetchInitialData()
        bindingData()
        setupView()
        setupAction()
        setupCollectionView()
        setupTableView()
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
                      let media = data.medias,
                      let woList = data.valWoList
                else { return }
                self.hideAnimationSkeleton()
                self.assetHeaderView.configure(icon: "ic_notes_board", title: data.equipment?.txtName ?? "", type: .plain)
                self.serialNumberView.configureView(title: "Serial Number", value: data.equipment?.txtSerial ?? "-")
                self.brandView.configureView(title: "Merk", value: data.equipment?.txtBrand ?? "-")
                self.typeView.configureView(title: "Tipe", value: data.equipment?.txtType ?? "-")
                self.roomView.configureView(title: "Ruangan", value: data.equipment?.txtRuangan ?? "-")
                
                self.damageTopicView.configureView(title: "Topik Kerusakan", value: data.txtTitle ?? "-")
                self.damageChronologyView.configureView(title: "Kronologi Kerusakan", value: data.txtDescriptions ?? "-")
                
                self.workSheet = woList
                self.reloadTableViewWithAnimation(self.tableView)
                self.calculateTotalHeight(for: self.tableView)
                
                if woList.isEmpty {
                    self.emptyWorkSheetView.isHidden = false
                    self.tableView.isHidden = true
                } else {
                    self.emptyWorkSheetView.isHidden = true
                    self.tableView.isHidden = false
                }
                
                self.medias = media
                self.reloadCollectionViewWithAnimation(self.collectionView)
                
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
        customNavigationView.configure(toolbarTitle: "Detail Pengaduan", type: .plain)
        containerContentStackView.makeCornerRadius(8)
        containerContentStackView.addShadow(0.4)
        
        containerAssetView.makeCornerRadius(8)
        containerAssetView.addShadow(0.4)
        
        containerTroubleView.makeCornerRadius(8)
        containerTroubleView.addShadow(0.4)
        
        containerWorkSheetView.makeCornerRadius(8)
        containerWorkSheetView.addShadow(0.4)
        
        containerDamagePictureView.makeCornerRadius(8)
        containerDamagePictureView.addShadow(0.4)
        
        topicHeaderView.configure(icon: "ic_statistic_down", title: "Permasalahan", type: .plain)
        workSheetHeaderView.configure(icon: "ic_notes_board", title: "Lembar Kerja", type: .plain)
        pictureHeaderView.configure(icon: "ic_image", title: "Foto Kerusakan", type: .plain)
        
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
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ValWorkSheetCell.nib, forCellReuseIdentifier: ValWorkSheetCell.identifier)
        tableView.separatorStyle = .none
    }
    
    private func showAnimationSkeleton() {
        [self.assetHeaderView.iconImageView,
         self.assetHeaderView.titleLabel,
         self.topicHeaderView.iconImageView,
         self.topicHeaderView.titleLabel,
         self.workSheetHeaderView.iconImageView,
         self.workSheetHeaderView.titleLabel,
         self.pictureHeaderView.iconImageView,
         self.pictureHeaderView.titleLabel,
         self.collectionView,
         self.tableView].forEach {
            $0.isSkeletonable = true
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideAnimationSkeleton() {
        [self.assetHeaderView.iconImageView,
         self.assetHeaderView.titleLabel,
         self.topicHeaderView.iconImageView,
         self.topicHeaderView.titleLabel,
         self.workSheetHeaderView.iconImageView,
         self.workSheetHeaderView.titleLabel,
         self.pictureHeaderView.iconImageView,
         self.pictureHeaderView.titleLabel,
         self.collectionView,
         self.tableView].forEach {
            $0.hideSkeleton()
        }
    }
    
}

extension ComplaintDetailView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.workSheet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ValWorkSheetCell.identifier, for: indexPath) as? ValWorkSheetCell
        else {
            return UITableViewCell()
        }
        
        let adjustedData = self.workSheet[indexPath.row]
        cell.setupCell(
            adjustedData.lkNumber,
            date: adjustedData.lkDate,
            engineer: adjustedData.engineerName,
            WorkSheetStatus(rawValue: ((adjustedData.statusText) ?? "")) ?? WorkSheetStatus.none)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func calculateTotalHeight(for tableView: UITableView) {
        var totalHeight: CGFloat = 0
        for row in 0..<tableView.numberOfRows(inSection: 0) {
            let indexPath = IndexPath(row: row, section: 0)
            totalHeight += tableView.rectForRow(at: indexPath).height
        }
        initialHeightTableViewConstraint.constant = totalHeight
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
        return CGSize(width: CGSize.widthDevice / 3, height: collectionView.frame.height)
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
        presenter.navigateToDetailDocument(navigation: navigation, file: image)
    }
    
}
