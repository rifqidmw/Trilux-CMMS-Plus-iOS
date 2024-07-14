//
//  PreparationTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 28/05/24.
//

import UIKit

class PreparationTVC: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIImageView!
    
    static let identifier = String(describing: PreparationTVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.statusView.makeCornerRadius(4)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension PreparationTVC {
    
    func setupCell(data: LKData.Persiapan, activityType: WorkSheetActivityType, isSelected: Bool = false) {
        self.titleLabel.text = data.label ?? ""
        self.configureStatus(status: PreparationStatusType(rawValue: (data.valueText ?? .none) ?? "") ?? .none, activityType: activityType)
        self.checkBoxButton.image = UIImage(named: isSelected ? "checked_checkbox" : "unchecked_checkbox")
    }
    
    private func configureStatus(status: PreparationStatusType, activityType: WorkSheetActivityType) {
        statusLabel.text = status.getStringValue().capitalized
        
        if activityType == .working || activityType == .correction {
            self.checkBoxButton.isHidden = false
            self.statusView.isHidden = true
            titleLabel.removeStrikethrough()
        } else if activityType == .view {
            self.statusView.isHidden = false
            self.checkBoxButton.isHidden = true
            
            switch status {
            case .yes:
                statusView.backgroundColor = UIColor.customLightGreenColor
                statusLabel.textColor = UIColor.customIndicatorColor8
                titleLabel.applyStrikethrough()
            case .no:
                statusView.backgroundColor = UIColor.customIndicatorColor3
                statusLabel.textColor = UIColor.customIndicatorColor4
                titleLabel.removeStrikethrough()
            case .pass:
                statusView.backgroundColor = UIColor.customIndicatorColor2
                statusLabel.textColor = UIColor.customIndicatorColor11
                titleLabel.removeStrikethrough()
            default:
                titleLabel.removeStrikethrough()
            }
        }
    }
    
}
