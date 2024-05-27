//
//  ActionTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/02/24.
//

import UIKit

class ActionTVC: UITableViewCell {
    
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var seeOnlyView: UIView!
    @IBOutlet weak var seeOnlyTitleLabel: UILabel!
    @IBOutlet weak var seeOnlyDescLabel: UILabel!
    @IBOutlet weak var continueWorkView: UIView!
    @IBOutlet weak var continueWorkTitleLabel: UILabel!
    
    static let identifier = String(describing: ActionTVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.containerStackView.addDashedBorder(position: .bottom, width: 1.5, colorBorder: UIColor.customLightGrayColor.cgColor)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension ActionTVC {
    
//    func setupCell(data: ActionModel, type: WorkSheetOnsitePreventiveDetailType) {
//        seeOnlyTitleLabel.text = data.title
//        seeOnlyDescLabel.text = data.desc
//        continueWorkTitleLabel.text = data.title
//        
//        seeOnlyView.isHidden = type == .workContinue
//        continueWorkView.isHidden = type == .seeOnly
//    }
    
}
