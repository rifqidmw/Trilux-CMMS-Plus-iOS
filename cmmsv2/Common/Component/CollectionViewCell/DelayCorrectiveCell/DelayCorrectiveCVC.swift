//
//  DelayCorrectiveCVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/03/24.
//

import UIKit

class DelayCorrectiveCVC: UICollectionViewCell {
    
    static let identifier = String(describing: DelayCorrectiveCVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var correctiveImagView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var technicianLabel: UILabel!
    @IBOutlet weak var damageLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var actionButton: GeneralButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.correctiveImagView.makeCornerRadius(8)
        self.correctiveImagView.addShadow(0.4, opacity: 0.4)
        self.containerView.makeCornerRadius(8)
        self.containerView.addShadow(6, opacity: 0.2)
        self.actionButton.configure(title: "Korektif Lanjutan", type: .withIcon, icon: "ic_screwdriver_white", backgroundColor: UIColor.customLightYellowColor, titleColor: UIColor.customIndicatorColor11)
        self.actionButton.makeCornerRadius(8)
        self.statusView.makeCornerRadius(4)
    }
    
}

extension DelayCorrectiveCVC {
    
    func setupCell(data: DelayCorrectiveListEntity) {
        correctiveImagView.image = UIImage(named: data.image)
        dateLabel.text = "\(data.date) • \(data.type)"
        titleLabel.text = data.type
        descriptionLabel.text = data.description
        technicianLabel.text = data.technician
        damageLabel.text = data.damage
    }
    
}
