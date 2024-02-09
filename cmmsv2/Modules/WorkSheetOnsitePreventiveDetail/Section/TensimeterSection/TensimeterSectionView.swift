//
//  TensimeterSectionView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/02/24.
//

import UIKit

class TensimeterSectionView: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var detailInformationCardView: UIView!
    @IBOutlet weak var uniqueNumberLabel: UILabel!
    @IBOutlet weak var dateUserLabel: UILabel!
    @IBOutlet weak var firstStatusView: UIView!
    @IBOutlet weak var firstStatusLabel: UILabel!
    @IBOutlet weak var secondStatusView: UIView!
    @IBOutlet weak var secondStatusLabel: UILabel!
    @IBOutlet weak var containerCategoryView: UIStackView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var serialNumberView: InformationCardView!
    @IBOutlet weak var brandView: InformationCardView!
    @IBOutlet weak var typeView: InformationCardView!
    @IBOutlet weak var installationView: InformationCardView!
    @IBOutlet weak var roomView: InformationCardView!
    @IBOutlet weak var customHeader: CustomHeaderView!
    
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
        configureSharedComponent()
    }
    
}

extension TensimeterSectionView {
    
    private func configureSharedComponent() {
        containerView.makeCornerRadius(8)
        containerView.addShadow(4, opacity: 0.2)
        
        detailInformationCardView.makeCornerRadius(8)
        detailInformationCardView.addShadow(4, opacity: 0.2)
        
        firstStatusView.makeCornerRadius(4)
        secondStatusView.makeCornerRadius(4)
        
        customHeader.configure(icon: "ic_notes_board", title: "Tensimeter", type: .plainWithoutSeparator)
    }
    
    func configure(data: TensimeterModel, type: WorkSheetOnsitePreventiveDetailType) {
        switch type {
        case .seeOnly:
            statusLabel.isHidden = false
            containerCategoryView.isHidden = false
        case .workContinue:
            statusLabel.isHidden = true
            containerCategoryView.isHidden = true
        }
        
        uniqueNumberLabel.text = data.uniqueNumber
        dateUserLabel.text = "\(data.user) • \(data.date)"
        firstStatusLabel.text = data.firstStatus
        secondStatusLabel.text = data.secondStatus
        serialNumberView.configureView(title: "Serial Number", value: data.serialNumber)
        brandView.configureView(title: "Merk", value: data.brand)
        typeView.configureView(title: "Tipe", value: data.type)
        installationView.configureView(title: "Instalasi", value: data.installation)
        roomView.configureView(title: "Ruangan", value: data.room)
    }
    
}
