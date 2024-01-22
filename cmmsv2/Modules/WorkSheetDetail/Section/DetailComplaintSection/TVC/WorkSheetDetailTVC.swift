//
//  WorkSheetDetailTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 21/01/24.
//

import UIKit

class WorkSheetDetailTVC: UITableViewCell {
    
    static let identifier = String(describing: WorkSheetDetailTVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var uniqueNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var technicianLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.containerView.makeCornerRadius(8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension WorkSheetDetailTVC {
    
    func setupCell(data: WorkSheetDetailEntity) {
        uniqueNumberLabel.text = data.uniqueNumber
        dateLabel.text = data.date
        statusLabel.text = data.status
        technicianLabel.text = data.technician
    }
    
}
