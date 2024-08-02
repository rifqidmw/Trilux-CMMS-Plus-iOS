//
//  ValWorkSheetCell.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 01/08/24.
//

import UIKit
import SkeletonView

class ValWorkSheetCell: UITableViewCell {
    
    static let identifier = String(describing: ValWorkSheetCell.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var containerContentStackView: UIStackView!
    @IBOutlet weak var lkNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.statusView.makeCornerRadius(4)
        self.containerContentStackView.makeCornerRadius(8)
        self.containerContentStackView.addShadow(2, position: .bottom, opacity: 0.2)
        self.showAnimationSkeleton()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension ValWorkSheetCell {
    
    private func showAnimationSkeleton() {
        [self.lkNumberLabel,
         self.dateLabel,
         self.statusView].forEach {
            $0.isSkeletonable = true
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideAnimationSkeleton() {
        [self.lkNumberLabel,
         self.dateLabel,
         self.statusView].forEach {
            $0.hideSkeleton()
        }
    }
    
    func setupCell(
        _ lkNumber: String?,
        date: String?,
        engineer: String?,
        _ status: WorkSheetStatus?) {
            self.hideAnimationSkeleton()
            self.lkNumberLabel.text = lkNumber ?? ""
            self.dateLabel.text = "\(engineer ?? "") • \(date ?? "")"
            self.configureStatus(status: status ?? .none)
        }
    
    private func configureStatus(status: WorkSheetStatus) {
        self.statusLabel.text = status.getStringValue()
        
        switch status {
        case .done:
            self.statusView.backgroundColor = UIColor.customLightGreenColor
            self.statusLabel.textColor = UIColor.customIndicatorColor8
            self.statusViewWidthConstraint.constant = 160
        case .open:
            self.statusView.backgroundColor = UIColor.customSecondaryColor
            self.statusLabel.textColor = UIColor.customPrimaryColor
            self.statusViewWidthConstraint.constant = 46
        case .ongoing:
            self.statusView.backgroundColor = UIColor.customIndicatorColor2
            self.statusLabel.textColor = UIColor.customIndicatorColor11
            self.statusViewWidthConstraint.constant = 130
        case .hold:
            self.statusView.backgroundColor = UIColor.customIndicatorColor2
            self.statusLabel.textColor = UIColor.customIndicatorColor11
            self.statusViewWidthConstraint.constant = 100
        case .close:
            self.statusView.backgroundColor = UIColor.customLightGreenColor
            self.statusLabel.textColor = UIColor.customIndicatorColor8
            self.statusViewWidthConstraint.constant = 46
        case .removed:
            self.statusView.backgroundColor = UIColor.customIndicatorColor3
            self.statusLabel.textColor = UIColor.customIndicatorColor4
            self.statusViewWidthConstraint.constant = 220
        case .progressDelay:
            self.statusView.backgroundColor = UIColor.customIndicatorColor2
            self.statusLabel.textColor = UIColor.customIndicatorColor11
            self.statusViewWidthConstraint.constant = 100
        case .progress:
            self.statusView.backgroundColor = UIColor.customIndicatorColor2
            self.statusLabel.textColor = UIColor.customIndicatorColor11
            self.statusViewWidthConstraint.constant = 80
        case .draft:
            self.statusView.backgroundColor = UIColor.customIndicatorColor2
            self.statusLabel.textColor = UIColor.customIndicatorColor11
            self.statusViewWidthConstraint.constant = 50
        default: break
        }
    }
    
}
