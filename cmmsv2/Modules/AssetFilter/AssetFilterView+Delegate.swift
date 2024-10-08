//
//  AssetFilterView+Delegate.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 28/07/24.
//

import UIKit

extension AssetFilterView: ActionBarViewDelegate {
    
    func didTapFirstAction() {
        guard let presenter, let navigation = self.navigationController else { return }
        presenter.showInstallationBottomSheet(from: navigation, self)
    }
    
    func didTapSecondAction() {
        guard let presenter, let navigation = self.navigationController else { return }
        presenter.showConditionFilterBottomSheet(from: navigation, self)
    }
    
    func didTapThirdAction() {
        guard let presenter, let navigation = self.navigationController else { return }
        presenter.showCategoryFilterBottomSheet(from: navigation, self, optionalDelegate: self)
    }
    
    func didTapFourthAction() {
        guard let presenter, let navigation = self.navigationController else { return }
        presenter.showSortBottomSheet(from: navigation, self)
    }
    
}

extension AssetFilterView: SortingBottomSheetDelegate, SortingBottomSheetDelegateOptional {
    
    func didTapApplySort(_ sort: SortingEntity, type: SortingBottomSheetType) {
        guard let presenter else { return }
        self.showLoadingPopup()
        switch type {
        case .plain:
            presenter.fetchInitData(sort: sort.sortType?.getStringValue().lowercased())
        case .category:
            presenter.fetchInitData(category: sort.sortType?.getStringValue().lowercased())
        }
        self.reloadCollectionViewWithAnimation(self.assetCollectionView)
    }
    
    func didTapAllButton() {
        guard let presenter else { return }
        self.showLoadingPopup()
        presenter.fetchInitData(category: "")
        self.reloadCollectionViewWithAnimation(self.assetCollectionView)
    }
    
}

extension AssetFilterView: InstallationBottomSheetDelegate {
    
    func didSelectInstallation(_ installation: InstallationData) {
        guard let presenter else { return }
        self.showLoadingPopup()
        presenter.fetchInitData(idInstallation: installation.id)
        self.reloadCollectionViewWithAnimation(self.assetCollectionView)
    }
    
}

extension AssetFilterView: ConditionFilterBottomSheetDelegate {
    
    func didTapApplyFilterCondition(_ asset: AssetConditionEntity?, _ status: CalibrationConditionEntity?) {
        guard let presenter else { return }
        let selectedAssetFilter = asset?.assetCondition?.getStringValue().lowercased()
            .replacingOccurrences(of: " ", with: "_")
        let selectedStatus = status?.calibrationCondition?.getStringValue().lowercased()
            .replacingOccurrences(of: " ", with: "_")
        self.showLoadingPopup()
        presenter.fetchInitData(condition: selectedAssetFilter, sttCalibration: selectedStatus)
        self.reloadCollectionViewWithAnimation(self.assetCollectionView)
    }
    
}
