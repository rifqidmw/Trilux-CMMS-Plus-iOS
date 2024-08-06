//
//  AssetMaintenanceInfoCell.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/08/24.
//

import UIKit
import SkeletonView

class AssetMaintenanceInfoCell: UITableViewCell {
    
    @IBOutlet weak var containerContentStackView: UIStackView!
    @IBOutlet weak var containerMaintenanceImageView: UIView!
    @IBOutlet weak var maintenanceImageView: UIImageView!
    @IBOutlet weak var containerFirstHorizontalTextStackView: UIStackView!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var firstDateLabel: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    @IBOutlet weak var containerSecondHorizontalTextStackView: UIStackView!
    @IBOutlet weak var fifthLabel: UILabel!
    @IBOutlet weak var secondDateLabel: UILabel!
    
    static let identifier = String(describing: AssetMaintenanceInfoCell.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.showAnimationSkeleton()
        
        self.containerContentStackView.makeCornerRadius(8)
        self.containerContentStackView.addShadow(2, position: .bottom, opacity: 0.2)
        
        self.containerMaintenanceImageView.makeCornerRadius(8, .leftCurve)
        self.maintenanceImageView.makeCornerRadius(8, .leftCurve)
        self.maintenanceImageView.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension AssetMaintenanceInfoCell {
    
    func setupCell(
        image: String? = nil,
        serialNumber: String? = nil,
        firstDate: String? = nil,
        firstText: NSAttributedString? = nil,
        secondText: NSAttributedString? = nil,
        thirdText: NSAttributedString? = nil,
        fourthText: NSAttributedString? = nil,
        fifthText: String? = nil,
        secondDate: String? = nil
    ) {
        self.hideAnimationSkeleton()
        if let image = image {
            self.containerMaintenanceImageView.isHidden = false
            self.maintenanceImageView.loadImageUrl(image)
        }
        
        if let serialNumber = serialNumber {
            self.containerFirstHorizontalTextStackView.isHidden = false
            self.serialNumberLabel.isHidden = false
            self.serialNumberLabel.text = serialNumber
        }
        
        if let firstDate = firstDate {
            self.containerFirstHorizontalTextStackView.isHidden = false
            self.firstDateLabel.isHidden = false
            self.firstDateLabel.text = firstDate
        }
        
        if let firstText = firstText {
            self.firstLabel.isHidden = false
            self.firstLabel.attributedText = firstText
        }
        
        if let secondText = secondText {
            self.secondLabel.isHidden = false
            self.secondLabel.attributedText = secondText
        }
        
        if let thirdText = thirdText {
            self.thirdLabel.isHidden = false
            self.thirdLabel.attributedText = thirdText
        }
        
        if let fourthText = fourthText {
            self.fourthLabel.isHidden = false
            self.fourthLabel.attributedText = fourthText
        }
        
        if let fifthText = fifthText {
            self.containerSecondHorizontalTextStackView.isHidden = false
            self.fifthLabel.isHidden = false
            self.fifthLabel.text = fifthText
        }
        
        if let secondDate = secondDate {
            self.containerSecondHorizontalTextStackView.isHidden = false
            self.secondDateLabel.isHidden = false
            self.secondDateLabel.text = secondDate
        }
    }
    
    private func showAnimationSkeleton() {
        [self.maintenanceImageView,
         self.serialNumberLabel,
         self.firstDateLabel,
         self.firstLabel,
         self.secondLabel,
         self.thirdLabel,
         self.fourthLabel,
         self.fifthLabel,
         self.secondDateLabel].forEach {
            $0.isSkeletonable = true
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideAnimationSkeleton() {
        [self.maintenanceImageView,
         self.serialNumberLabel,
         self.firstDateLabel,
         self.firstLabel,
         self.secondLabel,
         self.thirdLabel,
         self.fourthLabel,
         self.fifthLabel,
         self.secondDateLabel].forEach {
            $0.hideSkeleton()
        }
    }
    
}
