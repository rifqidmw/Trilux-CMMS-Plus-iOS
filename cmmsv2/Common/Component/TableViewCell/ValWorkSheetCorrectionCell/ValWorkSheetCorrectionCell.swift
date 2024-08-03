//
//  ValWorkSheetCorrectionCell.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 02/08/24.
//

import UIKit
import SkeletonView

class ValWorkSheetCorrectionCell: UITableViewCell {
    
    static let identifier = String(describing: ValWorkSheetCorrectionCell.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var containerContentStackView: UIStackView!
    @IBOutlet weak var lkNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var technicianLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.containerContentStackView.makeCornerRadius(8)
        self.showAnimationSkeleton()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension ValWorkSheetCorrectionCell {
    
    private func showAnimationSkeleton() {
        [self.lkNumberLabel,
         self.dateLabel,
         self.statusLabel,
         self.technicianLabel].forEach {
            $0.isSkeletonable = true
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideAnimationSkeleton() {
        [self.lkNumberLabel,
         self.dateLabel,
         self.statusLabel,
         self.technicianLabel].forEach {
            $0.hideSkeleton()
        }
    }
    
    func setupCell(
        _ lkNumber: String?,
        date: String?,
        status: String?,
        technician: String?) {
            self.hideAnimationSkeleton()
            self.lkNumberLabel.text = lkNumber ?? "-"
            self.dateLabel.text = date ?? "-"
            
            let titleStatus = NSAttributedString.stylizedText("Status: ", font: UIFont.robotoBold(12), color: UIColor.customPlaceholderColor)
            let statusLabel = NSAttributedString.stylizedText(status ?? "-", font: UIFont.robotoBold(12), color: UIColor.customDarkGrayColor)
            
            let fullStatusLabel = NSMutableAttributedString()
            fullStatusLabel.append(titleStatus)
            fullStatusLabel.append(statusLabel)
            
            self.statusLabel.attributedText = fullStatusLabel
            
            let titleTechnician = NSAttributedString.stylizedText("Teknisi: ", font: UIFont.robotoBold(12), color: UIColor.customPlaceholderColor)
            let techLabel = NSAttributedString.stylizedText(technician ?? "-", font: UIFont.robotoBold(12), color: UIColor.customDarkGrayColor)
            
            let fullTechnicianLabel = NSMutableAttributedString()
            fullTechnicianLabel.append(titleTechnician)
            fullTechnicianLabel.append(techLabel)
            
            self.technicianLabel.attributedText = fullTechnicianLabel
        }
    
}
