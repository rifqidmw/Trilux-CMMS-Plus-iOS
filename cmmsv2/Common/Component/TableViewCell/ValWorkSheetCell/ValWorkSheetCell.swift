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
        self.containerContentStackView.addShadow(4, position: .bottom, opacity: 0.2)
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
            self.statusView.configureStatusView(
                status: status ?? .none,
                titleLabel: statusLabel,
                widthConstraint: statusViewWidthConstraint)
        }
    
}
