//
//  RoomRequirementCell.swift
//  cmmsv2
//
//  Created by macbook  on 05/10/24.
//

import UIKit
import SkeletonView

class RoomRequirementCell: UITableViewCell {
    
    static let identifier = String(describing: RoomRequirementCell.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var initialWidthStatusViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var suggestionView: InformationCardView!
    @IBOutlet weak var realitazionView: InformationCardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.containerStackView.makeCornerRadius(8)
        self.containerStackView.addShadow(4.2, opacity: 0.2)
        self.showAnimationSkeleton()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension RoomRequirementCell {
    
    func setupCell(
        date: NSAttributedString?,
        status: String?,
        title: String?,
        description: NSAttributedString?,
        count: String?,
        suggestUnit: String?,
        suggestCharacteristic: String?,
        realizationCount: String?
    ) {
        self.hideAnimationSkeleton()
        if let date {
            self.dateLabel.attributedText = date
        }
        
        if let status {
            self.configureStatus(status: RoomRequirementStatusType(rawValue: status) ?? .none)
        }
        
        if let description {
            self.descriptionLabel.attributedText = description
        }
        
        self.titleLabel.text = title ?? "-"
        self.suggestionView.configureView(title: "Usulan", value: "\(count ?? "-") \(suggestUnit ?? "-") (\(suggestCharacteristic ?? "-"))")
        self.realitazionView.configureView(title: "Realisasi", value: realizationCount ?? "-")
    }
    
    private func configureStatus(status: RoomRequirementStatusType) {
        self.statusLabel.text = status.getStringValue().capitalized
        self.statusView.backgroundColor = UIColor.customLightYellowColor
        self.statusLabel.textColor = UIColor.customIndicatorColor11
        self.statusView.makeCornerRadius(4)
        
        switch status {
        case .scoring:
            self.initialWidthStatusViewConstraint.constant = 56
        case .budgeting:
            self.initialWidthStatusViewConstraint.constant = 76
        case .submission:
            self.initialWidthStatusViewConstraint.constant = 68
            self.statusView.backgroundColor = UIColor.customSecondaryColor
            self.statusLabel.textColor = UIColor.customPrimaryColor
        default: break
        }
    }
    
    private func showAnimationSkeleton() {
        [self.dateLabel,
         self.titleLabel,
         self.statusView,
         self.titleLabel,
         self.descriptionLabel,
         self.suggestionView,
         self.realitazionView].forEach {
            $0.isSkeletonable = true
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideAnimationSkeleton() {
        [self.dateLabel,
         self.titleLabel,
         self.statusView,
         self.titleLabel,
         self.descriptionLabel,
         self.suggestionView,
         self.realitazionView].forEach {
            $0.hideSkeleton()
        }
    }
    
}
