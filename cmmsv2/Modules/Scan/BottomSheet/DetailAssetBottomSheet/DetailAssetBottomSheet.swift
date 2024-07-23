//
//  InformationDetailBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 11/01/24.
//

import UIKit
import Combine

class DetailAssetBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    
    @IBOutlet weak var serialNumberView: InformationCardView!
    @IBOutlet weak var roomView: InformationCardView!
    @IBOutlet weak var brandView: InformationCardView!
    @IBOutlet weak var typeView: InformationCardView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var initialHeightCollectionView: NSLayoutConstraint!
    
    var data: [CategoryModel] = detailInformationData
    var equipment: ScanEquipment?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
    }
    
}

extension DetailAssetBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCardCVC.nib, forCellWithReuseIdentifier: CategoryCardCVC.identifier)
        collectionView.isScrollEnabled = false
    }
    
    private func setupView() {
        guard let data = self.equipment,
              let title = data.txtName,
              let image = data.valImage,
              let serialNumber = data.txtSerial,
              let room = data.txtRuangan,
              let brand = data.txtBrand,
              let type = data.txtType
        else { return }
        
        headerView.addBorder(width: 2, colorBorder: UIColor.customLightGrayColor)
        headerView.makeCornerRadius(12)
        headerImageView.makeCornerRadius(12)
        
        headerImageView.loadImageUrl(image)
        headerTitleLabel.text = title
        serialNumberView.configureView(title: "Serial Number", value: serialNumber)
        roomView.configureView(title: "Ruangan", value: room)
        brandView.configureView(title: "Merk", value: brand)
        typeView.configureView(title: "Tipe", value: type)
        
        scrollView.makeCornerRadius(32, .topCurve)
        calculateTotalHeight(data: self.data)
    }
    
    private func setupAction() {
        bottomSheetView.handleBarArea.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                self.dismissBottomSheet()
            }
            .store(in: &anyCancellable)
    }
    
    private func calculateTotalHeight(data: [CategoryModel]) {
        let numberOfRows: CGFloat = 2
        let itemHeight: CGFloat = CGSize.widthDevice / 2
        let totalHeight = itemHeight * numberOfRows
        self.initialHeightCollectionView.constant = totalHeight
    }
    
}

extension DetailAssetBottomSheet: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCardCVC.identifier, for: indexPath) as? CategoryCardCVC
        else {
            return UICollectionViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 4, height: 120)
    }
    
}
