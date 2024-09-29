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
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var containerStatusView: UIStackView!
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
        destination: NSAttributedString? = nil,
        date: String? = nil,
        title: String? = nil,
        description: String? = nil,
        brand: NSAttributedString? = nil,
        type: NSAttributedString? = nil,
        serialNumber: NSAttributedString? = nil,
        assetCount: NSAttributedString? = nil,
        status: String? = nil) {
            self.hideAnimationSkeleton()
            self.statusView.isHidden = true
            self.destinationInstallationTitleLabel.isHidden = true
            self.dateTitleLabel.isHidden = true
            self.titleLabel.isHidden = true
            self.descriptionLabel.isHidden = true
            self.assetCountLabel.isHidden = true
            self.containerStatusView.isHidden = true
            
            if let destination {
                self.destinationInstallationTitleLabel.isHidden = false
                self.destinationInstallationTitleLabel.attributedText = destination
            }
            if let date {
                self.dateTitleLabel.isHidden = false
                self.dateTitleLabel.text = date
            }
            if let title {
                self.titleLabel.isHidden = false
                self.titleLabel.text = title
            }
            if let description {
                self.descriptionLabel.isHidden = false
                self.descriptionLabel.text = description
            }
            if let brand {
                self.descriptionLabel.isHidden = false
                self.brandLabel.attributedText = brand
            }
            if let type {
                self.typeLabel.isHidden = false
                self.typeLabel.attributedText = type
            }
            if let serialNumber {
                self.serialNumberLabel.isHidden = false
                self.serialNumberLabel.attributedText = serialNumber
            }
            if let assetCount {
                self.containerStatusView.isHidden = false
                self.assetCountLabel.isHidden = false
                self.assetCountLabel.attributedText = assetCount
            }
            if let status {
                self.containerStatusView.isHidden = false
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
        case .submission:
            self.statusView.backgroundColor = UIColor.customIndicatorColor2
            self.statusLabel.textColor = UIColor.customIndicatorColor11
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
