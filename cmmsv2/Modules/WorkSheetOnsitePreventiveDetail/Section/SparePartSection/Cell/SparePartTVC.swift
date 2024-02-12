//
//  SparePartTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/02/24.
//

import UIKit

class SparePartTVC: UITableViewCell {
    
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var seeOnlyView: UIView!
    @IBOutlet weak var seeOnlyTotalLabel: UILabel!
    @IBOutlet weak var seeOnlyTitleLabel: UILabel!
    @IBOutlet weak var continueWorkView: UIView!
    @IBOutlet weak var continueWorkTitleLabel: UILabel!
    @IBOutlet weak var continueWorkTotalLabel: UILabel!
    
    static let identifier = String(describing: SparePartTVC.self)
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

extension SparePartTVC {
    
    func setupCell(data: SparePartModel, type: WorkSheetOnsitePreventiveDetailType) {
        seeOnlyTitleLabel.text = data.title
        continueWorkTitleLabel.text = data.title
        seeOnlyTotalLabel.text = data.total.description
        continueWorkTotalLabel.text = "Jumlah \(data.total)"
        
        seeOnlyView.isHidden = type == .workContinue
        continueWorkView.isHidden = type == .seeOnly
    }
    
}
