//
//  ElectricTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 02/06/24.
//

import UIKit

class ElectricTVC: UITableViewCell {
    
    static let identifier = String(describing: ElectricTVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var countView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var containerDescriptionStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.containerStackView.makeCornerRadius(8)
        self.containerStackView.addBorder(width: 1.0, colorBorder: UIColor.customPrimaryColor)
        self.countView.makeCornerRadius(8, .leftCurve)
        self.countView.addBorder(width: 1.0, colorBorder: UIColor.customPrimaryColor)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension ElectricTVC {
    
    func setupCell(data: LKData.Listrik) {
        countLabel.text = data.valUkur == "" ? "0" : data.valUkur
        titleLabel.text = "\(data.label ?? "-") (\(data.ambangBatas ?? "-")) : \(data.valUkur == "" ? "Tidak ada" : data.valUkur ?? "")"
        descriptionLabel.text = data.desc == "" ? "Tidak ada keterangan" : data.desc
        
        if data.valUkur == "" && data.desc == "" {
            countLabel.textColor = UIColor.customIndicatorColor4
            countView.backgroundColor = UIColor.customIndicatorColor3
            containerStackView.addBorder(width: 1.0, colorBorder: UIColor.customIndicatorColor4)
            countView.addBorder(width: 1.0, colorBorder: UIColor.customIndicatorColor4)
        }
    }
    
}
