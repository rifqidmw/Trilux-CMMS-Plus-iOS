//
//  EquipmentManagementCell.swift
//  cmmsv2
//
//  Created by macbook  on 14/09/24.
//

import UIKit
import SkeletonView

class EquipmentManagementCell: UITableViewCell {
    
    static let identifier = String(describing: EquipmentManagementCell.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var containerContentView: UIView!
    @IBOutlet weak var destinationInstallationTitleLabel: UILabel!
    @IBOutlet weak var dateTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var assetCountLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.containerContentView.makeCornerRadius(8)
        self.containerContentView.addShadow(4, position: .bottom, opacity: 0.2)
        self.statusView.makeCornerRadius(4)
        self.showAnimationSkeleton()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension EquipmentManagementCell {
    
    func setupCell(
        destination: NSAttributedString?,
        date: String?,
        title: String?,
        description: String?,
        assetCount: NSAttributedString?,
        status: String? = nil) {
            self.hideAnimationSkeleton()
            self.statusView.isHidden = true
            if let destination {
                self.destinationInstallationTitleLabel.attributedText = destination
            }
            self.dateTitleLabel.text = date ?? "-"
            self.titleLabel.text = title ?? "-"
            self.descriptionLabel.text = description ?? "-"
            if let assetCount {
                self.assetCountLabel.attributedText = assetCount
            }
            if let status {
                self.setupStatusView(status: EquipmentStatusTextType(rawValue: status))
            }
        }
    
    private func setupStatusView(status: EquipmentStatusTextType?) {
        self.statusView.isHidden = false
        self.statusLabel.text = status?.getStringValue()
        switch status {
        case .taken:
            self.statusView.backgroundColor = UIColor.customLightGreenColor
            self.statusLabel.textColor = UIColor.customGreenColor
        case .readyTaken:
            self.statusView.backgroundColor = UIColor.customSecondaryColor
            self.statusLabel.textColor = UIColor.customPrimaryColor
        default: break
        }
    }
    
    private func showAnimationSkeleton() {
        [self.destinationInstallationTitleLabel,
         self.dateTitleLabel,
         self.titleLabel,
         self.descriptionLabel,
         self.assetCountLabel,
         self.statusView].forEach {
            $0.isSkeletonable = true
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideAnimationSkeleton() {
        [self.destinationInstallationTitleLabel,
         self.dateTitleLabel,
         self.titleLabel,
         self.descriptionLabel,
         self.assetCountLabel,
         self.statusView].forEach {
            $0.hideSkeleton()
        }
    }
    
}
