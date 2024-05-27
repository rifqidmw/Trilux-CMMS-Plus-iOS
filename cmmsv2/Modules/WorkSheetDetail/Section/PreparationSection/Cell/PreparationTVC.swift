//
//  PreparationTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/02/24.
//

import UIKit

class PreparationTVC: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    static let identifier = String(describing: PreparationTVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.statusView.makeCornerRadius(4)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension PreparationTVC {
    
    func setupCell(data: LKData.Persiapan) {
        self.titleLabel.text = data.label ?? ""
        self.configureStatus(status: PreparationStatusType(rawValue: ((data.valueText ?? .none) ?? "")) ?? .none)
    }
    
    private func configureStatus(status: PreparationStatusType) {
        statusLabel.text = status.getStringValue().capitalized
        
        switch status {
        case .yes:
            statusView.backgroundColor = UIColor.customLightGreenColor
            statusLabel.textColor = UIColor.customIndicatorColor8
            
            let attributedString = NSMutableAttributedString(string: titleLabel.text ?? "")
            attributedString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
            titleLabel.attributedText = attributedString
        case .no:
            statusView.backgroundColor = UIColor.customIndicatorColor3
            statusLabel.textColor = UIColor.customIndicatorColor4
        case .pass:
            statusView.backgroundColor = UIColor.customIndicatorColor2
            statusLabel.textColor = UIColor.customIndicatorColor11
        default: break
        }
    }
    
}
