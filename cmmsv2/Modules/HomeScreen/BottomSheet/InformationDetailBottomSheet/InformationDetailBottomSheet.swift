//
//  InformationDetailBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 11/01/24.
//

import UIKit

class InformationDetailBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    
    @IBOutlet weak var serialNumberView: BriefInformationCardView!
    @IBOutlet weak var roomView: BriefInformationCardView!
    @IBOutlet weak var brandView: BriefInformationCardView!
    @IBOutlet weak var typeView: BriefInformationCardView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data: [CategoryModel] = detailInformationData
    
    override func didLoad() {
        super.didLoad()
        setupBody()
    }
    
}

extension InformationDetailBottomSheet {
    
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
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 24
        layout.minimumInteritemSpacing = 24
        layout.itemSize = CGSize(width: collectionView.frame.width / 5, height: 128)
        collectionView.collectionViewLayout = layout
    }
    
    private func setupView() {
        headerView.addBorder(width: 2, colorBorder: UIColor.customLightGrayColor.cgColor)
        headerView.makeCornerRadius(12)
        headerImageView.makeCornerRadius(12)
        
        serialNumberView.configureView(title: "Serial Number", value: "112234452537")
        roomView.configureView(title: "Ruangan", value: "Poliklinik Executive Cendana")
        brandView.configureView(title: "Merk", value: "B Braun")
        typeView.configureView(title: "Tipe", value: "NE-C28")
    }
    
    private func setupAction() {
        bottomSheetView.handleBarArea.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                self.dismiss(animated: true)
            }
            .store(in: &anyCancellable)
    }
    
}

extension InformationDetailBottomSheet: UICollectionViewDataSource, UICollectionViewDelegate {
    
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
