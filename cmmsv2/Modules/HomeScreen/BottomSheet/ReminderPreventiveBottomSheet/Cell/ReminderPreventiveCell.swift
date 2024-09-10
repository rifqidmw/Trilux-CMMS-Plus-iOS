//
//  ReminderPreventiveCell.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/08/24.
//

import UIKit
import SkeletonView

class ReminderPreventiveCell: UITableViewCell {
    
    @IBOutlet weak var containerContentStackView: UIStackView!
    @IBOutlet weak var lkNumberLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var assetNameLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var technicianLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    
    static let identifier = String(describing: ReminderPreventiveCell.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.statusView.makeCornerRadius(4)
        self.containerContentStackView.makeCornerRadius(8)
        self.containerContentStackView.addShadow(0.1, position: .bottom, opacity: 0.2)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension ReminderPreventiveCell {
    
    func setupCell(data: ReminderPreventiveData) {
        self.lkNumberLabel.text = data.lkNumber ?? ""
        self.assetNameLabel.text = data.assetname ?? ""
        self.roomLabel.text = "\(data.serial ?? "") - \(data.instalasi ?? "") - \(data.ruangan ?? "")"
        
        let titleBrand = NSAttributedString.stylizedText("Brand: ", font: UIFont.robotoBold(10), color: UIColor.customPlaceholderColor)
        let brandLabel = NSAttributedString.stylizedText(data.brandname ?? "-", font: UIFont.robotoBold(10), color: UIColor.customDarkGrayColor)
        let fullBrandLabel = NSMutableAttributedString()
        fullBrandLabel.append(titleBrand)
        fullBrandLabel.append(brandLabel)
        self.brandLabel.attributedText = fullBrandLabel
        
        let titleType = NSAttributedString.stylizedText("Tipe: ", font: UIFont.robotoBold(10), color: UIColor.customPlaceholderColor)
        let typeLabel = NSAttributedString.stylizedText(data.typename ?? "-", font: UIFont.robotoBold(10), color: UIColor.customDarkGrayColor)
        let fullTyeLabel = NSMutableAttributedString()
        fullTyeLabel.append(titleType)
        fullTyeLabel.append(typeLabel)
        self.typeLabel.attributedText = fullBrandLabel
        
        let titleTechnician = NSAttributedString.stylizedText("Teknisi: ", font: UIFont.robotoBold(10), color: UIColor.customPlaceholderColor)
        let techLabel = NSAttributedString.stylizedText(data.txtEngineerName ?? "-", font: UIFont.robotoBold(10), color: UIColor.customDarkGrayColor)
        let fullTechnicianLabel = NSMutableAttributedString()
        fullTechnicianLabel.append(titleTechnician)
        fullTechnicianLabel.append(techLabel)
        self.technicianLabel.attributedText = fullTechnicianLabel
        self.statusView.configureStatusView(
            status: WorkSheetStatus(rawValue: data.txtStatus ?? "") ?? WorkSheetStatus.none,
            titleLabel: statusLabel,
            widthConstraint: statusViewWidthConstraint)
    }
    
}
