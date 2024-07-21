//
//  HistoryListView+Delegate.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 21/07/24.
//

import UIKit

extension HistoryListView: ActionBarViewDelegate {
    
    func didTapFirstAction() {
        guard let presenter, let navigation = self.navigationController else { return }
        presenter.showHistorySortBottomSheet(from: navigation, self)
    }
    
}

extension HistoryListView: SortingHistoryBottomSheetDelegate {
    
    func didTapApplyHistorySort(_ sort: HistorySortEntity) {
        guard let presenter else { return }
        presenter.fetchInitData(hasObstacle: sort.hasObstacle)
        self.reloadCollectionViewWithAnimation(self.collectionView)
    }
    
}