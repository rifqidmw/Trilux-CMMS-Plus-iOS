//
//  CalibrationMeasurementTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 06/02/24.
//

import UIKit

class CalibrationMeasurementTVC: UITableViewCell {
    
    @IBOutlet weak var blueEllipseIconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoIconImageView: UIImageView!
    @IBOutlet weak var valueMeasurementLabel: UILabel!
    
    static let identifier = String(describing: CalibrationMeasurementTVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension CalibrationMeasurementTVC {
    
    func setupCell(data: MeasurementModel) {
        titleLabel.text = data.title
        valueMeasurementLabel.text = data.value.description
    }
    
}
