//
//  CorrectiveTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 12/06/24.
//

import UIKit
import SkeletonView
import Combine

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
    @IBOutlet weak var secondActionButton: GeneralButton!
    
    @IBOutlet weak var containerRoomView: UIView!
    @IBOutlet weak var complaintImageView: UIImageView!
    @IBOutlet weak var complaintStatusView: UIView!
    @IBOutlet weak var complaintStatusLabel: UILabel!
    @IBOutlet weak var complaintStatusViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var complaintTitle: UILabel!
    @IBOutlet weak var chronologyLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var complaintDateLabel: UILabel!
    @IBOutlet weak var editingComplaintView: UIView!
    
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
        self.containerView.addShadow(4, position: .bottom, opacity: 0.2)
        self.actionButton.makeCornerRadius(8)
        self.secondActionButton.makeCornerRadius(8)
        self.statusView.makeCornerRadius(4)
        
        self.complaintImageView.makeCornerRadius(18)
        self.containerRoomView.makeCornerRadius(8)
        self.containerRoomView.addShadow(4, position: .bottom, opacity: 0.2)
        self.complaintStatusView.makeCornerRadius(4)
        self.editingComplaintView.makeCornerRadius(4)
        self.showSkeletonAnimation()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension CorrectiveTVC {
    
    func setupCell(data: Complaint, delegate: CorrectiveCellDelegate, complaint: Complaint, type: ComplaintType? = .engineer) {
        hideSkeletonAnimation()
        configureStatus(status: CorrectiveStatusType(rawValue: ((data.txtStatus ?? .none) ?? "")) ?? .none)
        switch type {
        case .engineer:
            containerView.isHidden = false
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
            configureActionButton(data: data)
        case .room:
            containerRoomView.isHidden = false
            complaintImageView.loadImageUrl(data.valEquipmentImg ?? "")
            roomLabel.text = data.txtRuangan ?? "-"
            complaintDateLabel.text = data.txtComplainTime ?? "-"
            complaintTitle.text = data.txtTitle ?? "-"
            chronologyLabel.text = data.txtDescriptions ?? "-"
            if let isDelegatable = data.valDelegatable {
                editingComplaintView.isHidden = !isDelegatable
            }
        default: break
        }
        
        actionButton.gesture()
            .sink { _ in
                delegate.didTapContinueCorrective(data: complaint, title: CorrectiveTitleType(rawValue: self.actionButton.titleLabel.text ?? "") ?? .none)
            }
            .store(in: &anyCancellable)
        
        secondActionButton.gesture()
            .sink { _ in
                delegate.didTapDeleteLk(data: complaint)
            }
            .store(in: &anyCancellable)
    }
    
    private func configureActionButton(data: Complaint) {
        actionButton.isHidden = true
        secondActionButton.isHidden = true
        let userRole = RoleManager.shared.currentUserRole
        
        switch userRole {
        case .ipsrs:
            if data.canDeleteLk == true {
                actionButton.isHidden = false
                actionButton.configure(title: "Hapus Delegasi LK", type: .withIcon, icon: "ic_screwdriver_white", backgroundColor: UIColor.customIndicatorColor3, titleColor: UIColor.customIndicatorColor4)
            }
        case .engineer:
            actionButton.isHidden = false
            actionButton.configure(title: "Terima", type: .withIcon, icon: "ic_screwdriver_white")
        default:
            break
        }
        
        if data.valStatus == "0" {
            switch userRole {
            case .engineer:
                actionButton.isHidden = false
                actionButton.configure(title: "Terima", type: .withIcon, icon: "ic_screwdriver_white")
            case .ipsrs:
                actionButton.isHidden = false
                actionButton.configure(title: "Korektif", type: .withIcon, icon: "ic_screwdriver_white", backgroundColor: UIColor.customPrimaryColor, titleColor: UIColor.customSecondaryColor)
            default: break
            }
        }
        
        if data.valDelegatable == false {
            actionButton.isHidden = true
        }
        
        if data.isDelay == "1" {
            actionButton.isHidden = false
            actionButton.configure(title: "Korektif Lanjutan", type: .withIcon, icon: "ic_screwdriver_white", backgroundColor: UIColor.customIndicatorColor2, titleColor: UIColor.customIndicatorColor11)
        }
        
        if data.canPendamping == "1" && data.canDeleteLk == true {
            actionButton.isHidden = false
            actionButton.configure(title: "Pendamping", type: .withIcon, icon: "ic_screwdriver_white", backgroundColor: UIColor.customPrimaryColor, titleColor: UIColor.customSecondaryColor)
            
            secondActionButton.isHidden = false
            secondActionButton.configure(title: "Hapus Delegasi LK", type: .withIcon, icon: "ic_trash_red", backgroundColor: UIColor.customIndicatorColor3, titleColor: UIColor.customIndicatorColor4)
        } else if data.canPendamping == "1"  {
            actionButton.isHidden = false
            actionButton.configure(title: "Pendamping", type: .withIcon, icon: "ic_screwdriver_white", backgroundColor: UIColor.customPrimaryColor, titleColor: UIColor.customSecondaryColor)
        }
    }
    
    private func configureStatus(status: CorrectiveStatusType) {
        self.statusLabel.text = status.getStringValue().capitalized
        self.complaintStatusLabel.text = status.getStringValue().capitalized
        
        switch status {
        case .open:
            statusView.backgroundColor = UIColor.customLightGreenColor
            statusLabel.textColor = UIColor.customIndicatorColor8
            statusViewWidthConstraint.constant = 50
            
            complaintStatusView.backgroundColor = UIColor.customLightGreenColor
            complaintStatusLabel.textColor = UIColor.customIndicatorColor8
            complaintStatusViewWidthConstraint.constant = 50
        case .closed:
            statusView.backgroundColor = UIColor.customSecondaryColor
            statusLabel.textColor = UIColor.customPrimaryColor
            statusViewWidthConstraint.constant = 52
            
            complaintStatusView.backgroundColor = UIColor.customSecondaryColor
            complaintStatusLabel.textColor = UIColor.customPrimaryColor
            complaintStatusViewWidthConstraint.constant = 52
        case .progress:
            statusView.backgroundColor = UIColor.customIndicatorColor2
            statusLabel.textColor = UIColor.customIndicatorColor11
            statusViewWidthConstraint.constant = 56
            
            complaintStatusView.backgroundColor = UIColor.customIndicatorColor2
            complaintStatusLabel.textColor = UIColor.customIndicatorColor11
            complaintStatusViewWidthConstraint.constant = 56
        case .delay:
            statusView.backgroundColor = UIColor.customIndicatorColor2
            statusLabel.textColor = UIColor.customIndicatorColor11
            statusViewWidthConstraint.constant = 54
            
            complaintStatusView.backgroundColor = UIColor.customIndicatorColor2
            complaintStatusLabel.textColor = UIColor.customIndicatorColor11
            complaintStatusViewWidthConstraint.constant = 54
        default: break
        }
    }
    
    private func showSkeletonAnimation() {
        let showSkeletonEngineerView = [self.correctiveImageView,
                                        self.complaintImageView,
                                        self.dateLabel,
                                        self.complaintDateLabel,
                                        self.titleLabel,
                                        self.complaintTitle]
        
        let showSkeletonRoomView = [self.descriptionLabel,
                                    self.chronologyLabel,
                                    self.statusView,
                                    self.complaintStatusView,
                                    self.technicianLabel,
                                    self.roomLabel,
                                    self.damageLabel,
                                    self.actionButton,
                                    self.secondActionButton]
        
        showSkeletonEngineerView.forEach {
            $0?.isSkeletonable = true
            $0?.showAnimatedGradientSkeleton()
        }
        
        showSkeletonRoomView.forEach {
            $0?.isSkeletonable = true
            $0?.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideSkeletonAnimation() {
        let hideSkeletonEngineerView = [self.correctiveImageView,
                                        self.complaintImageView,
                                        self.dateLabel,
                                        self.complaintDateLabel,
                                        self.titleLabel,
                                        self.complaintTitle]
        
        let hideSkeletonRoomView = [self.descriptionLabel,
                                    self.chronologyLabel,
                                    self.statusView,
                                    self.complaintStatusView,
                                    self.technicianLabel,
                                    self.roomLabel,
                                    self.damageLabel,
                                    self.actionButton,
                                    self.secondActionButton]
        
        hideSkeletonEngineerView.forEach {
            $0?.hideSkeleton()
        }
        
        hideSkeletonRoomView.forEach {
            $0?.hideSkeleton()
        }
    }
    
}
