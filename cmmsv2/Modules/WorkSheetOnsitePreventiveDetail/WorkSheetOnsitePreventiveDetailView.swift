//
//  WorkSheetOnsitePreventiveDetailView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/02/24.
//

import UIKit

class WorkSheetOnsitePreventiveDetailView: BaseViewController {
    
    @IBOutlet weak var navigationView: CustomNavigationView!
    @IBOutlet weak var tensimeterSectionView: TensimeterSectionView!
    @IBOutlet weak var tensimeterHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var calibratorSectionView: CalibratorSectionView!
    @IBOutlet weak var calibratorSectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var preparationSectionView: PreparationSectionView!
    @IBOutlet weak var preparationSectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var calibrationMeasurementSectionView: CalibratorSectionView!
    @IBOutlet weak var calibrationMeasurementHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var physicalFunctionalView: PhysicalFunctionalMonitoringView!
    @IBOutlet weak var physicalFunctionalHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var preventiveMaintenanceView: PreventiveMaintenanceView!
    @IBOutlet weak var preventiveMaintenanceHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var electricalMeasurementView: ElectricalMeasurementView!
    @IBOutlet weak var electricalMeasurementHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var actionSectionView: ActionSectionView!
    @IBOutlet weak var actionSectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectCalibratorSectionView: SelectCalibratorView!
    @IBOutlet weak var selectCalibrationHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sparePartSectionView: SparePartSectionView!
    @IBOutlet weak var sparePartHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var recommendationSectionView: RecommendationSectionView!
    @IBOutlet weak var recommendationSectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var supportingDocumentationView: SupportingDocumentationView!
    @IBOutlet weak var supportingDocumentationHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var calibrationStatusView: CalibrationStatusView!
    @IBOutlet weak var calibrationStatusHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var workingStatusView: CalibrationStatusView!
    @IBOutlet weak var workingStatusHeightConstraint: NSLayoutConstraint!
    
    var presenter: WorkSheetOnsitePreventiveDetailPresenter?
    
    // MARK: - DUMMY PROPERTIES
    var dataTensimeter: TensimeterModel = tensimeterData
    var dataMultimeter: [MeasurementModel] = multimeterData
    var dataPhantomECG: [MeasurementModel] = phantomEGCData
    var dataPreparation: [PreparationModel] = preparationData
    var dataLabel: [String] = labelData
    var dataPhysical: [PreparationStatus] = physicalData
    var dataFunctional: [PreparationStatus] = functionalData
    var dataPreventiveMaintenance: [PreparationModel] = preventiveMaintenanceData
    var dataElectricalMeasurement: [ElectricalMeasurementModel] = electricalMeasurementData
    var dataAction: [ActionModel] = actionData
    var dataSparePart: [SparePartModel] = sparePartData
    var dataDocumentation: [Media] = dummyEvidenceEquipment
    
    override func didLoad() {
        super.didLoad()
        setupBody()
    }
    
}

extension WorkSheetOnsitePreventiveDetailView {
    
    private func setupBody() {
        setupView()
        configureSectionHeight()
        setupAction()
    }
    
    private func setupView() {
        guard let presenter else { return }
        navigationView.configure(plainTitle: "Lembar Kerja Onsite Preventif", type: .plain)
        tensimeterSectionView.configure(data: self.dataTensimeter, type: presenter.type)
        calibratorSectionView.configure(
            dataMultimeter: multimeterData,
            dataPhantom: phantomEGCData,
            type: presenter.type)
        preparationSectionView.configure(data: dataPreparation, type: presenter.type)
        calibrationMeasurementSectionView.configure(
            dataMultimeter: multimeterData,
            dataPhantom: phantomEGCData,
            type: .workContinue)
        calibrationMeasurementSectionView.isHidden = presenter.type == .workContinue
        calibrationMeasurementSectionView.customHeaderView.configure(icon: "ic_infinity", title: "Pengukuran Kalibrasi", type: .plain)
        calibrationMeasurementSectionView.multimeterView.containerButtonStackView.isHidden = presenter.type == .seeOnly
        calibrationMeasurementSectionView.phantomEcgView.containerButtonStackView.isHidden = presenter.type == .seeOnly
        physicalFunctionalView.configure(
            labelData: dataLabel,
            physicalData: dataPhysical,
            functionalData: dataFunctional,
            type: presenter.type)
        preventiveMaintenanceView.configure(data: dataPreventiveMaintenance, type: presenter.type)
        electricalMeasurementView.configure(data: dataElectricalMeasurement, type: presenter.type)
        selectCalibratorSectionView.isHidden = presenter.type == .seeOnly
        actionSectionView.configure(data: dataAction, type: presenter.type)
        sparePartSectionView.configure(data: dataSparePart, type: presenter.type)
        recommendationSectionView.configure(type: presenter.type, text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
        supportingDocumentationView.configure(data: dataDocumentation, type: presenter.type)
        calibrationStatusView.configure(type: presenter.type, status: "Laik", title: "Status Kalibrasi")
        workingStatusView.configure(type: presenter.type, status: "Selesai, Bisa digunakan kembali", title: "Status Pekerjaan")
        workingStatusView.isHidden = presenter.type == .seeOnly
    }
    
    private func configureSectionHeight() {
        guard let presenter else { return }
        let seeOnlyCondition = presenter.type == .seeOnly
        calibratorSectionHeightConstraint.constant = seeOnlyCondition ? 144 : 555
        preparationSectionHeightConstraint.constant = seeOnlyCondition ? 400 : 435
        calibratorSectionHeightConstraint.constant = seeOnlyCondition ? 400 : 500
        calibrationMeasurementHeightConstraint.constant = seeOnlyCondition ? 300 : 500
        electricalMeasurementHeightConstraint.constant = seeOnlyCondition ? 400 : 2100
    }
    
    private func setupAction() {
        navigationView.arrowLeftBackButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                navigation.popViewController(animated: true)
            }
            .store(in: &anyCancellable)
    }
    
}
