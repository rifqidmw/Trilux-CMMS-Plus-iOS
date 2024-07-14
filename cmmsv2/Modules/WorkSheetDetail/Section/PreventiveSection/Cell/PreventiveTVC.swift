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
    @IBOutlet weak var checkBoxButton: UIImageView!
    
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
    
    func setupCell(data: LKData.Preventif, activityType: WorkSheetActivityType, isSelected: Bool = false) {
        self.titleLabel.text = data.label ?? "-"
        self.configureStatus(status: MonitoringStatusType(rawValue: data.valueText ?? "") ?? MonitoringStatusType.none, activityType: activityType)
        self.checkBoxButton.image = UIImage(named: isSelected ? "checked_checkbox" : "unchecked_checkbox")
    }
    
    private func configureStatus(status: MonitoringStatusType, activityType: WorkSheetActivityType) {
        statusLabel.text = status.getStringValue()
        configureStatusView(view: statusView, label: statusLabel, status: status)
        
        if activityType == .working || activityType == .correction {
            self.checkBoxButton.isHidden = false
            self.statusView.isHidden = true
            titleLabel.removeStrikethrough()
        } else if activityType == .view {
            self.statusView.isHidden = false
            self.checkBoxButton.isHidden = true
            
            if status == .strips {
                self.titleLabel.applyStrikethrough()
            } else {
                self.titleLabel.removeStrikethrough()
            }
        }
    }
    
    private func configureStatusView(view: UIView, label: UILabel, status: MonitoringStatusType) {
        (view.backgroundColor, label.textColor) = status.viewColors
    }
    
}
