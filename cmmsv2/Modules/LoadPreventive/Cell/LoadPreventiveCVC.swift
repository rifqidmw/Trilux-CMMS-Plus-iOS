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
        self.addShadow(0.4)
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
        if data.lkFinishstt != "0" {
            self.statusView.isHidden = true
        }
    }
    
}
