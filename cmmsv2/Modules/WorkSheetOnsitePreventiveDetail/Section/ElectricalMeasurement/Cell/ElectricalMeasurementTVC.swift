//
//  ElectricalMeasurementTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 08/02/24.
//

import UIKit

class ElectricalMeasurementTVC: UITableViewCell {
    
    static let identifier = String(describing: ElectricalMeasurementTVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var containerValueView: UIView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.containerStackView.makeCornerRadius(8)
        self.containerValueView.makeCornerRadius(8, .leftCurve)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension ElectricalMeasurementTVC {
    
    func setupCell(data: ElectricalMeasurementModel) {
        valueLabel.text = data.value.description
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        
        let valueCondition = data.value > 0
        containerStackView.addBorder(width: 1, colorBorder: valueCondition ? UIColor.customIndicatorColor10.cgColor : UIColor.customIndicatorColor4.cgColor)
        containerValueView.backgroundColor = valueCondition ? UIColor.customLightGreenColor : UIColor.customIndicatorColor3
        valueLabel.textColor = valueCondition ? UIColor.customIndicatorColor10 : UIColor.customIndicatorColor4
        containerValueView.addBorder(width: 1, colorBorder: valueCondition ? UIColor.customIndicatorColor10.cgColor : UIColor.customIndicatorColor3.cgColor)
        containerValueView.addBorder(width: 1, colorBorder: valueCondition ? UIColor.customIndicatorColor10.cgColor : UIColor.customIndicatorColor4.cgColor)
    }
    
}
