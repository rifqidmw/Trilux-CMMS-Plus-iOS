//
//  CorrectiveCVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/04/24.
//

import UIKit
import SkeletonView

class CorrectiveCVC: UICollectionViewCell {
    
    static let identifier = String(describing: CorrectiveCVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var correctiveImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var containerDetailInformationView: UIView!
    @IBOutlet weak var containerTechnicianView: UIView!
    @IBOutlet weak var technicianTitleLabel: UILabel!
    @IBOutlet weak var technicianLabel: UILabel!
    @IBOutlet weak var containerDamageView: UIView!
    @IBOutlet weak var damageTitleLabel: UILabel!
    @IBOutlet weak var damageLabel: UILabel!
    @IBOutlet weak var containerStatusView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var actionButton: GeneralButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.correctiveImageView.makeCornerRadius(18)
        self.containerView.makeCornerRadius(8)
        self.containerView.addShadow(6, opacity: 0.2)
        self.actionButton.configure(title: "Korektif Lanjutan", type: .withIcon, icon: "ic_screwdriver_white", backgroundColor: UIColor.customIndicatorColor2, titleColor: UIColor.customIndicatorColor11)
        self.actionButton.makeCornerRadius(8)
        self.statusView.makeCornerRadius(4)
        self.showSkeletonAnimation()
    }
    
}

extension CorrectiveCVC {
    
    func setupCell(data: ComplaintListEntity) {
        hideSkeletonAnimation()
        correctiveImageView.loadImageUrl(data.image)
        dateLabel.text = "\(data.date) • \(data.type)"
        titleLabel.text = data.type
        descriptionLabel.text = data.description
        technicianLabel.text = data.technician
        damageLabel.text = data.damage
        configureStatus(status: data.status)
        actionButton.isHidden = data.status == .delay ? false : true
    }
    
    private func configureStatus(status: CorrectiveStatusType) {
        statusLabel.text = status.getStringValue().capitalized
        
        switch status {
        case .open:
            statusView.backgroundColor = UIColor.customLightGreenColor
            statusLabel.textColor = UIColor.customIndicatorColor8
        case .closed:
            statusView.backgroundColor = UIColor.customSecondaryColor
            statusLabel.textColor = UIColor.customPrimaryColor
        case .progress:
            statusView.backgroundColor = UIColor.customIndicatorColor2
            statusLabel.textColor = UIColor.customIndicatorColor11
        case .delay:
            statusView.backgroundColor = UIColor.customIndicatorColor2
            statusLabel.textColor = UIColor.customIndicatorColor11
        default: break
        }
    }
    
    private func showSkeletonAnimation() {
        [correctiveImageView,
         dateLabel,
         titleLabel,
         descriptionLabel,
         containerTechnicianView,
         containerDamageView,
         containerStatusView,
         statusLabel,
         actionButton].forEach {
            $0.isSkeletonable = true
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideSkeletonAnimation() {
        [correctiveImageView,
         dateLabel,
         titleLabel,
         descriptionLabel,
         containerTechnicianView,
         containerDamageView,
         containerStatusView,
         statusLabel,
         actionButton].forEach {
            $0.hideSkeleton()
        }
    }
    
}
