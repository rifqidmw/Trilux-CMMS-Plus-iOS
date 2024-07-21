//
//  SortingHistoryBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 21/07/24.
//

import UIKit
import Combine

protocol SortingHistoryBottomSheetDelegate: AnyObject {
    func didTapApplyHistorySort(_ sort: HistorySortEntity)
}

class SortingHistoryBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var applyButton: GeneralButton!
    
    weak var delegate: SortingHistoryBottomSheetDelegate?
    var selectedSortItem: HistorySortEntity?
    var selectedIndex: IndexPath?
    let data: [HistorySortEntity] = [
        HistorySortEntity(id: 0, sortType: .all, hasObstacle: -1),
        HistorySortEntity(id: 1, sortType: .hold, hasObstacle: 1),
        HistorySortEntity(id: 2, sortType: .done, hasObstacle: 0)
    ]
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
    }
    
}

extension SortingHistoryBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        applyButton.makeCornerRadius(8)
        applyButton.configure(title: "Terapkan")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(StatusFilterCell.nib, forCellWithReuseIdentifier: StatusFilterCell.identifier)
        collectionView.isScrollEnabled = false
        
        if let defaultIndex = data.firstIndex(where: { $0.sortType == .all }) {
            selectedIndex = IndexPath(row: defaultIndex, section: 0)
            selectedSortItem = data[defaultIndex]
        }
    }
    
    private func setupAction() {
        applyButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate = self.delegate,
                      let selectedSortItem
                else { return }
                self.dismissBottomSheet() {
                    delegate.didTapApplyHistorySort(selectedSortItem)
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
    
}

extension SortingHistoryBottomSheet: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
        return CGSize(width: indexPath.row == 0 ? 130 : 200, height: 30)
    }
    
}
