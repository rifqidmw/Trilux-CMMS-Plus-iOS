//
//  ConditionFilterBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 26/07/24.
//

import UIKit
import Combine

protocol ConditionFilterBottomSheetDelegate: AnyObject {
    func didTapApplyFilterCondition(_ asset: AssetConditionEntity?, _ status: CalibrationConditionEntity?)
}

enum ConditionFilterBottomSheetType {
    case multiple
    case single
}

class ConditionFilterBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var titlePageLabel: UILabel!
    @IBOutlet weak var applyButton: GeneralButton!
    @IBOutlet weak var assetConditionStackView: UIStackView!
    @IBOutlet weak var assetConditionTitle: UILabel!
    @IBOutlet weak var assetCollectionView: UICollectionView!
    @IBOutlet weak var initialHeightAssetConditionConstraint: NSLayoutConstraint!
    @IBOutlet weak var statusCalibrationStackView: UIStackView!
    @IBOutlet weak var statusCalibrationTitle: UILabel!
    @IBOutlet weak var statusCalibrationCollectionView: UICollectionView!
    @IBOutlet weak var initialHeightStatusConditionConstraint: NSLayoutConstraint!
    
    weak var delegate: ConditionFilterBottomSheetDelegate?
    var type: ConditionFilterBottomSheetType? = .multiple
    var assetFilterData: [AssetConditionEntity] = []
    var selectedAssetFilter: AssetConditionEntity?
    var calibrationFilterData: [CalibrationConditionEntity] = []
    var selectedCalibrationStatusFilter: CalibrationConditionEntity?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
    }
    
}

extension ConditionFilterBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupCollectionView(assetCollectionView)
        setupCollectionView(statusCalibrationCollectionView)
        switch type {
        case .multiple:
            self.assetConditionTitle.text = "Kondisi Aset"
            self.assetConditionStackView.isHidden = false
            self.statusCalibrationTitle.text = "Kondisi Kalibrasi"
            self.initialHeightAssetConditionConstraint.constant = 130
            self.initialHeightStatusConditionConstraint.constant = 70
            self.statusCalibrationStackView.isHidden = false
        case .single:
            self.assetConditionTitle.isHidden = true
            self.assetConditionStackView.isHidden = false
            self.statusCalibrationStackView.isHidden = true
            self.initialHeightAssetConditionConstraint.constant = 80
            self.initialHeightStatusConditionConstraint.constant = 0
        default: break
        }
    }
    
    private func setupView() {
        applyButton.makeCornerRadius(8)
        applyButton.configure(title: "Terapkan")
    }
    
    private func setupCollectionView(_ collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(StatusFilterCell.nib, forCellWithReuseIdentifier: StatusFilterCell.identifier)
        collectionView.isScrollEnabled = false
        
        let layout = LeftAlignedCollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
    }
    
    private func setupAction() {
        applyButton.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                let delegate = self.delegate
                self.dismissBottomSheet() {
                    delegate?.didTapApplyFilterCondition(self.selectedAssetFilter, self.selectedCalibrationStatusFilter)
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

extension ConditionFilterBottomSheet: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case assetCollectionView:
            return self.assetFilterData.count
        case statusCalibrationCollectionView:
            return self.calibrationFilterData.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatusFilterCell.identifier, for: indexPath) as? StatusFilterCell else {
            return UICollectionViewCell()
        }
        
        switch collectionView {
        case assetCollectionView:
            let assetCondition = assetFilterData[indexPath.item]
            let isSelected = assetCondition.id == selectedAssetFilter?.id
            cell.configure(title: assetCondition.assetCondition?.getStringValue() ?? "", isSelected: isSelected)
        case statusCalibrationCollectionView:
            let calibrationCondition = calibrationFilterData[indexPath.item]
            let isSelected = calibrationCondition.id == selectedCalibrationStatusFilter?.id
            cell.configure(title: calibrationCondition.calibrationCondition?.getStringValue() ?? "", isSelected: isSelected)
        default:
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case assetCollectionView:
            selectedAssetFilter = assetFilterData[indexPath.item]
        case statusCalibrationCollectionView:
            selectedCalibrationStatusFilter = calibrationFilterData[indexPath.item]
        default:
            break
        }
        
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title: String
        switch collectionView {
        case assetCollectionView:
            title = assetFilterData[indexPath.item].assetCondition?.getStringValue() ?? ""
        case statusCalibrationCollectionView:
            title = calibrationFilterData[indexPath.item].calibrationCondition?.getStringValue() ?? ""
        default:
            title = ""
        }
        
        let width = title.size(withAttributes: [NSAttributedString.Key.font : UIFont.robotoRegular(12)]).width + 24
        return CGSize(width: width, height: 40)
    }
    
}
