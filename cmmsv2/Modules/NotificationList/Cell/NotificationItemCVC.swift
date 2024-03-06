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
        self.containerView.makeCornerRadius(8)
        self.addShadow(6, opacity: 0.2)
        self.markView.makeCornerRadius(4, .rightCurve)
        self.badgeView.makeCornerRadius(4)
        self.setupSkeleton()
    }
    
}

extension NotificationItemCVC {
    
    private func setupSkeleton() {
        [markView,
         badgeView,
         dateTimeLabel,
         shortTitleLabel,
         titleLabel].forEach {
            $0.isSkeletonable = true
            $0.showGradientSkeleton()
        }
    }
    
    private func hideSkeletonAnimation() {
        [markView,
         badgeView,
         dateTimeLabel,
         shortTitleLabel,
         titleLabel].forEach {
            $0.hideSkeleton()
        }
    }
    
    func setupCell(data: NotificationList) {
        hideSkeletonAnimation()
        configureBadgeView(type: data.type ?? "")
        dateTimeLabel.text = data.time ?? ""
        shortTitleLabel.text = data.short_title
        titleLabel.text = data.title
    }
    
    
    private func configureBadgeView(type: String) {
        switch type {
        case "1":
            badgeView.backgroundColor = UIColor.customIndicatorColor2
            markView.backgroundColor = UIColor.customIndicatorColor2
            badgeLabel.textColor = UIColor.customIndicatorColor11
            badgeLabel.text = NotificationType.complaint.getStringValue()
        case "2":
            badgeView.backgroundColor = UIColor.customSecondaryColor
            markView.backgroundColor = UIColor.customSecondaryColor
            badgeLabel.textColor = UIColor.customPrimaryColor
            badgeLabel.text = NotificationType.worksheet.getStringValue()
        case "3":
            badgeView.backgroundColor = UIColor.customIndicatorColor2
            markView.backgroundColor = UIColor.customIndicatorColor2
            badgeLabel.textColor = UIColor.customIndicatorColor11
            badgeLabel.text = NotificationType.rating.getStringValue()
        case "4":
            badgeView.backgroundColor = UIColor.customLightGreenColor
            markView.backgroundColor = UIColor.customLightGreenColor
            badgeLabel.textColor = UIColor.customIndicatorColor10
            badgeLabel.text = NotificationType.approveWorkSheet.getStringValue()
        case "5":
            badgeView.backgroundColor = UIColor.customIndicatorColor2
            markView.backgroundColor = UIColor.customIndicatorColor2
            badgeLabel.textColor = UIColor.customIndicatorColor11
            badgeLabel.text = NotificationType.inbox.getStringValue()
        case "6":
            badgeView.backgroundColor = UIColor.customSecondaryColor
            markView.backgroundColor = UIColor.customSecondaryColor
            badgeLabel.textColor = UIColor.customPrimaryColor
            badgeLabel.text = NotificationType.inbox.getStringValue()
        case "7":
            badgeView.backgroundColor = UIColor.customLightGreenColor
            markView.backgroundColor = UIColor.customLightGreenColor
            badgeLabel.textColor = UIColor.customIndicatorColor10
            badgeLabel.text = NotificationType.mutation.getStringValue()
        default: break
        }
    }
}
