//
//  RatingBottomSheet.swift
//  cmmsv2
//
//  Created by macbook  on 04/09/24.
//

import UIKit
import Combine

protocol RatingBottomSheetDelegate: AnyObject {
    func didTapPicture(img: String)
    func didTapRating(isCanRating: String)
}

class RatingBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var assetContainerView: UIView!
    @IBOutlet weak var assetImageView: UIImageView!
    @IBOutlet weak var assetNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var assetNumberLabel: UILabel!
    
    @IBOutlet weak var lkContainerView: UIView!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var engineerNameLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var responseTimeView: InformationCardView!
    @IBOutlet weak var workingStartView: InformationCardView!
    @IBOutlet weak var workingEndView: InformationCardView!
    @IBOutlet weak var workingDurationView: InformationCardView!
    
    @IBOutlet weak var taskContainerView: UIView!
    @IBOutlet weak var headerTaskView: CustomHeaderView!
    @IBOutlet weak var emptyTaskView: UIView!
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var taskTableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var descriptionContainerView: UIView!
    @IBOutlet weak var descriptionHeaderView: CustomHeaderView!
    @IBOutlet weak var emptyDescriptionView: UIView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var damagedPictureContainerView: UIView!
    @IBOutlet weak var damagedPictureHeaderView: CustomHeaderView!
    @IBOutlet weak var emptyDamagedPictureView: UIView!
    @IBOutlet weak var damagedPictureCollectionView: UICollectionView!
    
    @IBOutlet weak var repairPictureContainerView: UIView!
    @IBOutlet weak var repairPictureHeaderView: CustomHeaderView!
    @IBOutlet weak var emptyRepairPictureView: UIView!
    @IBOutlet weak var repairCollectionView: UICollectionView!
    
    @IBOutlet weak var troubleContainerView: UIView!
    @IBOutlet weak var troubleHeaderView: CustomHeaderView!
    @IBOutlet weak var emptyTroubleView: UIView!
    @IBOutlet weak var troubleView: UIView!
    @IBOutlet weak var troubleLabel: UILabel!
    
    @IBOutlet weak var ratingContainerView: UIView!
    @IBOutlet weak var ratingHeaderView: CustomHeaderView!
    @IBOutlet weak var ratingAverageLabel: UILabel!
    
    @IBOutlet weak var firstStarImageView: UIImageView!
    @IBOutlet weak var secondStarImageView: UIImageView!
    @IBOutlet weak var thirdStarImageView: UIImageView!
    @IBOutlet weak var fourthStarImageView: UIImageView!
    @IBOutlet weak var fifthStarImageView: UIImageView!
    @IBOutlet weak var ratingButton: GeneralButton!
    
    var data: HistoryDetailEntity.HistoryDetailData?
    weak var delegate: RatingBottomSheetDelegate?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.taskTableViewHeightConstraint.constant = self.calculateTotalHeight(for: self.taskTableView)
        self.view.layoutIfNeeded()
    }
    
}

extension RatingBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
        configureData()
    }
    
    private func configureData() {
        guard let data,
              let woDetail = data.woDetail
        else { return }
        self.assetImageView.loadImageUrl(woDetail.equipment?.valImage ?? "")
        self.assetNameLabel.text = woDetail.equipment?.txtName ?? "-"
        self.dateLabel.text = woDetail.equipment?.txtRuangan ?? "-"
        
        let serialText = NSAttributedString.stylizedText("\(woDetail.equipment?.txtSerial ?? "") - ", font: UIFont.robotoBold(12), color: UIColor.customPrimaryColor)
        let roomText = NSAttributedString.stylizedText(woDetail.equipment?.txtSubRuangan ?? "", font: UIFont.robotoRegular(12), color: UIColor.customDarkGrayColor)
        
        let fullAttributedText = NSMutableAttributedString()
        fullAttributedText.append(serialText)
        fullAttributedText.append(roomText)
        self.assetNumberLabel.attributedText = fullAttributedText
        
        self.serialNumberLabel.text = woDetail.valWoNumber ?? "-"
        self.engineerNameLabel.text = "\(woDetail.txtEngineerName ?? "-") • \(woDetail.valDate ?? "-")"
        self.statusView.configureStatusView(
            status: WorkSheetStatus(rawValue: woDetail.complain?.txtStatus ?? "-") ?? .none,
            titleLabel: statusLabel,
            widthConstraint: statusWidthConstraint)
        self.responseTimeView.configureView(title: "Response Time", value: woDetail.complain?.txtResponseTime ?? "-")
        self.workingStartView.configureView(title: "Mulai Bekerja", value: woDetail.valStartTime ?? "-")
        self.workingEndView.configureView(title: "Selesai Bekerja", value: woDetail.valEndTime ?? "-")
        self.workingDurationView.configureView(title: "Durasi Bekerja", value: woDetail.valDuration ?? "-")
        self.taskTableViewHeightConstraint.constant = self.calculateTotalHeight(for: self.taskTableView)
        self.setupTaskTableView()
        self.setupDamagedCollectionView()
        self.setupRepairedCollectionView()
        self.ratingAverageLabel.text = woDetail.valRating ?? "-"
        self.updateStarIcons(rating: Int(woDetail.valRating ?? "") ?? 0)
        self.setupDescription(woDetail.txtDescriptions ?? "-", view: self.descriptionView)
        self.setupDescription(woDetail.txtFinishStatus ?? "-", view: self.troubleView)
    }
    
    private func setupView() {
        [assetContainerView,
         lkContainerView,
         taskContainerView,
         descriptionContainerView,
         damagedPictureContainerView,
         repairPictureContainerView,
         troubleContainerView,
         ratingContainerView].forEach {
            $0.makeCornerRadius(12)
            $0.layer.opacity = 1.0
            $0.addShadow(4, position: .bottom, opacity: 0.2)
        }
        assetImageView.makeCornerRadius(8, .topCurve)
        statusView.makeCornerRadius(4)
        headerTaskView.configure(icon: "ic_notes_board", title: "Tugas", type: .plain)
        descriptionHeaderView.configure(icon: "ic_board_with_pencil", title: "Keterangan", type: .plain)
        damagedPictureHeaderView.configure(icon: "ic_image", title: "Foto Kerusakan", type: .plain)
        repairPictureHeaderView.configure(icon: "ic_image", title: "Foto Kerusakan", type: .plain)
        troubleHeaderView.configure(icon: "ic_board_with_clock", title: "Kendala yang dialami", type: .plain)
        ratingHeaderView.configure(icon: "ic_star_blue", title: "Rating", type: .plain)
        ratingButton.configure(title: "BERIKAN RATING")
    }
    
    private func setupAction() {
        Publishers.Merge(
            bottomSheetView.handleBarArea.gesture(),
            dismissAreaView.gesture())
        .sink { [weak self] _ in
            guard let self else { return }
            self.dismissBottomSheet()
        }
        .store(in: &anyCancellable)
        
        ratingButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate = self.delegate,
                      let isCanRating = self.data?.woDetail?.valCanRating
                else { return }
                delegate.didTapRating(isCanRating: isCanRating)
            }
            .store(in: &anyCancellable)
    }
    
    private func setupTaskTableView() {
        self.setupTableView(self.taskTableView)
        
        if let taskList = data?.woDetail?.taskList, !taskList.isEmpty {
            self.emptyTaskView.isHidden = true
            self.taskTableView.isHidden = false
            self.taskTableView.reloadData()
            self.taskTableViewHeightConstraint.constant = self.calculateTotalHeight(for: self.taskTableView)
        } else {
            self.emptyTaskView.isHidden = false
            self.taskTableView.isHidden = true
            self.taskTableViewHeightConstraint.constant = 0
        }
    }
    
    private func setupDamagedCollectionView() {
        self.setupCollectionView(self.damagedPictureCollectionView)
        
        if let pictureList = self.data?.woDetail?.medias, !pictureList.isEmpty {
            self.emptyDamagedPictureView.isHidden = true
            self.damagedPictureCollectionView.isHidden = false
            self.damagedPictureCollectionView.reloadData()
        } else {
            self.emptyDamagedPictureView.isHidden = false
            self.damagedPictureCollectionView.isHidden = true
        }
    }
    
    private func setupRepairedCollectionView() {
        self.setupCollectionView(self.repairCollectionView)
        
        if let pictureList = self.data?.woDetail?.complain?.medias, !pictureList.isEmpty {
            self.emptyRepairPictureView.isHidden = true
            self.repairCollectionView.isHidden = false
            self.repairCollectionView.reloadData()
        } else {
            self.emptyRepairPictureView.isHidden = false
            self.repairCollectionView.isHidden = true
        }
    }
    
    private func setupDescription(_ data: String?, view: UIView) {
        let (contentView, emptyView, label): (UIView, UIView, UILabel) = {
            switch view {
            case self.descriptionView:
                return (self.descriptionView, self.emptyDescriptionView, self.descriptionLabel)
            case self.troubleView:
                return (self.troubleView, self.emptyTroubleView, self.troubleLabel)
            default:
                return (UIView(), UIView(), UILabel())
            }
        }()
        
        label.text = data ?? "-"
        let hasData = (data?.isEmpty == false)
        
        contentView.isHidden = !hasData
        emptyView.isHidden = hasData
    }
    
    private func setupTableView(_ tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaskItemTVC.nib, forCellReuseIdentifier: TaskItemTVC.identifier)
        tableView.separatorStyle = .none
    }
    
    private func setupCollectionView(_ collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EvidenceEquipmentCVC.nib, forCellWithReuseIdentifier: EvidenceEquipmentCVC.identifier)
    }
    
    private func updateStarIcons(rating: Int) {
        let starImageViews = [firstStarImageView, secondStarImageView, thirdStarImageView, fourthStarImageView, fifthStarImageView]
        
        for (index, imageView) in starImageViews.enumerated() {
            if index < rating {
                imageView?.image = UIImage(named: "ic_star_fill")
            } else {
                imageView?.image = UIImage(named: "ic_star_opacity")
            }
        }
    }
    
}

extension RatingBottomSheet: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data?.woDetail?.taskList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskItemTVC.identifier, for: indexPath) as? TaskItemTVC
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(title: self.data?.woDetail?.taskList?[indexPath.row].txtName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func calculateTotalHeight(for tableView: UITableView) -> CGFloat {
        var totalHeight: CGFloat = 0
        for row in 0..<tableView.numberOfRows(inSection: 0) {
            let indexPath = IndexPath(row: row, section: 0)
            totalHeight += tableView.rectForRow(at: indexPath).height
        }
        return totalHeight
    }
    
}

extension RatingBottomSheet: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.damagedPictureCollectionView:
            return self.data?.woDetail?.medias?.count ?? 0
        case self.repairCollectionView:
            return self.data?.woDetail?.complain?.medias?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.damagedPictureCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EvidenceEquipmentCVC.identifier, for: indexPath) as? EvidenceEquipmentCVC else {
                return UICollectionViewCell()
            }
            cell.setupCell(url: self.data?.woDetail?.medias?[indexPath.row].valUrl ?? "")
            return cell
        case self.repairCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EvidenceEquipmentCVC.identifier, for: indexPath) as? EvidenceEquipmentCVC else {
                return UICollectionViewCell()
            }
            cell.setupCell(url: self.data?.woDetail?.complain?.medias?[indexPath.row].valUrl ?? "")
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate else { return }
        switch collectionView {
        case self.damagedPictureCollectionView:
            let selectedDamagedPicture = self.data?.woDetail?.medias?[indexPath.row].valUrl ?? ""
            self.dismissBottomSheet() {
                delegate.didTapPicture(img: selectedDamagedPicture)
            }
        case self.repairCollectionView:
            let selectedRepairPicture = self.data?.woDetail?.complain?.medias?[indexPath.row].valUrl ?? ""
            self.dismissBottomSheet() {
                delegate.didTapPicture(img: selectedRepairPicture)
            }
        default: break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGSize.widthDevice / 3, height: collectionView.frame.height)
    }
    
}
