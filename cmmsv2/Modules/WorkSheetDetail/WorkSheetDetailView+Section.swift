//
//  WorkSheetDetailView+Section.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 03/07/24.
//

import UIKit

extension WorkSheetDetailView {
    
    func configureAssetSection(_ data: LKData, reff: References) {
        self.assetSectionView.configure(data: data, reff: reff)
        self.assetSectionHeightConstraint.constant = self.assetSectionView.initialContentHeightConstraint.constant
        self.assetSectionView.layoutIfNeeded()
    }
    
    func configurePreparationSection(_ data: [LKData.Persiapan], activity: WorkSheetActivityType) {
        self.preparationView.configure(data: data, activity: activity)
        self.preparationView.tableView.reloadData()
        self.preparationSectionView.isHidden = data.isEmpty
    }
    
    func configureCalibrationSection(_ data: [LKData.AlatKalibrasi]) {
        self.calibrationView.configure(data: data)
        self.calibrationView.tableView.reloadData()
        self.calibrationMeasurementSectionView.isHidden = data.isEmpty
    }
    
    func configurePhysicalMonitoringSection(_ data: [LKData.Pemantauan], activity: WorkSheetActivityType) {
        self.physicalMonitoringView.configure(data: data, activity: activity)
        self.physicalMonitoringSectionView.tableView.reloadData()
        self.physicalMonitoringSectionView.isHidden = data.isEmpty
    }
    
    func configurePreventiveSection(_ data: [LKData.Preventif], activity: WorkSheetActivityType) {
        self.preventiveView.configure(data: data, activity: activity)
        self.preventiveView.tableView.reloadData()
        self.preventiveSectionView.isHidden = data.isEmpty
    }
    
    func configureElectricSection(_ data: [LKData.Listrik], activity: WorkSheetActivityType) {
        self.electricView.configure(data: data)
        self.electricView.tableView.reloadData()
        self.electricInputView.data = data
        
        self.electricSectionView.isHidden = activity == .working || data.isEmpty
        self.electricInputSectionView.isHidden = activity == .view
    }
    
    func configureTaskSection(_ data: [LKData.Task], activity: WorkSheetActivityType) {
        self.taskView.configure(data: data)
        self.taskView.tableView.reloadData()
        
        self.taskSectionView.isHidden = activity == .working || data.isEmpty
        self.taskInputSectionView.isHidden = activity == .view
    }
    
    func configureSparePartSection(_ data: [LKData.Sparepart], activity: WorkSheetActivityType) {
        self.sparePartView.configure(data: data, activity: activity)
        self.sparePartView.tableView.reloadData()
        
        self.sparePartSectionView.isHidden = activity == .working || data.isEmpty
        self.usageSparePartSectionView.isHidden = activity == .view
        self.requirementSparePartSectionView.isHidden = activity == .view
    }
    
    func configureMediaSection(_ data: [LKData.Lkphoto], activity: WorkSheetActivityType) {
        self.mediaSectionView.configure(data: data, activity: activity)
    }
    
    func configureCalibratorSection(_ data: [Kalibrator], lkData: LKData, reff: References) {
        guard let presenter else { return }
        let isCalibratorVisible = presenter.type == .calibration
        
        let calibratorId = data.compactMap { $0.idKalibrator }
        if calibratorId.contains(lkData.idKalibrator ?? "") {
            if let matchedCalibrator = self.calibrators.first(where: { $0.idKalibrator == lkData.idKalibrator }) {
                let calibratorText = matchedCalibrator.name
                self.calibratorView.titleLabel.isHidden = true
                self.calibratorView.configureView(title: "", value: calibratorText ?? "-")
            }
        } else {
            self.calibratorView.titleLabel.isHidden = true
            self.calibratorView.configureView(title: "", value: "Tidak ada data")
        }
        
        let calibrationStatusText = reff.sttKalibrasi?.first { $0.key == lkData.sttLaik }?.value ?? "-"
        self.calibrationStatusView.titleLabel.isHidden = true
        self.calibrationStatusView.configureView(title: "", value: calibrationStatusText)
        
        self.containerCalibratorStackView.isHidden = data.isEmpty || !isCalibratorVisible
        self.calibrationStatusStackView.isHidden = lkData.sttLaik?.isEmpty ?? false || !isCalibratorVisible
    }
    
    func configureRecommendationEvaluation(_ info: String, activity: WorkSheetActivityType) {
        self.recommendationLabel.text = info
        self.recommendationStackView.isHidden = info.isEmpty
        self.containerRecommendationView.isHidden = activity == .working ? true : false
        self.containerInputRecommendationView.isHidden = activity == .view ? true : false
    }
    
}
