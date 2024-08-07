//
//  NotificationItemCVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 18/02/24.
//

import UIKit
import SkeletonView

class NotificationItemCVC: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var markView: UIView!
    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var badgeLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var shortTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = String(describing: NotificationItemCVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupSkeleton()
        self.containerView.makeCornerRadius(8)
        self.addShadow(2, position: .bottom, opacity: 0.2)
        self.markView.makeCornerRadius(4, .rightCurve)
        self.badgeView.makeCornerRadius(4)
    }
    
}

extension NotificationItemCVC {
    
    private func setupSkeleton() {
        [self.markView,
         self.badgeView,
         self.dateTimeLabel,
         self.shortTitleLabel,
         self.titleLabel].forEach {
            $0.isSkeletonable = true
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideSkeletonAnimation() {
        [self.markView,
         self.badgeView,
         self.dateTimeLabel,
         self.shortTitleLabel,
         self.titleLabel].forEach {
            $0.hideSkeleton()
        }
    }
    
    func setupCell(data: NotificationList) {
        hideSkeletonAnimation()
        configureBadgeView(type: NotificationType(rawValue: data.type_string?.rawValue ?? "") ?? NotificationType.none)
        dateTimeLabel.text = data.time ?? ""
        shortTitleLabel.text = data.short_title
        titleLabel.text = data.title
    }
    
    private func configureBadgeView(type: NotificationType) {
        badgeLabel.text = type.getStringValue()
        
        switch type {
        case .complaint:
            badgeView.backgroundColor = UIColor.customIndicatorColor3
            markView.backgroundColor = UIColor.customIndicatorColor3
            badgeLabel.textColor = UIColor.customRedColor
        case .worksheet:
            badgeView.backgroundColor = UIColor.customSecondaryColor
            markView.backgroundColor = UIColor.customSecondaryColor
            badgeLabel.textColor = UIColor.customPrimaryColor
        case .rating:
            badgeView.backgroundColor = UIColor.customIndicatorColor2
            markView.backgroundColor = UIColor.customIndicatorColor2
            badgeLabel.textColor = UIColor.customIndicatorColor11
        case .approveWorkSheet:
            badgeView.backgroundColor = UIColor.customLightGreenColor
            markView.backgroundColor = UIColor.customLightGreenColor
            badgeLabel.textColor = UIColor.customIndicatorColor10
        case .inbox:
            badgeView.backgroundColor = UIColor.customIndicatorColor2
            markView.backgroundColor = UIColor.customIndicatorColor2
            badgeLabel.textColor = UIColor.customIndicatorColor11
        case .reception:
            badgeView.backgroundColor = UIColor.customSecondaryColor
            markView.backgroundColor = UIColor.customSecondaryColor
            badgeLabel.textColor = UIColor.customPrimaryColor
        case .mutation:
            badgeView.backgroundColor = UIColor.customLightGreenColor
            markView.backgroundColor = UIColor.customLightGreenColor
            badgeLabel.textColor = UIColor.customIndicatorColor10
        case .approveLk:
            badgeView.backgroundColor = UIColor.customLightGreenColor
            markView.backgroundColor = UIColor.customLightGreenColor
            badgeLabel.textColor = UIColor.customIndicatorColor10
        case .acceptanceAsset:
            badgeView.backgroundColor = UIColor.customSecondaryColor
            markView.backgroundColor = UIColor.customSecondaryColor
            badgeLabel.textColor = UIColor.customPrimaryColor
        case .none:
            break
        }
    }
    
}
