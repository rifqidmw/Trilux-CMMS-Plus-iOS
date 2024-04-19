//
//  WorkSheetItemCVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 19/04/24.
//

import UIKit
import SkeletonView

enum WorkSheetCellType {
    case normal
    case preventive
    case corrective
}

class WorkSheetCVC: UICollectionViewCell {
    
    static let identifier = String(describing: WorkSheetCVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var uniqueNumberLabel: UILabel!
    @IBOutlet weak var containerSerialApprovedStackView: UIStackView!
    @IBOutlet weak var approvedView: UIView!
    @IBOutlet weak var badgeView: UIStackView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryIconImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var containerDescriptionStackView: UIStackView!
    @IBOutlet weak var workSheetLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var markView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.approvedView.makeCornerRadius(4)
        self.categoryView.makeCornerRadius(4)
        self.statusView.makeCornerRadius(4)
        self.markView.makeCornerRadius(4, .rightCurve)
        self.containerView.makeCornerRadius(8)
        self.containerView.addShadow(8, opacity: 0.12)
        self.showSkeletonAnimation()
    }
    
}

extension WorkSheetCVC {
    
    func setupCell(data: WorkSheetListEntity, type: WorkSheetCellType) {
        hideSkeletonAnimation()
        uniqueNumberLabel.text = data.uniqueNumber
        workSheetLabel.text = data.workName
        descriptionLabel.text = "\(data.serial ?? "") - \(data.installation ?? "") - \(data.room ?? "")"
        configureStatus(status: data.status ?? .none)
        configureCategory(category: data.category ?? .none)
        markView .isHidden = !(data.isApproved ?? false)
        
        switch type {
        case .normal:
            categoryView.isHidden = true
        case .preventive:
            badgeView.isHidden = true
            markView.isHidden = true
            setupPreventiveConstraint()
        case .corrective: break
        }
    }
    
    private func configureCategory(category: WorkSheetCategory) {
        categoryLabel.text = category.getStringValue()
        
        switch category {
        case .calibration:
            categoryView.backgroundColor = UIColor.customSecondaryColor
            categoryIconImageView.image = UIImage(named: "ic_wifi")
            categoryLabel.textColor = UIColor.customPrimaryColor
        case .corrective:
            categoryView.backgroundColor = UIColor.customIndicatorColor3
            categoryIconImageView.image = UIImage(named: "ic_screwdriver")
            categoryLabel.textColor = UIColor.customIndicatorColor4
        case .preventive:
            categoryView.backgroundColor = UIColor.customIndicatorColor2
            categoryIconImageView.image = UIImage(named: "ic_clock")
            categoryLabel.textColor = UIColor.customIndicatorColor11
        default: break
        }
    }
    
    private func configureStatus(status: WorkSheetStatus) {
        statusLabel.text = status.getStringValue()
        
        switch status {
        case .done:
            statusView.backgroundColor = UIColor.customLightGreenColor
            statusLabel.textColor = UIColor.customIndicatorColor8
            statusViewWidthConstraint.constant = 130
            approvedView.isHidden = false
        case .open:
            statusView.backgroundColor = UIColor.customSecondaryColor
            statusLabel.textColor = UIColor.customPrimaryColor
            statusViewWidthConstraint.constant = 34
            approvedView.isHidden = true
        case .ongoing:
            statusView.backgroundColor = UIColor.customIndicatorColor2
            statusLabel.textColor = UIColor.customIndicatorColor11
            statusViewWidthConstraint.constant = 110
            approvedView.isHidden = true
        default: break
        }
    }
    
    private func setupPreventiveConstraint() {
        NSLayoutConstraint.activate([
            containerDescriptionStackView.topAnchor.constraint(equalTo: uniqueNumberLabel.bottomAnchor, constant: 16),
            containerDescriptionStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
    
    private func showSkeletonAnimation() {
        [workSheetLabel, descriptionLabel, containerDescriptionStackView, containerSerialApprovedStackView, badgeView].forEach {
            $0.isSkeletonable = true
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideSkeletonAnimation() {
        [workSheetLabel, descriptionLabel, containerDescriptionStackView, containerSerialApprovedStackView, badgeView].forEach {
            $0.hideSkeleton()
        }
    }
    
}

