//
//  LoadPreventiveCVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 29/05/24.
//

import UIKit
import SkeletonView

class LoadPreventiveCVC: UICollectionViewCell {
    
    static let identifier = String(describing: LoadPreventiveCVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var initialStatusViewWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addShadow(4, position: .bottom, opacity: 0.2)
        self.containerView.addShadow(4, position: .bottom, opacity: 0.2)
        self.containerView.makeCornerRadius(8)
        self.statusView.makeCornerRadius(4)
        self.isSkeletonable = true
        self.showAnimatedGradientSkeleton()
    }
    
}

extension LoadPreventiveCVC {
    
    func setupCell(data: LoadPreventiveList?) {
        guard let data else { return }
        self.hideSkeleton()
        serialNumberLabel.text = data.lkNumber ?? "-"
        dateLabel.text = data.dateText ?? "-"
        configureStatus(label: data.lkLabel ?? "")
    }
    
    func configureStatus(label: String) {
        if label.hasPrefix("Perencanaan") {
            configurePlanningStatus()
        } else if label.hasPrefix("Penjadwalan") {
            configureSchedulingStatus()
        }
    }
    
    private func configurePlanningStatus() {
        statusLabel.text = LoadPreventiveStatus.planning.getStringValue()
        statusView.backgroundColor = UIColor.customSecondaryColor
        statusLabel.textColor = UIColor.customPrimaryColor
        initialStatusViewWidthConstraint.constant = 92
    }
    
    private func configureSchedulingStatus() {
        statusLabel.text = LoadPreventiveStatus.scheduling.getStringValue()
        statusView.backgroundColor = UIColor.customIndicatorColor2
        statusLabel.textColor = UIColor.customIndicatorColor11
        initialStatusViewWidthConstraint.constant = 86
    }
    
}
