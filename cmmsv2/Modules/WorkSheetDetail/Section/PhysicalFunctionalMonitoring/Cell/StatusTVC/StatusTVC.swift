//
//  StatusTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 08/02/24.
//

import UIKit

class StatusTVC: UITableViewCell {
    
    @IBOutlet weak var containerStatusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var iconCheckBoxImageView: UIImageView!
    
    static let identifier = String(describing: StatusTVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.containerStatusView.makeCornerRadius(4)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension StatusTVC {
    
//    func setupCell(status: PreparationStatus, type: WorkSheetOnsitePreventiveDetailType, isSelected: Bool? = false) {
//        statusLabel.text = status.getStringValue()
//        iconCheckBoxImageView.image = UIImage(named: isSelected ?? false ? "checked_checkbox" : "unchecked_checkbox")
//        
//        containerStatusView.backgroundColor = status == .good ? UIColor.customLightGreenColor : UIColor.customIndicatorColor3
//        statusLabel.textColor = status == .good ? UIColor.customIndicatorColor10 : UIColor.customIndicatorColor4
//        
//        containerStatusView.isHidden = type == .workContinue
//        iconCheckBoxImageView.isHidden = type == .seeOnly
//    }
    
}
