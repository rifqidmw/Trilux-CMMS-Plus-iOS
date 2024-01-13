//
//  AllCategoriesBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/01/24.
//

import UIKit

class AllCategoriesBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var collectionView: UICollectionView!
    var data: [CategoryModel] = allCategoryData
    
    override func didLoad() {
        super.didLoad()
        setupBody()
    }
    
}

extension AllCategoriesBottomSheet {
    
    private func setupBody() {
        setupCollectionView()
        setupAction()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCardCVC.nib, forCellWithReuseIdentifier: CategoryCardCVC.identifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        
        let totalInteritemSpacing = (4 - 1) * layout.minimumInteritemSpacing
        let width = collectionView.frame.width - totalInteritemSpacing
        layout.itemSize = CGSize(width: width / 4, height: 120)
        
        collectionView.collectionViewLayout = layout
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

extension AllCategoriesBottomSheet: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
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
