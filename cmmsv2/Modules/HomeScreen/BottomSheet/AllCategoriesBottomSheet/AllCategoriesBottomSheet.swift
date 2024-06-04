//
//  AllCategoriesBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/01/24.
//

import UIKit
import Combine

class AllCategoriesBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var initialHeightBottomSheet: NSLayoutConstraint!
    @IBOutlet weak var initialHeightCollectionView: NSLayoutConstraint!
    
    weak var delegate: AllCategoriesBottomSheetDelegate?
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
        calculateTotalHeight()
        increaseHeightBottomSheet()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCardCVC.nib, forCellWithReuseIdentifier: CategoryCardCVC.identifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.itemSize = CGSize(width: collectionView.frame.width / 4, height: 120)
        
        collectionView.collectionViewLayout = layout
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
    
    private func calculateTotalHeight() {
        let cellHeight: CGFloat = 120
        let totalHeight = (CGFloat(self.data.count) - 3) * cellHeight
        initialHeightCollectionView.constant = totalHeight
    }
    
    private func increaseHeightBottomSheet() {
        self.initialHeightBottomSheet.constant = self.initialHeightCollectionView.constant
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = self.delegate else { return }
        switch indexPath.row {
        case 0:
            delegate.didTapAssetCategory()
        case 1:
            delegate.didTapComplaintCategory()
        case 2:
            delegate.didTapWorkSheetCategory()
        case 3:
            delegate.didTapHistoryCategory()
        case 4:
            delegate.didTapDelayCorrectiveCategory()
        case 5:
            delegate.didTapLogBookCategory()
        case 6:
            delegate.didTapPreventiveCalendarCategory()
        default: break
        }
    }
    
}
