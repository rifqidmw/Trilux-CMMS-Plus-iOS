//
//  PreventiveMaintenanceCVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 11/03/24.
//

import UIKit

class PreventiveMaintenanceCVC: UICollectionViewCell {
    
    static let identifier = String(describing: PreventiveMaintenanceCVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var uniqueNumberLabel: UILabel!
    @IBOutlet weak var approvedStatusView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusViewWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.makeCornerRadius(8)
        self.makeCornerRadius(8)
        self.addShadow(4.2, opacity: 0.2)
        self.approvedStatusView.makeCornerRadius(4)
        self.statusView.makeCornerRadius(4)
    }
    
}

extension PreventiveMaintenanceCVC {
    
    func setupCell(data: PreventiveMaintenanceListEntity) {
        uniqueNumberLabel.text = data.uniqueNumber
        approvedStatusView.isHidden = !data.approveStatus
        titleLabel.text = data.title
        descriptionLabel.text = "\(data.description) - \(data.room)"
        configureStatus(status: data.status)
    }
    
    private func configureStatus(status: WorkSheetStatus) {
        statusLabel.text = status.getStringValue()
        
        switch status {
        case .done:
            statusView.backgroundColor = UIColor.customLightGreenColor
            statusLabel.textColor = UIColor.customIndicatorColor8
            statusViewWidthConstraint.constant = 120
        case .open:
            statusView.backgroundColor = UIColor.customSecondaryColor
            statusLabel.textColor = UIColor.customPrimaryColor
            statusViewWidthConstraint.constant = 34
        case .ongoing:
            statusView.backgroundColor = UIColor.customIndicatorColor2
            statusLabel.textColor = UIColor.customIndicatorColor11
            statusViewWidthConstraint.constant = 110
        default: break
        }
    }
    
}
