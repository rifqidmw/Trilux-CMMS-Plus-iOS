//
//  CalibrationTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 28/05/24.
//

import UIKit

class CalibrationTVC: UITableViewCell {
    
    static let identifier = String(describing: CalibrationTVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension CalibrationTVC {
    
    func setupCell(data: LKData.AlatKalibrasi.Detail) {
        titleLabel.text = "\(data.jenis ?? "-") \(data.nilai ?? "-")"
        countLabel.text = data.hasil ?? "-"
    }
    
}
