//
//  SortingHistoryBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 21/07/24.
//

import UIKit
import Combine

enum SortingBottomSheetType {
    case plain
    case category
}

protocol SortingBottomSheetDelegate: AnyObject {
    func didTapApplySort(_ sort: SortingEntity, type: SortingBottomSheetType)
}

@objc protocol SortingBottomSheetDelegateOptional: AnyObject {
    @objc optional func didTapAllButton()
}

class SortingBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var allCategoryButton: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var applyButton: GeneralButton!
    @IBOutlet weak var initialHeightBottomSheet: NSLayoutConstraint!
    
    weak var delegate: SortingBottomSheetDelegate?
    weak var optionalDelegate: SortingBottomSheetDelegateOptional?
    var type: SortingBottomSheetType? = .plain
    var selectedSortItem: SortingEntity?
    var selectedIndex: IndexPath?
    var data: [SortingEntity] = []
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
    }
    
}

extension SortingBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
        initialHeightBottomSheet.constant = 200 + self.calculateCollectionView(self.data)
    }
    
    private func setupView() {
        applyButton.makeCornerRadius(8)
        applyButton.configure(title: "Terapkan")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(StatusFilterCell.nib, forCellWithReuseIdentifier: StatusFilterCell.identifier)
        collectionView.isScrollEnabled = false
        
        let layout = LeftAlignedCollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        
        switch self.type {
        case .plain:
            if !data.isEmpty {
                selectedIndex = IndexPath(row: 0, section: 0)
                selectedSortItem = data[0]
            }
        case .category:
            allCategoryButton.isHidden = false
            titleLabel.text = "Kategori"
        default: break
        }
    }
    
    private func setupAction() {
        applyButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate = self.delegate,
                      let selectedSortItem,
                      let type
                else { return }
                self.dismissBottomSheet() {
                    delegate.didTapApplySort(selectedSortItem, type: type)
                }
            }
            .store(in: &anyCancellable)
        
        allCategoryButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate = self.optionalDelegate
                else { return }
                self.dismissBottomSheet() {
                    delegate.didTapAllButton?()
                }
            }
            .store(in: &anyCancellable)
        
        Publishers.Merge(
            bottomSheetView.handleBarArea.gesture(),
            dismissAreaView.gesture())
        .sink { [weak self] _ in
            guard let self else { return }
            self.dismissBottomSheet()
        }
        .store(in: &anyCancellable)
    }
    
    private func calculateCollectionView(_ data: [SortingEntity]) -> CGFloat {
        let initialHeight: CGFloat = 30
        let totalHeight = (CGFloat(data.count) * initialHeight) / 2
        return totalHeight
    }
    
}

extension SortingBottomSheet: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatusFilterCell.identifier, for: indexPath) as? StatusFilterCell
        else {
            return UICollectionViewCell()
        }
        
        let sortEntity = data[indexPath.row]
        let isSelected = indexPath == selectedIndex
        cell.configure(title: sortEntity.sortType?.getStringValue() ?? "", isSelected: isSelected)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedIndex = selectedIndex {
            collectionView.deselectItem(at: selectedIndex, animated: true)
            let previousCell = collectionView.cellForItem(at: selectedIndex) as? StatusFilterCell
            previousCell?.configure(title: data[selectedIndex.row].sortType?.getStringValue() ?? "", isSelected: false)
        }
        
        selectedIndex = indexPath
        selectedSortItem = data[indexPath.row]
        
        let cell = collectionView.cellForItem(at: indexPath) as? StatusFilterCell
        cell?.configure(title: data[indexPath.row].sortType?.getStringValue() ?? "", isSelected: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = self.data[indexPath.row].sortType?.getStringValue()
        let width = UILabel().textWidth(
            font: UIFont.robotoRegular(12),
            text: text ?? "")
        return CGSize(width: width + 32, height: 30)
    }
    
}
