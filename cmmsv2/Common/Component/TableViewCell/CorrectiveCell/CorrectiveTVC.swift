//
//  CorrectiveTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 12/06/24.
//

import UIKit
import SkeletonView
import Combine

protocol CorrectiveCellDelegate: AnyObject {
    func didTapContinueCorrective(index: Int)
}

class CorrectiveTVC: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var correctiveImageView: UIImageView!
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
    @IBOutlet weak var statusViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var actionButton: GeneralButton!
    
    var anyCancellable = Set<AnyCancellable>()
    static let identifier = String(describing: CorrectiveTVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.correctiveImageView.makeCornerRadius(18)
        self.containerView.makeCornerRadius(8)
        self.containerView.addShadow(6, opacity: 0.2)
        self.actionButton.makeCornerRadius(8)
        self.statusView.makeCornerRadius(4)
        self.showSkeletonAnimation()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension CorrectiveTVC {
    
    func setupCell(data: ComplaintListEntity, delegate: CorrectiveCellDelegate, indexPath: Int) {
        hideSkeletonAnimation()
        correctiveImageView.loadImageUrl(data.image ?? "")
        dateLabel.text = "\(data.date ?? "") • \(data.type ?? "")"
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        technicianLabel.text = data.technician
        damageLabel.text = data.damage
        configureStatus(status: data.status ?? .none)
        configureActionButton(status: data.status ?? .none)
        actionButton.gesture()
            .sink { _ in
                delegate.didTapContinueCorrective(index: indexPath)
            }
            .store(in: &anyCancellable)
    }
    
    private func configureActionButton(status: CorrectiveStatusType) {
        self.actionButton.isHidden = false
        
        switch status {
        case .open:
            self.actionButton.configure(title: "Terima", type: .withIcon, icon: "ic_screwdriver_white", backgroundColor: UIColor.customPrimaryColor, titleColor: UIColor.white)
        case .closed:
            self.actionButton.isHidden = true
        case .progress:
            self.actionButton.isHidden = true
        case .delay:
            self.actionButton.configure(title: "Korektif Lanjutan", type: .withIcon, icon: "ic_screwdriver_white", backgroundColor: UIColor.customIndicatorColor2, titleColor: UIColor.customIndicatorColor11)
        default: break
        }
    }
    
    private func configureStatus(status: CorrectiveStatusType) {
        self.statusLabel.text = status.getStringValue().capitalized
        
        switch status {
        case .open:
            statusView.backgroundColor = UIColor.customLightGreenColor
            statusLabel.textColor = UIColor.customIndicatorColor8
            statusViewWidthConstraint.constant = 50
        case .closed:
            statusView.backgroundColor = UIColor.customSecondaryColor
            statusLabel.textColor = UIColor.customPrimaryColor
            statusViewWidthConstraint.constant = 52
        case .delay:
            statusView.backgroundColor = UIColor.customIndicatorColor2
            statusLabel.textColor = UIColor.customIndicatorColor11
            statusViewWidthConstraint.constant = 54
        case .progress:
            statusView.backgroundColor = UIColor.customIndicatorColor2
            statusLabel.textColor = UIColor.customIndicatorColor11
            statusViewWidthConstraint.constant = 56
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
