//
//  AssetCVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 10/02/24.
//

import UIKit
import SkeletonView

class AssetCVC: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var markView: UIView!
    @IBOutlet weak var assetBadgeView: UIView!
    @IBOutlet weak var assetBadgeLabel: UILabel!
    @IBOutlet weak var assetImageView: UIImageView!
    @IBOutlet weak var technicalBadgeView: UIView!
    @IBOutlet weak var assetLabel: UILabel!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var inventarisLabel: UILabel!
    @IBOutlet weak var containerCategoryStackView: UIStackView!
    @IBOutlet weak var calibrationCategoryView: UIView!
    @IBOutlet weak var correctiveCategoryView: UIView!
    @IBOutlet weak var preventiveCategoryView: UIView!
    
    static let identifier = String(describing: AssetCVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureSharedComponent()
        self.setupCategoryViewWidth()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.setupSkeleton()
    }
    
}

extension AssetCVC {
    
    private func configureSharedComponent() {
        self.makeCornerRadius(8)
        self.containerView.makeCornerRadius(8)
        self.containerView.addShadow(4, position: .bottom, opacity: 0.2)
        self.markView.makeCornerRadius(2)
        self.assetImageView.makeCornerRadius(8)
        self.technicalBadgeView.makeCornerRadius(4)
        self.assetBadgeView.makeCornerRadius(4)
        self.assetBadgeView.addShadow(8, color: UIColor.customPrimaryColor.cgColor, opacity: 0.4)
        self.assetBadgeLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        self.calibrationCategoryView.makeCornerRadius(4)
        self.preventiveCategoryView.makeCornerRadius(4)
        self.correctiveCategoryView.makeCornerRadius(4)
        self.assetBadgeView.makeCornerRadius(4, .leftCurve)
        self.containerCategoryStackView.distribution = .fillProportionally
        self.assetLabel.textAlignment = .left
    }
    
    private func setupSkeleton() {
        [assetImageView,
         assetLabel,
         serialNumberLabel,
         technicalBadgeView,
         assetBadgeView,
         inventarisLabel,
         calibrationCategoryView,
         correctiveCategoryView,
         preventiveCategoryView].forEach {
            $0.isSkeletonable = true
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideSkeletonAnimation() {
        [assetImageView,
         assetLabel,
         serialNumberLabel,
         technicalBadgeView,
         assetBadgeView,
         inventarisLabel,
         calibrationCategoryView,
         correctiveCategoryView,
         preventiveCategoryView].forEach {
            $0.hideSkeleton()
        }
    }
    
    private func setupCategoryViewWidth() {
        let categoryWidth: CGFloat = 65
        [calibrationCategoryView, correctiveCategoryView, preventiveCategoryView].forEach { categoryView in
            categoryView.widthAnchor.constraint(equalToConstant: categoryWidth).isActive = true
        }
    }
    
    func setupCell(data: Equipment) {
        self.hideSkeletonAnimation()
        assetImageView.loadImageUrl(data.valImage ?? "")
        assetLabel.text = data.txtName ?? ""
        serialNumberLabel.text = "SN: \(data.txtSerial ?? "")"
        technicalBadgeView.isHidden = data.badgeTeknis == "0"
        assetBadgeView.isHidden = data.badgeAsset == "0"
        
        if let inventaris = data.txtInventaris, !inventaris.isEmpty {
            inventarisLabel.isHidden = false
            inventarisLabel.text = inventaris
        } else {
            inventarisLabel.isHidden = true
        }
        
        if let calibration = data.txtKalibrasi, !calibration.isEmpty {
            calibrationCategoryView.isHidden = false
        } else {
            calibrationCategoryView.isHidden = true
        }
        
        if let corrective = data.txtKorektif, !corrective.isEmpty {
            correctiveCategoryView.isHidden = false
        } else {
            correctiveCategoryView.isHidden = true
        }
        
        if let preventive = data.txtPreventif, !preventive.isEmpty {
            preventiveCategoryView.isHidden = false
        } else {
            preventiveCategoryView.isHidden = true
        }
    }
    
}
