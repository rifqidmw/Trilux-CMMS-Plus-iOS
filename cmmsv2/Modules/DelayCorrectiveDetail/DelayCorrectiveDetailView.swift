//
//  DelayCorrectiveDetailView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 31/05/24.
//

import UIKit
import SkeletonView

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
    @IBOutlet weak var emptyWorkSheetView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var initialHeightTableViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var containerDamagePictureView: UIView!
    @IBOutlet weak var headerDamagePictureView: CustomHeaderView!
    @IBOutlet weak var emptyMediaView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: DelayCorrectiveDetailPresenter?
    var media: [Media] = []
    var woList: [DelayCorrectiveWorkOrder] = []
    
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
        setupTableView()
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
                self.reloadCollectionViewWithAnimation(self.collectionView)
                
                if media.isEmpty {
                    self.emptyMediaView.isHidden = false
                    self.collectionView.isHidden = true
                } else {
                    self.emptyMediaView.isHidden = true
                    self.collectionView.isHidden = false
                }
                
                self.woList = workSheet
                self.reloadTableViewWithAnimation(self.tableView)
                self.calculateTotalHeight(for: self.tableView)
                
                if workSheet.isEmpty {
                    self.emptyWorkSheetView.isHidden = false
                    self.tableView.isHidden = true
                } else {
                    self.emptyWorkSheetView.isHidden = true
                    self.tableView.isHidden = false
                }
                
                self.headerAssetView.configure(icon: "ic_notes_board", title: equipment.txtName ?? "-", type: .plain)
                self.serialNumberView.configureView(title: "Serial Number", value: equipment.txtSerial ?? "-")
                self.brandView.configureView(title: "Merk", value: equipment.txtBrand ?? "-")
                self.typeView.configureView(title: "Tipe", value: equipment.txtType ?? "-")
                self.roomView.configureView(title: "Ruangan", value: equipment.txtRuangan ?? "-")
                
                self.troubleTopicView.configureView(title: "Topik Kerusakan", value: data.txtTitle ?? "-")
                self.troubleChronologyView.configureView(title: "Kronologi Kerusakan", value: data.txtDescriptions ?? "-")
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
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ValWorkSheetCell.nib, forCellReuseIdentifier: ValWorkSheetCell.identifier)
        tableView.separatorStyle = .none
    }
    
    private func showAnimationSkeleton() {
        [self.headerAssetView.iconImageView,
         self.headerAssetView.titleLabel,
         self.headerTroubleView.iconImageView,
         self.headerTroubleView.titleLabel,
         self.headerWorkSheetView.iconImageView,
         self.headerWorkSheetView.titleLabel,
         self.headerDamagePictureView.iconImageView,
         self.headerDamagePictureView.titleLabel,
         self.collectionView,
         self.tableView
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
         self.headerDamagePictureView.titleLabel,
         self.collectionView,
         self.tableView
        ].forEach {
            $0.hideSkeleton()
        }
    }
    
}

extension DelayCorrectiveDetailView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.woList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ValWorkSheetCell.identifier, for: indexPath) as? ValWorkSheetCell
        else {
            return UITableViewCell()
        }
        
        let adjustedData = self.woList[indexPath.row]
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
        presenter.navigateToDetailDocument(navigation: navigation, file: selectedPicture)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGSize.widthDevice / 3, height: collectionView.frame.height)
    }
    
}
