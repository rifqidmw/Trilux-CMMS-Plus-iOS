//
//  PreventiveCalendarCVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 18/03/24.
//

import UIKit

class PreventiveCalendarCVC: UICollectionViewCell {
    
    static let identifier = String(describing: PreventiveCalendarCVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var uniqueNumberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var detailRoomLabel: UILabel!
    @IBOutlet weak var statusViewWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addShadow(2.0, position: .bottom, opacity: 0.2)
        containerView.makeCornerRadius(8)
        statusView.makeCornerRadius(4)
    }
    
}

extension PreventiveCalendarCVC {
    
    func setupCell(data: PreventiveCalendarListEntity) {
        uniqueNumberLabel.text = data.uniqueNumber
        titleLabel.text = data.title
        configureStatus(status: data.status)
        detailRoomLabel.text = "\(data.roomCode) - \(data.roomCategory) - \(data.roomName)"
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
