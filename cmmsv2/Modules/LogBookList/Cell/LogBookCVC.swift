//
//  LogBookCVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 17/03/24.
//

import UIKit
import SkeletonView

class LogBookCVC: UICollectionViewCell {
    
    static let identifier = String(describing: LogBookCVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var containerContentStackView: UIStackView!
    @IBOutlet weak var containerHeaderView: UIView!
    @IBOutlet weak var containerHeaderStackView: UIStackView!
    @IBOutlet weak var uniqueNumberLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var containerContentView: UIView!
    @IBOutlet weak var containerActionView: UIView!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var containerEvaluationView: UIView!
    @IBOutlet weak var evaluationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addShadow(2, position: .bottom, opacity: 0.2)
        containerContentStackView.makeCornerRadius(8)
        containerContentStackView.addBorder(width: 0.8, colorBorder: UIColor.customLightGrayColor)
        containerStackView.addBorder(width: 1.0, colorBorder: UIColor.customLightGrayColor)
        containerStackView.makeCornerRadius(8)
        showSkeletonAnimation()
    }
    
}

extension LogBookCVC {
    
    func setupCell(data: LogBookData) {
        hideSkeletonAnimation()
        uniqueNumberLabel.text = data.lk_number
        timeLabel.text = data.time
        actionLabel.text = data.tindakan?.first
        evaluationLabel.text = ((data.tindakan?.first?.isEmpty) != nil) ? "-" : "\(data.tanggal ?? "")"
    }
    
    private func showSkeletonAnimation() {
        [containerHeaderView,
         containerActionView,
         containerEvaluationView].forEach {
            $0.isSkeletonable = true
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideSkeletonAnimation() {
        [containerHeaderView,
         containerActionView,
         containerEvaluationView].forEach {
            $0.hideSkeleton()
        }
    }
    
}
