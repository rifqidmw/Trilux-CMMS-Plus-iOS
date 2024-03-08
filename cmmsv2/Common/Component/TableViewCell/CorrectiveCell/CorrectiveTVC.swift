//
//  CorrectiveTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/03/24.
//

import UIKit

class  CorrectiveTVC: UITableViewCell {
    
    static let identifier = String(describing: CorrectiveTVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var correctiveImagView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var correctiveTitleLabel: UILabel!
    @IBOutlet weak var correctiveDescriptionLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var technicianLabel: UILabel!
    @IBOutlet weak var damageLabel: UILabel!
    @IBOutlet weak var actionButton: GeneralButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.correctiveImagView.makeCornerRadius(8)
        self.correctiveImagView.addShadow(0.4, opacity: 0.4)
        self.containerStackView.makeCornerRadius(8)
        self.containerStackView.addShadow(6, opacity: 0.2)
        self.actionButton.configure(title: "Korektif Lanjutan", type: .withIcon, icon: "ic_screwdriver_white")
        self.actionButton.makeCornerRadius(8)
        self.statusView.makeCornerRadius(4)
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension CorrectiveTVC {
    
    func setupCell(data: ComplaintListEntity) {
        correctiveImagView.image = UIImage(named: data.image)
        dateLabel.text = "\(data.date) • \(data.type)"
        correctiveTitleLabel.text = data.type
        correctiveDescriptionLabel.text = data.description
        technicianLabel.text = data.technician
        damageLabel.text = data.damage
        configureStatusView(status: data.status)
        actionButton.isHidden = data.isActionActive
    }
    
    private func configureStatusView(status: CorrectiveStatusType) {
        statusLabel.text = status.getStringValue()
        switch status {
        case .open:
            statusView.backgroundColor = UIColor.customSecondaryColor
            statusLabel.textColor = UIColor.customPrimaryColor
        case .progress:
            statusView.backgroundColor = UIColor.customLightYellowColor
            statusLabel.textColor = UIColor.customDarkYellowColor
        case .closed:
            statusView.backgroundColor = UIColor.customLightGreenColor
            statusLabel.textColor = UIColor.darkGreen
        case .delay:
            statusView.backgroundColor = UIColor.customLightGrayColor
            statusLabel.textColor = UIColor.customDarkGrayColor
        case .none:
            statusView.isHidden = true
        }
    }
}
