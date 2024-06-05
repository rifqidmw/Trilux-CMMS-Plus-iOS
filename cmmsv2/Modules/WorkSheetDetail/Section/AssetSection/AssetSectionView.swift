//
//  TensimeterSectionView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/02/24.
//

import UIKit
import SkeletonView

class AssetSectionView: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var detailInformationCardView: UIView!
    @IBOutlet weak var uniqueNumberLabel: UILabel!
    @IBOutlet weak var dateUserLabel: UILabel!
    @IBOutlet weak var containerWorkingStatusView: UIView!
    @IBOutlet weak var workingStatusView: UIView!
    @IBOutlet weak var workingStatusLabel: UILabel!
    @IBOutlet weak var workingStatusWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerWorkSheetView: UIView!
    @IBOutlet weak var workSheetStatusView: UIView!
    @IBOutlet weak var workSheetStatusLabel: UILabel!
    @IBOutlet weak var workSheetStatusWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var serialNumberView: InformationCardView!
    @IBOutlet weak var serialNumberViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerBrandTypeStackView: UIStackView!
    @IBOutlet weak var brandView: InformationCardView!
    @IBOutlet weak var typeView: InformationCardView!
    @IBOutlet weak var brandTypeHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var installationView: InformationCardView!
    @IBOutlet weak var installationViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var roomView: InformationCardView!
    @IBOutlet weak var roomViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var customHeader: CustomHeaderView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var initialContentHeightConstraint: NSLayoutConstraint!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        let view = loadNib()
        view.frame = self.bounds
        self.addSubview(view)
        self.configureSharedComponent()
        self.showAnimationSkeleton()
    }
    
}

extension AssetSectionView {
    
    private func configureSharedComponent() {
        containerView.makeCornerRadius(8)
        containerView.addShadow(2, opacity: 0.2)
        
        detailInformationCardView.makeCornerRadius(8)
        detailInformationCardView.addShadow(2, opacity: 0.2)
        
        workingStatusView.makeCornerRadius(4)
        workSheetStatusView.makeCornerRadius(4)
    }
    
    func configure(data: LKData, reff: References) {
        hideAnimationSkeleton()
        
        let workingStatus = reff.status?.first { $0.key == data.lkStatus }?.value ?? "-"
        let finishStatus = reff.finishStatus?.first { $0.key == data.lkFinishstt }?.value ?? "-"
        
        customHeader.configure(icon: "ic_notes_board", title: data.asset?.assetname ?? "-", type: .plainWithoutSeparator)
        uniqueNumberLabel.text = data.lkNumber ?? "-"
        dateUserLabel.text = "\(data.engineername ?? "-") • \(data.lkDate ?? "-")"
        serialNumberView.configureView(title: "Serial Number", value: data.asset?.serial ?? "-")
        brandView.configureView(title: "Merk", value: data.asset?.brandname ?? "-")
        typeView.configureView(title: "Tipe", value: data.asset?.typename ?? "-")
        installationView.configureView(title: "Instalasi", value: data.asset?.sarananame ?? "-")
        roomView.configureView(title: "Ruangan", value: data.asset?.roomname ?? "-")
        
        configureWorkingStatus(status: WorkSheetStatus(rawValue: workingStatus) ?? WorkSheetStatus.none)
        configureFinishStatus(status: WorkSheetFinishStatus(rawValue: finishStatus) ?? WorkSheetFinishStatus.none)
        
        let roomHeight = 58 + roomView.valueLabel.requiredHeight()
        let serialHeight = 58 + serialNumberView.valueLabel.requiredHeight()
        let brandHeight = 58 + typeView.valueLabel.requiredHeight()
        let installationHeight = 58 + installationView.valueLabel.requiredHeight()
        let headerHeight = headerHeightConstraint.constant
        
        roomViewHeightConstraint.constant = roomHeight
        serialNumberViewHeightConstraint.constant = serialHeight
        brandTypeHeightConstraint.constant = brandHeight
        installationViewHeightConstraint.constant = installationHeight
        
        roomView.layoutIfNeeded()
        serialNumberView.layoutIfNeeded()
        brandView.layoutIfNeeded()
        typeView.layoutIfNeeded()
        containerBrandTypeStackView.layoutIfNeeded()
        installationView.layoutIfNeeded()
        detailInformationCardView.layoutIfNeeded()
        
        let increaseHeight = roomHeight + serialHeight + brandHeight + installationHeight + headerHeight
        
        initialContentHeightConstraint.constant = 210 + increaseHeight
        
        self.layoutIfNeeded()
    }
    
}

extension AssetSectionView {
    
    private func configureWorkingStatus(status: WorkSheetStatus) {
        workingStatusLabel.text = status.getStringValue()
        
        switch status {
        case .done:
            workingStatusView.backgroundColor = UIColor.customLightGreenColor
            workingStatusLabel.textColor = UIColor.customIndicatorColor8
            workingStatusWidthConstraint.constant = 160
        case .open:
            workingStatusView.backgroundColor = UIColor.customSecondaryColor
            workingStatusLabel.textColor = UIColor.customPrimaryColor
            workingStatusWidthConstraint.constant = 46
        case .ongoing:
            workingStatusView.backgroundColor = UIColor.customIndicatorColor2 
            workingStatusLabel.textColor = UIColor.customIndicatorColor11
            workingStatusWidthConstraint.constant = 130
        case .hold:
            workingStatusView.backgroundColor = UIColor.customIndicatorColor2
            workingStatusLabel.textColor = UIColor.customIndicatorColor11
            workingStatusWidthConstraint.constant = 100
        case .close:
            workingStatusView.backgroundColor = UIColor.customLightGreenColor
            workingStatusLabel.textColor = UIColor.customIndicatorColor8
            workingStatusWidthConstraint.constant = 46
        case .removed:
            workingStatusView.backgroundColor = UIColor.customIndicatorColor3
            workingStatusLabel.textColor = UIColor.customIndicatorColor4
            workingStatusWidthConstraint.constant = 220
        case .progressDelay:
            workingStatusView.backgroundColor = UIColor.customIndicatorColor2
            workingStatusLabel.textColor = UIColor.customIndicatorColor11
            workingStatusWidthConstraint.constant = 100
        case .progress:
            workingStatusView.backgroundColor = UIColor.customIndicatorColor2
            workingStatusLabel.textColor = UIColor.customIndicatorColor11
            workingStatusWidthConstraint.constant = 80
        case .draft:
            workingStatusView.backgroundColor = UIColor.customIndicatorColor2
            workingStatusLabel.textColor = UIColor.customIndicatorColor11
            workingStatusWidthConstraint.constant = 50
        case .none:
            containerWorkingStatusView.isHidden = true
        }
    }
    
    private func configureFinishStatus(status: WorkSheetFinishStatus) {
        workSheetStatusLabel.text = status.getStringValue()
        
        switch status {
        case .done:
            workSheetStatusView.backgroundColor = UIColor.customLightGreenColor
            workSheetStatusLabel.textColor = UIColor.customIndicatorColor8
            workSheetStatusWidthConstraint.constant = 46
        case .needSparePart:
            workSheetStatusView.backgroundColor = UIColor.customIndicatorColor2
            workSheetStatusLabel.textColor = UIColor.customIndicatorColor11
            workSheetStatusWidthConstraint.constant = 130
        case .none:
            containerWorkSheetView.isHidden = true
        }
    }
    
    private func showAnimationSkeleton() {
        [customHeader.titleLabel,
         uniqueNumberLabel,
         dateUserLabel,
         serialNumberView,
         brandView,
         typeView,
         installationView,
         roomView,
         workingStatusView,
         workSheetStatusView
        ].forEach {
            $0.isSkeletonable = true
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideAnimationSkeleton() {
        [customHeader.titleLabel,
         uniqueNumberLabel,
         dateUserLabel,
         serialNumberView,
         brandView,
         typeView,
         installationView,
         roomView,
         workingStatusView,
         workSheetStatusView
        ].forEach {
            $0.hideSkeleton()
        }
    }
    
}
