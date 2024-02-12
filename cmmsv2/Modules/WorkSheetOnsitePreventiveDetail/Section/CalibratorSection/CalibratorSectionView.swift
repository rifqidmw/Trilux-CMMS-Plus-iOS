//
//  CalibratorSectionView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 06/02/24.
//

import UIKit

class CalibratorSectionView: UIView {
    
    @IBOutlet weak var customHeaderView: CustomHeaderView!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var seeOnlyCalibrationView: UIView!
    @IBOutlet weak var continueCalibrationView: UIView!
    @IBOutlet weak var multimeterView: CalibrationMeasurementView!
    @IBOutlet weak var phantomEcgView: CalibrationMeasurementView!
    
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

extension CalibratorSectionView {
    
    private func configureSharedComponent() {
        containerView.makeCornerRadius(8)
        containerView.addShadow(4, opacity: 0.2)
    }
    
    func configure(
        dataMultimeter: [MeasurementModel]? = nil,
        dataPhantom: [MeasurementModel]? = nil,
        type: WorkSheetOnsitePreventiveDetailType) {
            let typeCondition = type == .seeOnly
            customHeaderView.configure(
                icon: "ic_infinity",
                title: typeCondition ? "Kalibrator" : "Pengukuran Kalibrasi",
                labelAction: "Tambah Alat",
                type: typeCondition ? .collapsibleAction : .actionLabel)
            
            switch type {
            case .seeOnly:
                seeOnlyCalibrationView.isHidden = false
            case .workContinue:
                continueCalibrationView.isHidden = false
                multimeterView.configureTitle(title: "Multimeter")
                multimeterView.data = dataMultimeter ?? []
                
                phantomEcgView.configureTitle(title: "Phantom ECG")
                phantomEcgView.data = dataPhantom ?? []
            }
        }
    
}
