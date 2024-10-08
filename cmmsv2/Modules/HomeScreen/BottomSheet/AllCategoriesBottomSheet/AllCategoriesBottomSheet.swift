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
    var data: [CategoryModel] = []
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
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
            self.dismissBottomSheet()
        }
        .store(in: &anyCancellable)
    }
    
    func updateDataForRole() {
        switch RoleManager.shared.currentUserRole {
        case .engineer:
            data = categoryBottomSheetEngineerData
        case .ipsrs:
            data = categoryBottomSheetIPSRSData
        case .room:
            data = categoryBottomSheetRoomData
        default:
            data = []
        }
    }
    
    private func calculateTotalHeight() {
        let cellHeight: CGFloat = 120
        let numberOfColumns: CGFloat = 2
        let numberOfRows = ceil(CGFloat(self.data.count) / numberOfColumns)
        let totalHeight = numberOfRows * cellHeight
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
        let selectedItem = self.data[indexPath.row]
        
        switch selectedItem.title {
        case .all:
            break
        case .asset:
            self.dismissBottomSheet() {
                delegate.didTapAssetCategory()
            }
        case .complaint:
            self.dismissBottomSheet() {
                delegate.didTapComplaintCategory()
            }
        case .workSheet:
            self.dismissBottomSheet() {
                delegate.didTapWorkSheetCategory()
            }
        case .history:
            self.dismissBottomSheet() {
                delegate.didTapHistoryCategory()
            }
        case .delayCorrective:
            self.dismissBottomSheet() {
                delegate.didTapDelayCorrectiveCategory()
            }
        case .logBook:
            self.dismissBottomSheet() {
                delegate.didTapLogBookCategory()
            }
        case .preventiveCalendar:
            self.dismissBottomSheet() {
                delegate.didTapPreventiveCalendarCategory()
            }
        case .maintenance:
            self.dismissBottomSheet() {
                delegate.didTapMaintenanceCategory()
            }
        case .workSheetApproval:
            self.dismissBottomSheet() {
                delegate.didTapWorkSheetApprovalCategory()
            }
        case .complaintHistory:
            self.dismissBottomSheet() {
                delegate.didTapComplaintHistoryCategory()
            }
        case .monitoringFunction:
            self.dismissBottomSheet() {
                delegate.didTapMonitoringFunctionCategory()
            }
        case .preventive:
            self.dismissBottomSheet() {
                delegate.didTapPreventiveCategory()
            }
        case .assetInfo:
            self.dismissBottomSheet() {
                delegate.didTapAssetInfoCategory()
            }
        case .printRoom:
            self.dismissBottomSheet() {
                delegate.didTapPrintRoomCategory()
            }
        case .maintenanceInfo:
            self.dismissBottomSheet() {
                delegate.didTapMaintenanceInfoCategory()
            }
        case .mutationInfo:
            self.dismissBottomSheet() {
                delegate.didTapMutationInfoCategory()
            }
        case .calibration:
            self.dismissBottomSheet() {
                delegate.didTapCalibrationCategory()
            }
        case .mutating:
            self.dismissBottomSheet() {
                delegate.didTapMutatingCategory()
            }
        case .historyComplaintList:
            self.dismissBottomSheet() {
                delegate.didTapComplaintHistoryList()
            }
        case .roomRequirement:
            self.dismissBottomSheet() {
                delegate.didTapRoomRequirementCategory()
            }
        case .rating:
            self.dismissBottomSheet() {
                delegate.didTapRatingCategory()
            }
        case .none:
            break
        }
    }
    
}
