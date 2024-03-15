//
//  HistoryCVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/03/24.
//

import UIKit

class HistoryCVC: UICollectionViewCell {
    
    static let identifier = String(describing: HistoryCVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var approvedView: UIView!
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
        self.approvedView.makeCornerRadius(4)
        self.statusView.makeCornerRadius(4)
    }
    
}

extension HistoryCVC {
    
    func setupCell(data: HistoryListEntity) {
        dateLabel.text = data.date
        approvedView.isHidden = !data.isApproved
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        configureStatus(status: data.status)
    }
    
    private func configureStatus(status: HistoryStatusType) {
        statusLabel.text = status.getStringValue()
        
        switch status {
        case .done:
            statusView.backgroundColor = UIColor.customLightGreenColor
            statusLabel.textColor = UIColor.customIndicatorColor8
            statusViewWidthConstraint.constant = 140
        case .hold:
            statusView.backgroundColor = UIColor.customIndicatorColor2
            statusLabel.textColor = UIColor.customIndicatorColor11
            statusViewWidthConstraint.constant = 90
        case .removed:
            statusView.backgroundColor = UIColor.customIndicatorColor2
            statusLabel.textColor = UIColor.customIndicatorColor11
            statusViewWidthConstraint.constant = 170
        default: break
        }
    }
    
}
