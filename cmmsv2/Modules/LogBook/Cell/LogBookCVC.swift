//
//  LogBookCVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 17/03/24.
//

import UIKit

class LogBookCVC: UICollectionViewCell {
    
    static let identifier = String(describing: LogBookCVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var containerContentStackView: UIStackView!
    @IBOutlet weak var uniqueNumberLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var evaluationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addShadow(2.8, position: .top, opacity: 0.08)
        containerContentStackView.makeCornerRadius(8)
        containerStackView.addBorder(width: 1.0, colorBorder: UIColor.customLightGrayColor.cgColor)
        containerStackView.makeCornerRadius(8)
    }
    
}

extension LogBookCVC {
    
    func setupCell(data: LogBookEntity) {
        uniqueNumberLabel.text = data.uniqueNumber
        timeLabel.text = data.time
        actionLabel.text = data.action
        evaluationLabel.text = data.evaluation
    }
    
}
