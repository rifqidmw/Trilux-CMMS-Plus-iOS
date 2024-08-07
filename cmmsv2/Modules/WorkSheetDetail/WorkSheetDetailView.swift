//
//  WorkSheetOnsitePreventiveDetailView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/02/24.
//

import UIKit
import SkeletonView

protocol WorkSheetDetailViewDelegate: AnyObject {
    func didSaveWorkSheet()
}

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
    
    @IBOutlet weak var electricInputSectionView: AccordionView!
    @IBOutlet weak var electricInputSectionHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var taskSectionView: AccordionView!
    @IBOutlet weak var taskSectionHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var taskInputSectionView: UIStackView!
    @IBOutlet weak var initialTaskInputHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var taskInputHeaderView: CustomHeaderView!
    @IBOutlet weak var addTaskSectionView: AddTaskSectionView!
    
    @IBOutlet weak var sparePartSectionView: AccordionView!
    @IBOutlet weak var sparePartHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var usageSparePartSectionView: UIStackView!
    @IBOutlet weak var initialUsageSparePartHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var usageSparePartHeaderView: CustomHeaderView!
    @IBOutlet weak var addUsageSparePartSectionView: SparePartSectionView!
    
    @IBOutlet weak var requirementSparePartSectionView: UIStackView!
    @IBOutlet weak var initialRequirementSparePartHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var requirementSparePartHeaderView: CustomHeaderView!
    @IBOutlet weak var addRequirementSparePartSectionView: SparePartSectionView!
    
    @IBOutlet weak var recommendationStackView: UIStackView!
    @IBOutlet weak var recommendationHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var recommendationHeaderView: CustomHeaderView!
    
    @IBOutlet weak var containerRecommendationView: UIView!
    @IBOutlet weak var recommendationView: UIView!
    @IBOutlet weak var recommendationLabel: UILabel!
    
    @IBOutlet weak var containerInputRecommendationView: UIView!
    @IBOutlet weak var containerInputRecommendationTextView: UIView!
    @IBOutlet weak var inputRecommendationTextField: UITextField!
    
    @IBOutlet weak var containerMediaSectionStackView: UIStackView!
    @IBOutlet weak var headerMediaView: CustomHeaderView!
    @IBOutlet weak var containerMediaSectionView: UIView!
    @IBOutlet weak var mediaSectionView: MediaSectionView!
    
    @IBOutlet weak var containerCalibratorStackView: UIStackView!
    @IBOutlet weak var headerCalibratorView: CustomHeaderView!
    @IBOutlet weak var calibratorView: InformationCardView!
    
    @IBOutlet weak var containerActionButton: UIStackView!
    @IBOutlet weak var cancelButton: GeneralButton!
    @IBOutlet weak var saveButton: GeneralButton!
    
    @IBOutlet weak var selectStatusContainerStackView: UIStackView!
    @IBOutlet weak var selectStatusHeaderView: CustomHeaderView!
    @IBOutlet weak var containerSelectStatusView: UIView!
    @IBOutlet weak var selectStatusSectionView: StatusSection!
    @IBOutlet weak var selectStatusHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var calibrationStatusStackView: UIStackView!
    @IBOutlet weak var calibrationStatusHeaderView: CustomHeaderView!
    @IBOutlet weak var calibrationStatusView: InformationCardView!
    
    var preparationView = PreparationSectionView()
    var calibrationView = CalibrationSectionView()
    var physicalMonitoringView = PhysicalMonitoringSectionView()
    var preventiveView = PreventiveSectionView()
    var electricView = ElectricSectionView()
    var electricInputView = ElectricInputSectionView()
    var taskView = TaskSectionView()
    var sparePartView = SparePartSectionView()
    
    var calibrators: [Kalibrator] = []
    var selectedSparePart: SearchSparePartData?
    var selectedSparePartType: SparePartType?
    var media: MediaEntity?
    var lkData: LKData?
    var presenter: WorkSheetDetailPresenter?
    
    weak var delegate: WorkSheetDetailViewDelegate?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.validateUser()
    }
    
}

extension WorkSheetDetailView {
    
    private func setupBody() {
        fetchInitialData()
        bindingHeight()
        bindingData()
        setupView()
        setupAction()
        configureTextField()
        configureSharedComponent()
    }
    
    private func fetchInitialData() {
        guard let presenter else { return }
        presenter.fetchInitialData()
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$isLoading
            .sink { [weak self] isLoading in
                guard let self else { return }
                isLoading ? self.showLoadingPopup() : self.hideLoadingPopup()
            }
            .store(in: &anyCancellable)
        
        presenter.$dataLK
            .sink { [weak self] data in
                guard let self else { return }
                self.lkData = data
                self.hideLoadingPopup()
            }
            .store(in: &anyCancellable)
        
        presenter.$monitoringFunctionData
            .sink { [weak self ] data in
                guard let self,
                      let data,
                      let detail = data.data,
                      let reff = data.reff,
                      let activity = presenter.activity
                else { return }
                self.hideLoadingPopup()
                self.configureRecommendationEvaluation(detail.lkInfo ?? "-", activity: activity)
                self.configureAssetSection(detail, reff: reff)
                self.configurePreparationSection(detail.persiapan ?? [], activity: activity)
                self.configureCalibrationSection(detail.alatKalibrasi ?? [])
                self.configurePhysicalMonitoringSection(detail.pemantauan ?? [], activity: activity)
                self.configurePreventiveSection(detail.preventif ?? [], activity: activity)
                self.configureElectricSection(detail.listrik ?? [], activity: activity)
                self.configureTaskSection(detail.task ?? [], activity: activity)
                self.configureSparePartSection(detail.sparepart ?? [], activity: activity)
                self.configureCalibratorSection(self.calibrators, lkData: detail, reff: reff)
                self.configureMediaSection(detail.lkphoto ?? [], activity: activity)
            }
            .store(in: &anyCancellable)
        
        presenter.$calibratorList
            .sink { [weak self] data in
                guard let self else { return }
                self.hideLoadingPopup()
                self.calibrators = data
            }
            .store(in: &anyCancellable)
        
        presenter.$saveWorkSheet
            .sink { [weak self] data in
                guard let self,
                      let data,
                      let delegate = self.delegate
                else { return }
                self.hideLoadingPopup()
                if data.message == "Success" {
                    delegate.didSaveWorkSheet()
                } else {
                    self.showAlert(title: "Terjadi Kesalahan", message: data.message)
                }
            }
            .store(in: &anyCancellable)
    }
    
    private func bindingHeight() {
        preparationSectionView.$totalHeightTable
            .sink { [weak self] height in
                guard let self else { return }
                self.preparationSectionHeightConstraint.constant = height
                self.preparationSectionView.layoutIfNeeded()
            }
            .store(in: &anyCancellable)
        
        calibrationMeasurementSectionView.$totalHeightTable
            .sink { [weak self] height in
                guard let self else { return }
                self.calibrationSectionHeightConstraint.constant = height
                self.calibrationMeasurementSectionView.layoutIfNeeded()
            }
            .store(in: &anyCancellable)
        
        physicalMonitoringSectionView.$totalHeightTable
            .sink { [weak self] height in
                guard let self else { return }
                self.physicalMonitoringHeightConstraint.constant = height
                self.physicalMonitoringSectionView.layoutIfNeeded()
            }
            .store(in: &anyCancellable)
        
        preventiveSectionView.$totalHeightTable
            .sink { [weak self] height in
                guard let self else { return }
                self.preventiveHeightConstraint.constant = height
                self.preventiveSectionView.layoutIfNeeded()
            }
            .store(in: &anyCancellable)
        
        electricSectionView.$totalHeightTable
            .sink { [weak self] height in
                guard let self else { return }
                self.electricSectionHeightConstraint.constant = height
                self.electricSectionView.layoutIfNeeded()
            }
            .store(in: &anyCancellable)
        
        taskSectionView.$totalHeightTable
            .sink { [weak self] height in
                guard let self else { return }
                self.taskSectionHeightConstraint.constant = height
                self.taskSectionView.layoutIfNeeded()
            }
            .store(in: &anyCancellable)
        
        sparePartSectionView.$totalHeightTable
            .sink { [weak self] height in
                guard let self else { return }
                self.sparePartHeightConstraint.constant = height
                self.sparePartSectionView.layoutIfNeeded()
            }
            .store(in: &anyCancellable)
        
        electricInputSectionView.$totalHeightTable
            .sink { [weak self] height in
                guard let self else { return }
                self.electricInputSectionHeightConstraint.constant = height
                self.electricInputSectionView.layoutIfNeeded()
            }
            .store(in: &anyCancellable)
        
        addTaskSectionView.$totalHeightTable
            .sink { [weak self] height in
                guard let self else { return }
                self.initialTaskInputHeightConstraint.constant = height + 48
                self.addTaskSectionView.layoutIfNeeded()
            }
            .store(in: &anyCancellable)
        
        addUsageSparePartSectionView.$totalHeight
            .sink { [weak self] height in
                guard let self else { return }
                self.initialUsageSparePartHeightConstraint.constant = height + 48
                self.addUsageSparePartSectionView.layoutIfNeeded()
            }
            .store(in: &anyCancellable)
        
        addRequirementSparePartSectionView.$totalHeight
            .sink { [weak self] height in
                guard let self else { return }
                self.initialRequirementSparePartHeightConstraint.constant = height + 48
                self.addRequirementSparePartSectionView.layoutIfNeeded()
            }
            .store(in: &anyCancellable)
    }
    
    private func setupView() {
        self.recommendationStackView.makeCornerRadius(8)
        self.recommendationStackView.addShadow(2, opacity: 0.2)
        self.recommendationView.makeCornerRadius(8)
        self.recommendationView.addBorder(width: 1.0, colorBorder: UIColor.customSecondaryColor)
        self.containerInputRecommendationTextView.makeCornerRadius(8)
        self.taskInputSectionView.makeCornerRadius(8)
        self.taskInputSectionView.addShadow(2, opacity: 0.2)
        self.addTaskSectionView.makeCornerRadius(8, .bottomCurve)
        self.containerCalibratorStackView.makeCornerRadius(8)
        self.containerCalibratorStackView.addShadow(2, opacity: 0.2)
        self.calibrationStatusStackView.makeCornerRadius(8)
        self.calibrationStatusStackView.addShadow(2, opacity: 0.2)
        self.usageSparePartSectionView.makeCornerRadius(8)
        self.usageSparePartSectionView.addShadow(2, opacity: 0.2)
        self.addUsageSparePartSectionView.makeCornerRadius(8, .bottomCurve)
        self.requirementSparePartSectionView.makeCornerRadius(8)
        self.requirementSparePartSectionView.addShadow(2, opacity: 0.2)
        self.addRequirementSparePartSectionView.makeCornerRadius(8, .bottomCurve)
        self.selectStatusContainerStackView.makeCornerRadius(8)
        self.selectStatusContainerStackView.addShadow(2, opacity: 0.2)
        self.containerSelectStatusView.makeCornerRadius(8, .bottomCurve)
        self.selectStatusSectionView.delegate = self
        self.containerMediaSectionStackView.makeCornerRadius(8)
        self.containerMediaSectionStackView.addShadow(2, opacity: 0.2)
        self.containerMediaSectionView.makeCornerRadius(8, .bottomCurve)
        self.cancelButton.configure(title: "Batal", backgroundColor: UIColor.customIndicatorColor3, titleColor: UIColor.customIndicatorColor4)
        self.saveButton.configure(title: "Selesai")
        self.mediaSectionView.delegate = self
    }
    
    private func configureTextField() {
        inputRecommendationTextField.delegate = self
        inputRecommendationTextField.placeholder = "Masukkan rekomendasi & evaluasi"
        inputRecommendationTextField.clearButtonMode = .whileEditing
        inputRecommendationTextField.returnKeyType = .done
        inputRecommendationTextField.backgroundColor = .clear
    }
    
    private func setupAction() {
        guard let presenter else { return }
        navigationView.arrowLeftBackButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                presenter.showExitConfirmBottomSheet(from: navigation, self)
            }
            .store(in: &anyCancellable)
        
        cancelButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                presenter.showExitConfirmBottomSheet(from: navigation, self)
            }
            .store(in: &anyCancellable)
        
        taskInputHeaderView.actionLabel.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                presenter.showInputBottomSheet(from: navigation, delegate: self, type: .text)
            }
            .store(in: &anyCancellable)
        
        usageSparePartHeaderView.actionLabel.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                self.addUsageSparePartSectionView.sparePartType = .usage
                self.selectedSparePartType = .usage
                presenter.showSelectSparePartBottomSheet(from: navigation, delegate: self, type: .usage)
            }
            .store(in: &anyCancellable)
        
        requirementSparePartHeaderView.actionLabel.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                self.addRequirementSparePartSectionView.sparePartType = .requirement
                self.selectedSparePartType = .requirement
                presenter.showSelectSparePartBottomSheet(from: navigation, delegate: self, type: .requirement)
            }
            .store(in: &anyCancellable)
        
        saveButton.gesture()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self,
                      let presenter = self.presenter,
                      let infoText = self.inputRecommendationTextField.text,
                      let lkData = self.lkData
                else { return }
                let workSheetRequest = LKStartRequest(
                    abaiListrik: lkData.abaiListrik ?? "0",
                    abaiPemantauan: lkData.abaiPemantauan ?? "0",
                    abaiPersiapan: lkData.abaiPersiapan ?? "0",
                    abaiPreventif: lkData.abaiPreventif ?? "0",
                    alatKalibrasi: lkData.alatKalibrasi ?? [],
                    analisa: lkData.analisa ?? [],
                    approveBy: lkData.approveBy ?? "",
                    asset: lkData.asset,
                    comRespon: lkData.comRespon ?? "",
                    comTime: lkData.comTime ?? "",
                    createAt: lkData.createAt ?? "",
                    createBy: lkData.createBy ?? "",
                    dipindahkan: lkData.dipindahkan ?? "",
                    downtime: lkData.downtime,
                    engineername: lkData.engineername ?? "",
                    idAsset: lkData.idAsset ?? "",
                    idComplain: lkData.idComplain ?? "",
                    idKalibrator: lkData.idKalibrator ?? "",
                    idLk: lkData.idLK ?? "",
                    idRelokasi: lkData.idRelokasi ?? "",
                    jenisRelokasi: lkData.jenisRelokasi ?? "",
                    keluhan: lkData.keluhan ?? "",
                    listrik: electricInputView.setElectricInputtedData(),
                    lkAssign: lkData.lkAssign ?? "",
                    lkContinue: lkData.lkContinue ?? "",
                    lkDate: lkData.lkDate ?? "",
                    lkDurasireal: lkData.lkDurasireal ?? "",
                    lkEngineer: lkData.lkEngineer ?? "",
                    lkFinish: lkData.lkFinish ?? "",
                    lkFinishstt: selectStatusSectionView.finishStatusData?.lkFinishstt ?? "",
                    lkInfo: infoText,
                    lkJenis: lkData.lkJenis ?? "",
                    lkKegiatan: lkData.lkKegiatan ?? "",
                    lkLabel: lkData.lkLabel ?? "",
                    lkNumber: lkData.lkNumber ?? "",
                    lkPelapor: lkData.lkPelapor ?? "",
                    lkRating: lkData.lkRating ?? "",
                    lkStart: lkData.lkStart ?? "",
                    lkStatus: selectStatusSectionView.statusData?.lkStatus ?? "",
                    lkVarian: lkData.lkVarian ?? "",
                    lkWebenable: lkData.lkWebenable ?? "",
                    lkphoto: mediaSectionView.getAllMediaData(),
                    metode: lkData.metode ?? "",
                    newpart: addRequirementSparePartSectionView.getNewSparePartData(),
                    pemantauan: physicalMonitoringView.getSelectedPreparationData(),
                    persiapan: preparationView.getSelectedPreparationData(),
                    preventif: preventiveView.getSelectedPreventiveData(),
                    rateBy: lkData.rateBy ?? "",
                    sttLaik: lkData.sttLaik ?? "",
                    sparepart: addUsageSparePartSectionView.getSparePartData(),
                    task: addTaskSectionView.data
                )
                presenter.saveWorkSheet(data: workSheetRequest)
                self.showLoadingPopup()
            }
            .store(in: &anyCancellable)
    }
    
}

extension WorkSheetDetailView {
    
    private func configureSharedComponent() {
        guard let presenter else { return }
        let isWorkingActivity = presenter.activity == .working
        let isViewActivity = presenter.activity == .view
        self.preparationSectionView.configure(
            title: "Persiapan",
            icon: "ic_sheet_check",
            view: preparationView,
            type: isWorkingActivity ? .dismissSwitch : .collapsibleAction)
        self.electricSectionView.configure(
            title: "Pengukuran Keselamatan Listrik",
            icon: "ic_thunder",
            view: electricView,
            type: isWorkingActivity ? .dismissSwitch : .collapsibleAction)
        self.taskSectionView.configure(
            title: "Tindakan",
            icon: "ic_board_with_clock",
            view: taskView,
            type: isWorkingActivity ? .dismissSwitch : .collapsibleAction)
        self.sparePartSectionView.configure(
            title: "Penggunaan Suku Cadang",
            icon: "ic_frame_with_gear",
            view: sparePartView,
            type: isWorkingActivity ? .dismissSwitch : .collapsibleAction)
        self.calibrationMeasurementSectionView.configure(
            title: "Pengukuran Kalibrasi",
            icon: "ic_infinity",
            view: calibrationView,
            type: isWorkingActivity ? .dismissSwitch : .collapsibleAction)
        self.physicalMonitoringSectionView.configure(
            title: "Pemantauan Fisik & Fungsi",
            icon: "ic_statistic_up",
            view: physicalMonitoringView,
            type: isWorkingActivity ? .dismissSwitch : .collapsibleAction)
        self.preventiveSectionView.configure(
            title: "Pemeliharaan Preventif",
            icon: "ic_document_with_gear",
            view: preventiveView,
            type: isWorkingActivity ? .dismissSwitch : .collapsibleAction)
        self.electricInputSectionView.configure(
            title: "Pengukuran Keselamatan Listrik",
            icon: "ic_thunder",
            view: electricInputView,
            type: .dismissSwitch)
        self.taskInputHeaderView.configure(
            icon: "ic_board_with_clock",
            title: "Tindakan",
            labelAction: "Tambah",
            type: .actionLabel)
        self.navigationView.configure(
            toolbarTitle: "Detail Lembar Kerja",
            type: .plain)
        self.recommendationHeaderView.configure(
            icon: "ic_statistic_down",
            title: "Evaluasi & Rekomendasi",
            type: .plain)
        self.headerCalibratorView.configure(
            icon: "ic_infinity",
            title: "Kalibrator",
            type: .plain)
        self.calibrationStatusHeaderView.configure(
            icon: "ic_check_outline",
            title: "Status Kalibrasi",
            type: .plain)
        self.usageSparePartHeaderView.configure(
            icon: "ic_frame_with_gear",
            title: "Penggunaan Suku Cadang",
            labelAction: "Tambah",
            type: .actionLabel)
        self.requirementSparePartHeaderView.configure(
            icon: "ic_frame_with_gear",
            title: "Kebutuhan Suku Cadang",
            labelAction: "Tambah",
            type: .actionLabel)
        self.selectStatusHeaderView.configure(
            icon: "ic_check_outline",
            title: "Status Pekerjaan",
            type: .plain)
        self.headerMediaView.configure(
            icon: "ic_image",
            title: "Foto Pendukung",
            type: .plain)
        self.selectStatusContainerStackView.isHidden = isViewActivity
        self.containerActionButton.isHidden = isViewActivity
    }
    
}
