//
//  WorkSheetItemCVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 19/04/24.
//

import UIKit
import SkeletonView

enum WorkSheetCellType {
    case monitoring
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
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var containerSerialApprovedStackView: UIStackView!
    @IBOutlet weak var firstBadgeView: UIView!
    @IBOutlet weak var firstBadgeLabel: UILabel!
    @IBOutlet weak var badgeView: UIStackView!
    @IBOutlet weak var secondBadgeView: UIView!
    @IBOutlet weak var secondBadgeIconImageView: UIImageView!
    @IBOutlet weak var secondBadgeTitleLabel: UILabel!
    @IBOutlet weak var thirdBadgeView: UIView!
    @IBOutlet weak var thirdBadgeTitleLabel: UILabel!
    @IBOutlet weak var thirdBadgeViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerDescriptionStackView: UIStackView!
    @IBOutlet weak var workSheetLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var markView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.firstBadgeView.makeCornerRadius(4)
        self.secondBadgeView.makeCornerRadius(4)
        self.thirdBadgeView.makeCornerRadius(4)
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
        configureStatus(status: data.status ?? .none)
        configureCategory(category: data.category ?? .none)
        dateLabel.text = data.dateTime
        
        switch type {
        case .monitoring:
            secondBadgeView.isHidden = true
            markView.isHidden = true
            descriptionLabel.text = "\(data.serial ?? "") - \(data.installation ?? "") - \(data.room ?? "")"
            descriptionLabel.isHidden = false
            firstBadgeView.isHidden = data.status == .done ? false : true
        case .preventive:
            badgeView.isHidden = true
            markView.isHidden = true
            setupPreventiveConstraint()
        case .corrective:
            dateLabel.isHidden = false
            descriptionLabel.text = data.room
            descriptionLabel.isHidden = false
            secondBadgeView.isHidden = data.category == WorkSheetCategory.none ? true : false
            firstBadgeLabel.text = "Lembar Kerja Disetujui"
        }
    }
    
    private func configureCategory(category: WorkSheetCategory) {
        secondBadgeTitleLabel.text = category.getStringValue()
        
        switch category {
        case .calibration:
            secondBadgeView.backgroundColor = UIColor.customSecondaryColor
            secondBadgeIconImageView.image = UIImage(named: "ic_wifi")
            secondBadgeTitleLabel.textColor = UIColor.customPrimaryColor
        case .corrective:
            secondBadgeView.backgroundColor = UIColor.customIndicatorColor3
            secondBadgeIconImageView.image = UIImage(named: "ic_screwdriver")
            secondBadgeTitleLabel.textColor = UIColor.customIndicatorColor4
        case .preventive:
            secondBadgeView.backgroundColor = UIColor.customIndicatorColor2
            secondBadgeIconImageView.image = UIImage(named: "ic_clock")
            secondBadgeTitleLabel.textColor = UIColor.customIndicatorColor11
        default: break
        }
    }
    
    private func configureStatus(status: WorkSheetStatus) {
        thirdBadgeTitleLabel.text = status.getStringValue()
        
        switch status {
        case .done:
            thirdBadgeView.backgroundColor = UIColor.customLightGreenColor
            thirdBadgeTitleLabel.textColor = UIColor.customIndicatorColor8
            thirdBadgeViewWidthConstraint.constant = 160
        case .open:
            thirdBadgeView.backgroundColor = UIColor.customSecondaryColor
            thirdBadgeTitleLabel.textColor = UIColor.customPrimaryColor
            thirdBadgeViewWidthConstraint.constant = 46
        case .ongoing:
            thirdBadgeView.backgroundColor = UIColor.customIndicatorColor2
            thirdBadgeTitleLabel.textColor = UIColor.customIndicatorColor11
            thirdBadgeViewWidthConstraint.constant = 130
        case .hold:
            thirdBadgeView.backgroundColor = UIColor.customIndicatorColor3
            thirdBadgeTitleLabel.textColor = UIColor.customIndicatorColor4
            thirdBadgeViewWidthConstraint.constant = 100
        case .close:
            thirdBadgeView.backgroundColor = UIColor.customLightGreenColor
            thirdBadgeTitleLabel.textColor = UIColor.customIndicatorColor8
            thirdBadgeViewWidthConstraint.constant = 46
        case .removed:
            thirdBadgeView.backgroundColor = UIColor.customIndicatorColor3
            thirdBadgeTitleLabel.textColor = UIColor.customIndicatorColor4
            thirdBadgeViewWidthConstraint.constant = 220
        case .progressDelay:
            thirdBadgeView.backgroundColor = UIColor.customIndicatorColor2
            thirdBadgeTitleLabel.textColor = UIColor.customIndicatorColor11
            thirdBadgeViewWidthConstraint.constant = 100
        case .progress:
            thirdBadgeView.backgroundColor = UIColor.customIndicatorColor2
            thirdBadgeTitleLabel.textColor = UIColor.customIndicatorColor11
            thirdBadgeViewWidthConstraint.constant = 80
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
        [containerDescriptionStackView, containerSerialApprovedStackView, badgeView].forEach {
            $0.isSkeletonable = true
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideSkeletonAnimation() {
        [containerDescriptionStackView, containerSerialApprovedStackView, badgeView].forEach {
            $0.hideSkeleton()
        }
    }
    
}

