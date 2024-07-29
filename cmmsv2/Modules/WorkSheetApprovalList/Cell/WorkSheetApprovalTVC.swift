//
//  WorkSheetApprovalTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 30/07/24.
//

import UIKit
import SkeletonView

class WorkSheetApprovalTVC: UITableViewCell {
    
    static let identifier = String(describing: WorkSheetApprovalTVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var containerContentView: UIView!
    @IBOutlet weak var approvalImageView: UIImageView!
    @IBOutlet weak var lkNumberLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var assetNameLabel: UILabel!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var technicianLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.showAnimationSkeleton()
        self.containerContentView.makeCornerRadius(8)
        self.containerContentView.addShadow(2, position: .bottom, opacity: 0.2)
        self.approvalImageView.makeCornerRadius(8)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension WorkSheetApprovalTVC {
    
    private func showAnimationSkeleton() {
        [self.approvalImageView,
         self.lkNumberLabel,
         self.dateTimeLabel,
         self.assetNameLabel,
         self.serialNumberLabel,
         self.technicianLabel].forEach {
            $0.isSkeletonable = true
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideAnimationSkeleton() {
        [self.approvalImageView,
         self.lkNumberLabel,
         self.dateTimeLabel,
         self.assetNameLabel,
         self.serialNumberLabel,
         self.technicianLabel].forEach {
            $0.hideSkeleton()
        }
    }
    
}

extension WorkSheetApprovalTVC {
    
    func setupCell(data: WorkSheetApproval?) {
        self.hideAnimationSkeleton()
        self.lkNumberLabel.text = data?.valWoNumber ?? "-"
        self.dateTimeLabel.text = data?.valDelegatedTime ?? "-"
        self.assetNameLabel.text = data?.txtTitle ?? "-"
        self.approvalImageView.makeCornerRadius(8)
        self.approvalImageView.loadImageUrl(data?.valEngineerAvatar ?? "")
        
        let titleSerialNumber = NSAttributedString.stylizedText("Serial Number: ", font: UIFont.robotoBold(10), color: UIColor.customPlaceholderColor)
        let snLabel = NSAttributedString.stylizedText(data?.txtSubTitle ?? "-", font: UIFont.robotoBold(10), color: UIColor.customDarkGrayColor)
        
        let fullSerialNumberLabel = NSMutableAttributedString()
        fullSerialNumberLabel.append(titleSerialNumber)
        fullSerialNumberLabel.append(snLabel)
        self.serialNumberLabel.attributedText = fullSerialNumberLabel
        
        let titleTechnician = NSAttributedString.stylizedText("Teknisi: ", font: UIFont.robotoBold(10), color: UIColor.customPlaceholderColor)
        let techLabel = NSAttributedString.stylizedText(data?.txtEngineerName ?? "-", font: UIFont.robotoBold(10), color: UIColor.customDarkGrayColor)
        
        let fullTechnicianLabel = NSMutableAttributedString()
        fullTechnicianLabel.append(titleTechnician)
        fullTechnicianLabel.append(techLabel)
        self.technicianLabel.attributedText = fullTechnicianLabel
    }
    
}
