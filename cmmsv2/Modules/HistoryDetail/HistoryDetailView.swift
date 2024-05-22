//
//  HistoryDetailView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 18/05/24.
//

import UIKit

class HistoryDetailView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var containerHeaderView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var assetNameLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    
    @IBOutlet weak var workSheetView: UIView!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var responseTimeView: InformationCardView!
    @IBOutlet weak var workStartView: InformationCardView!
    @IBOutlet weak var workEndView: InformationCardView!
    @IBOutlet weak var workDurationView: InformationCardView!
    @IBOutlet weak var workSheetViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var headerTaskView: CustomHeaderView!
    @IBOutlet weak var emptyTaskView: UIView!
    @IBOutlet weak var taskCollectionView: UICollectionView!
    @IBOutlet weak var taskViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var headerDescriptionView: CustomHeaderView!
    @IBOutlet weak var emptyDescriptionView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var damagedPictureView: UIView!
    @IBOutlet weak var headerDamagedPictureView: CustomHeaderView!
    @IBOutlet weak var emptyDamagedPictureView: UIView!
    @IBOutlet weak var damagedPictureCollectionView: UICollectionView!
    @IBOutlet weak var damagedPictureHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var repairPictureView: UIView!
    @IBOutlet weak var headerRepairPictureView: CustomHeaderView!
    @IBOutlet weak var emptyRepairPictureView: UIView!
    @IBOutlet weak var repairPictureCollectionView: UICollectionView!
    @IBOutlet weak var repairPictureHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var constraintView: UIView!
    @IBOutlet weak var headerConstraintView: CustomHeaderView!
    @IBOutlet weak var emptyConstraintView: UIView!
    @IBOutlet weak var finishLabel: UILabel!
    @IBOutlet weak var constraintViewHeightConstraint: NSLayoutConstraint!
    
    var presenter: HistoryDetailPresenter?
    var taskList: [HistoryDetailEntity.HistoryDetailData.HistoryDetailWorkOrder.HistoryTask] = []
    var damagedMediaList: [HistoryDetailEntity.HistoryDetailData.HistoryDetailWorkOrder.Complain.Media] = []
    var repairedMediaList: [HistoryDetailEntity.HistoryDetailData.HistoryDetailWorkOrder.Media] = []
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension HistoryDetailView {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func fetchInitialData() {
        guard let presenter else { return }
        presenter.fetchInitData()
    }
    
    private func bindingData() {
        guard let presenter = presenter else { return }
        presenter.$historyDetail
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self = self,
                      let history = data,
                      let historyData = history.data,
                      let workOrder = historyData.woDetail,
                      let equipment = workOrder.equipment,
                      let complain = workOrder.complain
                else { return }
                
                let taskList = workOrder.taskList ?? []
                let damagedMediaList = complain.medias ?? []
                let repairedMediaList = workOrder.medias ?? []
                let finishStatus = workOrder.txtFinishStatus ?? ""
                let description = workOrder.txtDescriptions ?? ""
                let status = workOrder.txtType ?? ""
                
                self.hideAnimationSkeleton()
                self.headerImageView.loadImageUrl(equipment.valImage ?? "")
                self.assetNameLabel.text = equipment.txtName ?? "-"
                self.roomLabel.text = equipment.txtRuangan ?? "-"
                self.brandLabel.text = "\(equipment.txtSerial ?? "-") - \(equipment.txtBrand ?? "-")"
                self.serialNumberLabel.text = workOrder.valWoNumber ?? "-"
                self.dateLabel.text = "\(workOrder.txtEngineerName ?? "") - \(workOrder.valDelegatedTime ?? "-")"
                self.statusLabel.text = status
                self.statusView.isHidden = status != "Korektif"
                self.responseTimeView.configureView(title: "Response Time", value: complain.txtResponseTime ?? "-")
                self.workStartView.configureView(title: "Mulai Bekerja", value: workOrder.valStartTime ?? "-")
                self.workEndView.configureView(title: "Selesai Bekerja", value: workOrder.valEndTime ?? "-")
                self.workDurationView.configureView(title: "Durasi Bekerja", value: workOrder.valDuration ?? "-")
                self.finishLabel.text = finishStatus
                self.descriptionLabel.text = description
                self.taskList = taskList
                self.taskCollectionView.reloadData()
                self.damagedMediaList = damagedMediaList
                self.damagedPictureCollectionView.reloadData()
                self.repairedMediaList = repairedMediaList
                self.repairPictureCollectionView.reloadData()
                
                self.emptyDescriptionView.isHidden = !description.isEmpty
                self.descriptionLabel.isHidden = description.isEmpty
                
                self.emptyTaskView.isHidden = !taskList.isEmpty
                self.taskCollectionView.isHidden = taskList.isEmpty
                
                self.emptyDamagedPictureView.isHidden = !damagedMediaList.isEmpty
                self.damagedPictureCollectionView.isHidden = damagedMediaList.isEmpty
                
                self.emptyRepairPictureView.isHidden = !repairedMediaList.isEmpty
                self.repairPictureCollectionView.isHidden = repairedMediaList.isEmpty
                
                self.emptyConstraintView.isHidden = !finishStatus.isEmpty
                self.finishLabel.isHidden = finishStatus.isEmpty
                
                 self.taskViewHeightConstraint.constant = calculateTaskHeight(data: taskList) + 80
                self.descriptionViewHeightConstraint.constant = self.descriptionLabel.requiredHeight() + 80
                self.constraintViewHeightConstraint.constant = finishLabel.requiredHeight() + 80
                self.view.layoutIfNeeded()
            }
            .store(in: &anyCancellable)
    }
    
    private func configureSharedComponent() {
        customNavigationView.configure(plainTitle: "Riwayat", type: .plain)
        statusView.makeCornerRadius(8)
        headerImageView.makeCornerRadius(12)
        containerHeaderView.makeCornerRadius(12)
        containerHeaderView.addShadow(0.8)
        workSheetView.makeCornerRadius(12)
        workSheetView.addShadow(0.8)
        taskView.makeCornerRadius(12)
        taskView.addShadow(0.8)
        headerTaskView.configure(icon: "ic_sheet_check", title: "Tugas", type: .plain)
        descriptionView.makeCornerRadius(12)
        descriptionView.addShadow(0.8)
        headerDescriptionView.configure(icon: "ic_notes_board", title: "Keteragan", type: .plain)
        damagedPictureView.makeCornerRadius(12)
        damagedPictureView.addShadow(0.8)
        headerDamagedPictureView.configure(icon: "ic_image", title: "Foto Kerusakan", type: .plain)
        repairPictureView.makeCornerRadius(12)
        repairPictureView.addShadow(0.8)
        headerRepairPictureView.configure(icon: "ic_image", title: "Foto Perbaikan", type: .plain)
        constraintView.makeCornerRadius(12)
        constraintView.addShadow(0.8)
        headerConstraintView.configure(icon: "ic_board_with_clock", title: "Kendala", type: .plain)
    }
    
    private func setupView() {
        fetchInitialData()
        bindingData()
        setupCollectionView(taskCollectionView)
        setupCollectionView(repairPictureCollectionView)
        setupCollectionView(damagedPictureCollectionView)
        configureSharedComponent()
        showAnimationSkeleton()
    }
    
    private func setupAction() {
        customNavigationView.arrowLeftBackButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                navigation.popViewController(animated: true)
            }
            .store(in: &anyCancellable)
    }
    
    private func setupCollectionView(_ collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EvidenceEquipmentCVC.nib, forCellWithReuseIdentifier: EvidenceEquipmentCVC.identifier)
        collectionView.register(TaskItemCVC.nib, forCellWithReuseIdentifier: TaskItemCVC.identifier)
    }
    
    private func calculateTaskHeight(data: [HistoryDetailEntity.HistoryDetailData.HistoryDetailWorkOrder.HistoryTask]) -> CGFloat {
        let initialHeight: CGFloat = 20
        let totalHeight = CGFloat(initialHeight) * CGFloat(data.count)
        return totalHeight
    }
    
    private func showAnimationSkeleton() {
        [self.headerImageView,
         self.assetNameLabel,
         self.statusView,
         self.roomLabel,
         self.serialNumberLabel,
         self.dateLabel,
         self.brandLabel
        ].forEach {
            $0.isSkeletonable = true
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideAnimationSkeleton() {
        [self.headerImageView,
         self.assetNameLabel,
         self.statusView,
         self.roomLabel,
         self.serialNumberLabel,
         self.dateLabel,
         self.brandLabel
        ].forEach {
            $0.hideSkeleton()
        }
    }
    
}
