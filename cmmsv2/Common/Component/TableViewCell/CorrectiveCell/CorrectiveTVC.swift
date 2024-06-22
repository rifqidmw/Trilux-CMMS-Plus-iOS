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
    func didTapContinueCorrective(data: Complaint, title: CorrectiveTitleType)
}

class CorrectiveTVC: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var correctiveImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var technicianLabel: UILabel!
    @IBOutlet weak var damageLabel: UILabel!
    @IBOutlet weak var containerStatusView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusViewWidthConstraint: NSLayoutConstraint!
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
    
    func setupCell(data: Complaint, delegate: CorrectiveCellDelegate, complaint: Complaint) {
        hideSkeletonAnimation()
        correctiveImageView.loadImageUrl(data.valEquipmentImg ?? "")
        dateLabel.text = "\(data.txtComplainTime ?? "") • \(data.txtRuangan ?? "")"
        titleLabel.text = data.valEquipmentName ?? ""
        descriptionLabel.text = data.txtSenderName ?? ""
        
        let titleTechnician = NSAttributedString.stylizedText("Teknisi: ", font: UIFont.robotoBold(10), color: UIColor.customPlaceholderColor)
        let techLabel = NSAttributedString.stylizedText(data.txtEngineerName ?? "-", font: UIFont.robotoBold(10), color: UIColor.customDarkGrayColor)
        
        let fullTechnicianLabel = NSMutableAttributedString()
        fullTechnicianLabel.append(titleTechnician)
        fullTechnicianLabel.append(techLabel)
        
        self.technicianLabel.attributedText = fullTechnicianLabel
        
        let titleDamage = NSAttributedString.stylizedText("Kerusakan: ", font: UIFont.robotoBold(10), color: UIColor.customPlaceholderColor)
        let damagedLabel = NSAttributedString.stylizedText(data.txtTitle ?? "-", font: UIFont.robotoBold(10), color: UIColor.customDarkGrayColor)
        
        let fullDamagedLabel = NSMutableAttributedString()
        fullDamagedLabel.append(titleDamage)
        fullDamagedLabel.append(damagedLabel)
        
        self.damageLabel.attributedText = fullDamagedLabel
        
        configureStatus(status: CorrectiveStatusType(rawValue: ((data.txtStatus ?? .none) ?? "")) ?? .none)
        configureActionButton(data: data)
        
        actionButton.gesture()
            .sink { _ in
                delegate.didTapContinueCorrective(data: complaint, title: CorrectiveTitleType(rawValue: self.actionButton.titleLabel.text ?? "") ?? .none)
            }
            .store(in: &anyCancellable)
        
        
    }
    
    private func configureActionButton(data: Complaint) {
        actionButton.isHidden = true
        
        if data.canPendamping == "1" {
            actionButton.isHidden = false
            actionButton.configure(title: "Pendamping", type: .withIcon, icon: "ic_screwdriver_white")
        }
        
        if let userLocal = UserDefaults.standard.string(forKey: "valPosition") {
            switch userLocal {
            case "1":
                if data.canDeleteLk == true {
                    actionButton.isHidden = false
                    actionButton.configure(title: "Delete Delegasi", type: .withIcon, icon: "ic_screwdriver_white", backgroundColor: UIColor.customIndicatorColor3, titleColor: UIColor.customIndicatorColor4)
                }
            case "2":
                actionButton.isHidden = false
                actionButton.configure(title: "Terima", type: .withIcon, icon: "ic_screwdriver_white")
            default:
                break
            }
        }
        
        if data.valStatus == "0" {
            if let localUser = UserDefaults.standard.string(forKey: "valPosition") {
                if localUser == "2" {
                    actionButton.isHidden = false
                    actionButton.configure(title: "Terima", type: .withIcon, icon: "ic_screwdriver_white")
                } else {
                    actionButton.isHidden = false
                    actionButton.configure(title: "Korektif", type: .withIcon, icon: "ic_screwdriver_white", backgroundColor: UIColor.customIndicatorColor2, titleColor: UIColor.customIndicatorColor11)
                }
            }
        }
        
        if data.valDelegatable == false {
            actionButton.isHidden = true
        }
        
        if data.isDelay == "1" {
            actionButton.isHidden = false
            actionButton.configure(title: "Korektif Lanjutan", type: .withIcon, icon: "ic_screwdriver_white", backgroundColor: UIColor.customIndicatorColor2, titleColor: UIColor.customIndicatorColor11)
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
        case .progress:
            statusView.backgroundColor = UIColor.customIndicatorColor2
            statusLabel.textColor = UIColor.customIndicatorColor11
            statusViewWidthConstraint.constant = 56
        case .delay:
            statusView.backgroundColor = UIColor.customIndicatorColor2
            statusLabel.textColor = UIColor.customIndicatorColor11
            statusViewWidthConstraint.constant = 54
        default: break
        }
    }
    
    private func showSkeletonAnimation() {
        [self.correctiveImageView,
         self.dateLabel,
         self.titleLabel,
         self.descriptionLabel,
         self.statusView,
         self.technicianLabel,
         self.damageLabel,
         self.actionButton].forEach {
            $0.isSkeletonable = true
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideSkeletonAnimation() {
        [self.correctiveImageView,
         self.dateLabel,
         self.titleLabel,
         self.descriptionLabel,
         self.statusView,
         self.technicianLabel,
         self.damageLabel,
         self.actionButton].forEach {
            $0.hideSkeleton()
        }
    }
}
