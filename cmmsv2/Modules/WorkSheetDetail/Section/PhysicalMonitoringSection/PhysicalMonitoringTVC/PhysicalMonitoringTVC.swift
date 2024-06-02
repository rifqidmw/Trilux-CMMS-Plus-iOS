//
//  PhysicalMonitoringTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 01/06/24.
//

import UIKit

enum PhysicalMonitoringCellType {
    case header
    case content
}

class PhysicalMonitoringTVC: UITableViewCell {
    
    static let identifier = String(describing: PhysicalMonitoringTVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var headerStackView: UIStackView!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var physicalView: UIView!
    @IBOutlet weak var physicalLabel: UILabel!
    @IBOutlet weak var functionView: UIView!
    @IBOutlet weak var functionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        self.physicalView.makeCornerRadius(4)
        self.functionView.makeCornerRadius(4)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension PhysicalMonitoringTVC {
    
    func setupCell(data: LKData.Pemantauan, type: PhysicalMonitoringCellType? = .content) {
        contentStackView.isHidden = type == .header
        headerStackView.isHidden = type == .content
        
        titleLabel.text = data.label ?? "-"
        configureLabel(physical: MonitoringStatusType(rawValue: data.fisikText ?? "") ?? MonitoringStatusType.none, functional: MonitoringStatusType(rawValue: data.fungsiText ?? "") ?? MonitoringStatusType.none)
    }
    
    private func configureLabel(physical: MonitoringStatusType, functional: MonitoringStatusType) {
        physicalLabel.text = physical.getStringValue()
        functionLabel.text = functional.getStringValue()
        
        configureStatusView(view: physicalView, label: physicalLabel, status: physical)
        configureStatusView(view: functionView, label: functionLabel, status: functional)
        
        if physical == .strips && functional == .strips {
            titleLabel.applyStrikethrough()
        }
    }
    
    private func configureStatusView(view: UIView, label: UILabel, status: MonitoringStatusType) {
        (view.backgroundColor, label.textColor) = status.viewColors
    }
    
    
}

extension MonitoringStatusType {
    var viewColors: (background: UIColor, text: UIColor) {
        switch self {
        case .good:
            return (UIColor.customIndicatorColor13, UIColor.customIndicatorColor12)
        case .cross, .strips:
            return (UIColor.customIndicatorColor3, UIColor.customIndicatorColor4)
        default:
            return (.customLightGrayColor, .customDarkGrayColor)
        }
    }
}
