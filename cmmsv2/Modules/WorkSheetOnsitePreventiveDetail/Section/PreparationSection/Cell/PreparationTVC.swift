//
//  PreparationTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/02/24.
//

import UIKit

class PreparationTVC: UITableViewCell {
    
    @IBOutlet weak var checkboxImageView: UIImageView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
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
    
    func setupCell(data: PreparationModel, type: WorkSheetOnsitePreventiveDetailType) {
        titleLabel.text = data.title
        subTitleLabel.text = data.subTitle
        
        let statusCondition = data.status == .yes || data.status == .good
        checkboxImageView.image = UIImage(named: data.isSelected ? "checked_checkbox" : "unchecked_checkbox")
        statusLabel.text = PreparationStatus.getStringValue(data.status ?? PreparationStatus.none)()
        statusView.backgroundColor = statusCondition ? UIColor.customLightGreenColor : UIColor.customIndicatorColor3
        statusLabel.textColor = statusCondition ? UIColor.customIndicatorColor10 : UIColor.customIndicatorColor4
        
        statusView.isHidden = type == .workContinue
        checkboxImageView.isHidden = type == .seeOnly
    }
    
}
