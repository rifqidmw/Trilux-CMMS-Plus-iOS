//
//  WorkSheetOnsitePreventiveDetailView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/02/24.
//

import UIKit
import SkeletonView

class WorkSheetDetailView: BaseViewController {
    
    @IBOutlet weak var navigationView: CustomNavigationView!
    @IBOutlet weak var assetSectionView: AssetSectionView!
    @IBOutlet weak var assetSectionHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var preparationSectionView: AccordionView!
    @IBOutlet weak var preparationSectionHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var calibrationMeasurementSectionView: AccordionView!
    @IBOutlet weak var calibrationSectionHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var physicalMonitoringSectionView: AccordionView!
    @IBOutlet weak var physicalMonitoringHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var preventiveSectionView: AccordionView!
    @IBOutlet weak var preventiveHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var electricSectionView: AccordionView!
    @IBOutlet weak var electricSectionHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var taskSectionView: AccordionView!
    @IBOutlet weak var taskSectionHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sparePartSectionView: AccordionView!
    @IBOutlet weak var sparePartHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var addSparePartView: CustomHeaderView!
    
    @IBOutlet weak var recommendationStackView: UIStackView!
    @IBOutlet weak var recommendationHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var recommendationHeaderView: CustomHeaderView!
    @IBOutlet weak var recommendationView: UIView!
    @IBOutlet weak var recommendationLabel: UILabel!
    
    @IBOutlet weak var supportingEvidenceView: UIView!
    @IBOutlet weak var supportingEvidenceHeaderView: CustomHeaderView!
    @IBOutlet weak var emptyEvidenceView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var containerCalibratorStackView: UIStackView!
    @IBOutlet weak var headerCalibratorView: CustomHeaderView!
    @IBOutlet weak var calibratorView: InformationCardView!
    
    @IBOutlet weak var calibrationStatusStackView: UIStackView!
    @IBOutlet weak var calibrationStatusHeaderView: CustomHeaderView!
    @IBOutlet weak var calibrationStatusView: InformationCardView!
    
    var preparationView = PreparationSectionView()
    var calibrationView = CalibrationSectionView()
    var physicalMonitoringView = PhysicalMonitoringSectionView()
    var preventiveView = PreventiveSectionView()
    var electricView = ElectricSectionView()
    var taskView = TaskSectionView()
    var sparePartView = SparePartSectionView()
    
    var medias: [LKData.Lkphoto] = []
    var calibrators: [Kalibrator] = []
    var presenter: WorkSheetDetailPresenter?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.validateUser()
    }
    
}

extension WorkSheetDetailView {
    
    private func setupBody() {
        showAnimationSkeleton()
        fetchInitialData()
        bindingHeight()
        bindingData()
        setupView()
        setupAction()
        setupDelegate()
        setupCollectionView()
    }
    
    private func setupView() {
        navigationView.configure(toolbarTitle: "Detail Lembar Kerja", type: .plain)
        addSparePartView.configure(icon:"ic_document_with_gear", title: "Kebutuhan Suku Cadang", labelAction: "Tambah Suku Cadang", type: .actionLabel)
        addSparePartView.makeCornerRadius(8)
        addSparePartView.addShadow(2, opacity: 0.2)
        recommendationStackView.makeCornerRadius(8)
        recommendationStackView.addShadow(2, opacity: 0.2)
        recommendationHeaderView.configure(icon: "ic_statistic_down", title: "Evaluasi & Rekomendasi", type: .plain)
        recommendationView.makeCornerRadius(8)
        recommendationView.addBorder(width: 1.0, colorBorder: UIColor.customSecondaryColor)
        supportingEvidenceView.makeCornerRadius(8)
        supportingEvidenceView.addShadow(2, opacity: 0.2)
        supportingEvidenceHeaderView.configure(icon: "ic_image",title: "Foto Pendukung", type: .plain)
        
        containerCalibratorStackView.makeCornerRadius(8)
        containerCalibratorStackView.addShadow(2, opacity: 0.2)
        headerCalibratorView.configure(icon: "ic_infinity", title: "Kalibrator", type: .plain)
        
        calibrationStatusStackView.makeCornerRadius(8)
        calibrationStatusStackView.addShadow(2, opacity: 0.2)
        calibrationStatusHeaderView.configure(icon: "ic_check_outline", title: "Status Kalibrasi", type: .plain)
    }
    
    private func setupDelegate() {
        self.sparePartView.delegate = self
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EvidenceEquipmentCVC.nib, forCellWithReuseIdentifier: EvidenceEquipmentCVC.identifier)
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
    
    private func fetchInitialData() {
        guard let presenter else { return }
        presenter.fetchInitialData()
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$monitoringFunctionData
            .sink { [weak self ] data in
                guard let self,
                      let data,
                      let detail = data.data,
                      let reff = data.reff,
                      let preparation = detail.persiapan,
                      let calibration = detail.alatKalibrasi,
                      let monitoring = detail.pemantauan,
                      let preventive = detail.preventif,
                      let electric = detail.listrik,
                      let task = detail.task,
                      let sparePart = detail.sparepart,
                      let info = detail.lkInfo,
                      let evidence = detail.lkphoto,
                      let idKalibrator = detail.idKalibrator,
                      let listCalibration = reff.sttKalibrasi,
                      let laikStatus = detail.sttLaik
                else { return }
                self.hideAnimationSkeleton()
                
                self.assetSectionView.configure(data: detail, reff: reff)
                self.assetSectionHeightConstraint.constant = self.assetSectionView.initialContentHeightConstraint.constant
                self.assetSectionView.layoutIfNeeded()
                
                self.preparationView.configure(data: preparation)
                self.preparationSectionView.configure(title: "Persiapan", icon: "ic_sheet_check", view: preparationView)
                
                self.calibrationView.configure(data: calibration)
                self.calibrationMeasurementSectionView.configure(title: "Pengukuran Kalibrasi", icon: "ic_infinity", view: calibrationView)
                
                self.physicalMonitoringView.configure(data: monitoring)
                self.physicalMonitoringSectionView.configure(title: "Pemantauan Fisik & Fungsi", icon: "ic_statistic_up", view: physicalMonitoringView)
                
                self.preventiveView.configure(data: preventive)
                self.preventiveSectionView.configure(title: "Pemeliharaan Preventif", icon: "ic_document_with_gear", view: preventiveView)
                
                self.electricView.configure(data: electric)
                self.electricSectionView.configure(title: "Pengukuran Keselamatan Listrik", icon: "ic_thunder", view: electricView)
                
                self.taskView.configure(data: task)
                self.taskSectionView.configure(title: "Tindakan", icon: "ic_board_with_clock", view: taskView)
                
                self.sparePartView.configure(data: sparePart)
                self.sparePartSectionView.configure(title: "Penggunaan Suku Cadang", icon: "ic_frame_with_gear", view: sparePartView)
                
                self.recommendationLabel.text = detail.lkInfo ?? "-"
                self.medias = evidence
                self.collectionView.reloadData()
                
                let calibratorId = calibrators.compactMap { $0.idKalibrator }
                if calibratorId.contains(idKalibrator) {
                    if let matchedCalibrator = calibrators.first(where: { $0.idKalibrator == idKalibrator }) {
                        let calibratorText = matchedCalibrator.name
                        self.calibratorView.titleLabel.isHidden = true
                        self.calibratorView.configureView(title: "", value: calibratorText ?? "-")
                    }
                } else {
                    self.calibratorView.titleLabel.isHidden = true
                    self.calibratorView.configureView(title: "", value: "Tidak ada data")
                }
                
                let calibrationStatusText = listCalibration.first { $0.key == laikStatus }?.value ?? "-"
                self.calibrationStatusView.titleLabel.isHidden = true
                self.calibrationStatusView.configureView(title: "", value: calibrationStatusText)
                
                self.preparationSectionView.isHidden = preparation.isEmpty
                self.calibrationMeasurementSectionView.isHidden = calibration.isEmpty
                self.physicalMonitoringSectionView.isHidden = monitoring.isEmpty
                self.preventiveSectionView.isHidden = preventive.isEmpty
                self.electricSectionView.isHidden = electric.isEmpty
                self.taskSectionView.isHidden = task.isEmpty
                self.sparePartSectionView.isHidden = sparePart.isEmpty
                self.recommendationStackView.isHidden = info.isEmpty
                self.emptyEvidenceView.isHidden = !evidence.isEmpty
                self.collectionView.isHidden = evidence.isEmpty
                self.containerCalibratorStackView.isHidden = idKalibrator.isEmpty
                self.calibrationStatusStackView.isHidden = laikStatus.isEmpty
                
                let isCalibratorVisible = presenter.type == .calibration
                containerCalibratorStackView.isHidden = !isCalibratorVisible
                calibrationStatusStackView.isHidden = !isCalibratorVisible
            }
            .store(in: &anyCancellable)
        
        presenter.$calibratorList
            .sink { [weak self] data in
                guard let self else { return }
                self.calibrators = data
            }
            .store(in: &anyCancellable)
    }
    
    private func bindingHeight() {
        preparationSectionView.$totalHeightTable
            .receive(on: DispatchQueue.main)
            .sink { [weak self] height in
                guard let self else { return }
                self.preparationSectionHeightConstraint.constant = height
                self.preparationSectionView.layoutIfNeeded()
            }
            .store(in: &anyCancellable)
        
        calibrationMeasurementSectionView.$totalHeightTable
            .receive(on: DispatchQueue.main)
            .sink { [weak self] height in
                guard let self else { return }
                self.calibrationSectionHeightConstraint.constant = height
                self.calibrationMeasurementSectionView.layoutIfNeeded()
            }
            .store(in: &anyCancellable)
        
        physicalMonitoringSectionView.$totalHeightTable
            .receive(on: DispatchQueue.main)
            .sink { [weak self] height in
                guard let self else { return }
                self.physicalMonitoringHeightConstraint.constant = height
                self.physicalMonitoringSectionView.layoutIfNeeded()
            }
            .store(in: &anyCancellable)
        
        preventiveSectionView.$totalHeightTable
            .receive(on: DispatchQueue.main)
            .sink { [weak self] height in
                guard let self else { return }
                self.preventiveHeightConstraint.constant = height
                self.preventiveSectionView.layoutIfNeeded()
            }
            .store(in: &anyCancellable)
        
        electricSectionView.$totalHeightTable
            .receive(on: DispatchQueue.main)
            .sink { [weak self] height in
                guard let self else { return }
                self.electricSectionHeightConstraint.constant = height
                self.electricSectionView.layoutIfNeeded()
            }
            .store(in: &anyCancellable)
        
        taskSectionView.$totalHeightTable
            .receive(on: DispatchQueue.main)
            .sink { [weak self] height in
                guard let self else { return }
                self.taskSectionHeightConstraint.constant = height
                self.taskSectionView.layoutIfNeeded()
            }
            .store(in: &anyCancellable)
        
        sparePartSectionView.$totalHeightTable
            .receive(on: DispatchQueue.main)
            .sink { [weak self] height in
                guard let self else { return }
                self.sparePartHeightConstraint.constant = height
                self.sparePartSectionView.layoutIfNeeded()
            }
            .store(in: &anyCancellable)
    }
    
}

extension WorkSheetDetailView {
    
    private func showAnimationSkeleton() {
        [self.assetSectionView.customHeader.iconImageView,
         self.preparationSectionView,
         self.calibrationMeasurementSectionView,
         self.physicalMonitoringSectionView,
         self.preventiveSectionView,
         self.electricSectionView,
         self.taskSectionView,
         self.calibratorView.valueLabel,
         self.calibrationStatusView.valueLabel,
         self.recommendationLabel].forEach {
            $0.isSkeletonable = true
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideAnimationSkeleton() {
        [self.assetSectionView.customHeader.iconImageView,
         self.preparationSectionView,
         self.calibrationMeasurementSectionView,
         self.physicalMonitoringSectionView,
         self.preventiveSectionView,
         self.electricSectionView,
         self.taskSectionView,
         self.calibratorView.valueLabel,
         self.calibrationStatusView.valueLabel,
         self.recommendationLabel].forEach {
            $0.hideSkeleton()
        }
    }
    
}
