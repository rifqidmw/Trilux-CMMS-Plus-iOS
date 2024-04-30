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
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    
    @IBOutlet weak var serialNumberView: InformationCardView!
    @IBOutlet weak var roomView: InformationCardView!
    @IBOutlet weak var brandView: InformationCardView!
    @IBOutlet weak var typeView: InformationCardView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data: [CategoryModel] = detailInformationData
    var equipment: ScanEquipment?
    
    override func didLoad() {
        super.didLoad()
        setupBody()
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
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 4
        layout.itemSize = CGSize(width: 72, height: 120)
        collectionView.collectionViewLayout = layout
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
        
        headerView.addBorder(width: 2, colorBorder: UIColor.customLightGrayColor.cgColor)
        headerView.makeCornerRadius(12)
        headerImageView.makeCornerRadius(12)
        
        headerImageView.loadImageUrl(image)
        headerTitleLabel.text = title
        serialNumberView.configureView(title: "Serial Number", value: serialNumber)
        roomView.configureView(title: "Ruangan", value: room)
        brandView.configureView(title: "Merk", value: brand)
        typeView.configureView(title: "Tipe", value: type)
        
        bottomSheetView.containerView.backgroundColor = .clear
        scrollView.makeCornerRadius(32, .topCurve)
    }
    
    private func setupAction() {
        Publishers.Merge(
            bottomSheetView.handleBarArea.gesture(),
            dismissAreaView.gesture())
        .sink { [weak self] _ in
            guard let self else { return }
            self.dismiss(animated: true)
        }
        .store(in: &anyCancellable)
    }
    
}

extension DetailAssetBottomSheet: UICollectionViewDataSource, UICollectionViewDelegate {
    
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
    
}
