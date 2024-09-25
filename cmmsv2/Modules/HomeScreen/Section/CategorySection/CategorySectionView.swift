//
//  CategorySectionView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/01/24.
//

import UIKit

class CategorySectionView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var data: [CategoryModel] = []
    weak var delegate: HomeScreenCategoryDelegate?
    let userRole = RoleManager.shared.currentUserRole
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        let view = loadNib()
        view.frame = self.bounds
        self.addSubview(view)
        setupCollectionView()
    }
    
    func updateDataForRole() {
        switch RoleManager.shared.currentUserRole {
        case .engineer:
            data = categoryDataEngineer
        case .ipsrs:
            data = categoryDataIPSRS
        case .room:
            data = categoryDataRoom
        default:
            data = []
        }
        collectionView.reloadData()
    }
    
}

extension CategorySectionView {
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCardCVC.nib, forCellWithReuseIdentifier: CategoryCardCVC.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.itemSize = CGSize(width: 72, height: 128)
        collectionView.collectionViewLayout = layout
    }
    
}

extension CategorySectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCardCVC.identifier, for: indexPath) as? CategoryCardCVC else {
            return UICollectionViewCell()
        }
        cell.setupCell(data: data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = delegate else { return }
        let selectedItem = self.data[indexPath.row]
        
        switch selectedItem.title {
        case .all:
            delegate.didTapAllCategory()
        case .asset:
            delegate.didTapAssetCategory()
        case .complaint:
            delegate.didTapComplaintCategory()
        case .workSheet:
            delegate.didTapWorkSheetCategory()
        case .history:
            delegate.didTapHistoryCategory()
        case .delayCorrective:
            delegate.didTapDelayCorrectiveCategory()
        case .logBook:
            delegate.didTapLogBookCategory()
        case .preventiveCalendar:
            delegate.didTapPreventiveCalendarCategory()
        case .maintenance:
            delegate.didTapMaintenanceCategory()
        case .workSheetApproval:
            delegate.didTapWorkSheetApprovalCategory()
        case .complaintHistory:
            delegate.didTapComplaintHistoryCategory()
        case .monitoringFunction:
            delegate.didTapMonitoringFunctionCategory()
        case .preventive:
            delegate.didTapPreventiveCategory()
        case .assetInfo:
            delegate.didTapAssetInfoCategory()
        case .printRoom:
            delegate.didTapPrintRoomCategory()
        case .maintenanceInfo:
            delegate.didTapMaintenanceInfoCategory()
        case .mutationInfo:
            delegate.didTapMutationInfoCategory()
        case .calibration:
            delegate.didTapCalibrationCategory()
        case .mutating:
            delegate.didTapMutatingCategory()
        case .historyComplaintList:
            delegate.didTapHistoryComplaintListCategory()
        case .roomRequirement:
            delegate.didTapRoomRequirementCategory()
        case .assetSuggest:
            delegate.didTapAssetSuggestCategory()
        case .rating:
            delegate.didTapRatingCategory()
        case .none:
            break
        }
    }
    
}
