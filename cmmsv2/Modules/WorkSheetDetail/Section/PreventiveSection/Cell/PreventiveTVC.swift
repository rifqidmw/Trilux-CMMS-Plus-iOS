//
//  PreventiveTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 02/06/24.
//

import UIKit

class PreventiveTVC: UITableViewCell {
    
    static let identifier = String(describing: PreventiveTVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.statusView.makeCornerRadius(4)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension PreventiveTVC {
    
    func setupCell(data: LKData.Preventif) {
        titleLabel.text = data.label ?? "-"
        configureStatus(status: MonitoringStatusType(rawValue: data.valueText ?? "") ?? MonitoringStatusType.none)
    }
    
    private func configureStatus(status: MonitoringStatusType) {
        statusLabel.text = status.getStringValue()
        configureStatusView(view: statusView, label: statusLabel, status: status)
        if status == .strips {
            titleLabel.applyStrikethrough()
        }
    }
    
    private func configureStatusView(view: UIView, label: UILabel, status: MonitoringStatusType) {
        (view.backgroundColor, label.textColor) = status.viewColors
    }
    
}
