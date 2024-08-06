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
    
    @IBOutlet weak var emptyWorkSheetView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var initialHeightTableViewConstraint: NSLayoutConstraint!
    
    var medias: [Media] = []
    var woList: [WoList] = []
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
        setupTableView()
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
                      let media = data.medias,
                      let woList = data.valWoList
                else { return }
                self.hideAnimationSkeleton()
                self.headerImageView.loadImageUrl(equipment.valImage ?? "")
                self.titleLabel.text = equipment.txtName
                self.roomLabel.text = equipment.txtRuangan
                self.serialLabel.text = "\(equipment.txtSerial ?? "") - \(equipment.txtBrand ?? "" )"
                self.dateLabel.text = data.txtComplainTime
                self.damagedLabel.text = data.txtTitle
                self.chronologyLabel.text = data.txtDescriptions
                
                self.woList = woList
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
        DispatchQueue.main.async {
            self.showAnimationSkeleton()
        }
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
        
        moreDetailButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                
                presenter.navigateToDetailAsset(from: navigation, .none, id: presenter.idAsset ?? "")
            }
            .store(in: &anyCancellable)
        
        seeProgressButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                if presenter.trackData.isEmpty {
                    self.showAlert(title: "Terjadi kesalahan", message: "Maaf data tidak ditemukan")
                } else {
                    presenter.showTrackingBottomSheet(from: navigation)
                }
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
        tableView.register(ValWorkSheetCorrectionCell.nib, forCellReuseIdentifier: ValWorkSheetCorrectionCell.identifier)
        tableView.separatorStyle = .none
    }
    
    private func showAnimationSkeleton() {
        [self.headerImageView,
         self.titleLabel,
         self.roomLabel,
         self.serialLabel,
         self.dateLabel,
         self.damagedLabel,
         self.chronologyLabel,
         self.collectionView,
         self.tableView,
         self.moreDetailButton,
         self.seeProgressButton
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
         self.collectionView,
         self.tableView,
         self.moreDetailButton,
         self.seeProgressButton
        ].forEach {
            $0.hideSkeleton()
        }
    }
    
}

extension WorkSheetCorrectiveDetailView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.woList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ValWorkSheetCorrectionCell.identifier, for: indexPath) as? ValWorkSheetCorrectionCell
        else {
            return UITableViewCell()
        }
        
        let adjustedData = self.woList[indexPath.row]
        cell.setupCell(adjustedData.lkNumber, date: adjustedData.lkDate, status: adjustedData.statusText, technician: adjustedData.engineerName)
        
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
