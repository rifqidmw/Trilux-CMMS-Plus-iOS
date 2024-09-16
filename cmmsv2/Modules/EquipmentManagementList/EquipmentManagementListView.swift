//
//  EquipmentManagementView.swift
//  cmmsv2
//
//  Created by macbook  on 10/09/24.
//

import UIKit
import SkeletonView

class EquipmentManagementListView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var floatingActionButton: FloatingActionButton!
    @IBOutlet weak var initialHeightFloatingActionButton: NSLayoutConstraint!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var presenter: EquipmentManagementListPresenter?
    var submissionData: [EquipmentManagementSubmissionData] = []
    var requestData: [EquipmentManagementRequestData] = []
    var borrowedData: [EquipmentManagementRequestData] = []
    var loanData: [EquipmentManagementRequestData] = []
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension EquipmentManagementListView {
    
    private func setupBody() {
        setupView()
        setupAction()
        fetchInitialData()
        bindingData()
        setupTableView()
    }
    
    private func fetchInitialData() {
        guard let presenter else { return }
        presenter.fetchInitData()
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$equipmentSubmissionData
            .sink { [weak self] data in
                guard let self,
                      let data,
                      let dataList = data.data
                else {
                    self?.showSpinner(false)
                    return
                }
                self.submissionData = dataList
                self.reloadTableViewWithAnimation(self.tableView)
                self.tableView.hideSkeleton()
            }
            .store(in: &anyCancellable)
        
        presenter.$equipmentRequestData
            .sink { [weak self] data in
                guard let self,
                      let data,
                      let dataList = data.data
                else {
                    self?.showSpinner(false)
                    return
                }
                self.requestData = dataList
                self.reloadTableViewWithAnimation(self.tableView)
                self.tableView.hideSkeleton()
            }
            .store(in: &anyCancellable)
        
        presenter.$returningLoanData
            .sink { [weak self] data in
                guard let self,
                      let data,
                      let dataList = data.data
                else {
                    self?.showSpinner(false)
                    return
                }
                self.loanData = dataList
                self.reloadTableViewWithAnimation(self.tableView)
                self.tableView.hideSkeleton()
            }
            .store(in: &anyCancellable)
        
        presenter.$returningBorrowedData
            .sink { [weak self] data in
                guard let self,
                      let data,
                      let dataList = data.data
                else {
                    self?.showSpinner(false)
                    return
                }
                self.borrowedData = dataList
                self.reloadTableViewWithAnimation(self.tableView)
                self.tableView.hideSkeleton()
            }
            .store(in: &anyCancellable)
        
        self.floatingActionButton.$totalHeightTable
            .sink { [weak self] totalHeight in
                guard let self else { return }
                self.initialHeightFloatingActionButton.constant = totalHeight + 48
                self.view.layoutIfNeeded()
            }
            .store(in: &anyCancellable)
        
        presenter.$approvedRequestedData
            .sink { [weak self] data in
                guard let self, let data else { return }
                self.hideLoadingPopup()
                if data.message == "Success" {
                    presenter.fetchInitData()
                    self.reloadTableViewWithAnimation(self.tableView)
                } else {
                    self.showAlert(title: "Terjadi Kesalahan", message: data.message)
                }
            }
            .store(in: &anyCancellable)
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(EquipmentManagementCell.nib, forCellReuseIdentifier: EquipmentManagementCell.identifier)
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
    }
    
    private func setupView() {
        guard let presenter else { return }
        self.customNavigationView.configure(toolbarTitle: presenter.type == .returning ? "Pengembalian Alat" : "Peminjaman Alat", type: .plain)
        self.floatingActionButton.data = presenter.floatingActionData
        self.floatingActionButton.delegate = self
        
        let segmentedItems: [EquipmentManagementSegmentedType]
        
        switch presenter.type {
        case .returning:
            segmentedItems = [.loan, .borrowed]
        case .loan:
            segmentedItems = [.submission, .request]
            if segmentedControl.selectedSegmentIndex == 0 {
                self.floatingActionButton.isHidden = false
            }
        }
        
        segmentedControl.removeAllSegments()
        
        for (index, item) in segmentedItems.enumerated() {
            segmentedControl.insertSegment(withTitle: item.getStringValue(), at: index, animated: false)
        }
        
        segmentedControl.selectedSegmentIndex = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.tableView.showAnimatedGradientSkeleton()
        }
    }
    
    private func setupAction() {
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
        customNavigationView.arrowLeftBackButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                navigation.popViewController(animated: true)
            }
            .store(in: &anyCancellable)
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        guard let selectedSegmentTitle = sender.titleForSegment(at: sender.selectedSegmentIndex),
              let selectedType = EquipmentManagementSegmentedType(rawValue: selectedSegmentTitle),
              let presenter else { return }
        
        self.floatingActionButton.isHidden = true
        switch selectedType {
        case .submission:
            presenter.fetchEquipmentSubmission()
            self.floatingActionButton.isHidden = false
        case .request:
            presenter.fetchEquipmentRequest()
        case .borrowed:
            presenter.fetchReturningBorrowedList(limit: presenter.limit, page: presenter.page)
        case .loan:
            presenter.fetchReturningLoanList(limit: presenter.limit, page: presenter.page)
        case .none:
            break
        }
    }
    
    private func showSpinner(_ isShow: Bool) {
        self.spinner.isHidden = !isShow
        isShow ? self.spinner.startAnimating() : self.spinner.stopAnimating()
    }
    
}

extension EquipmentManagementListView: SkeletonTableViewDataSource, SkeletonTableViewDelegate, UIScrollViewDelegate {
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return EquipmentManagementCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch presenter?.type {
        case .returning:
            if segmentedControl.selectedSegmentIndex == 0 {
                return self.loanData.count
            } else {
                return self.borrowedData.count
            }
        case .loan:
            if segmentedControl.selectedSegmentIndex == 0 {
                return self.submissionData.count
            } else {
                return self.requestData.count
            }
        default: break
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EquipmentManagementCell.identifier, for: indexPath) as? EquipmentManagementCell
        else {
            return UITableViewCell()
        }
        
        switch presenter?.type {
        case .loan:
            if segmentedControl.selectedSegmentIndex == 0 {
                let adjustedData = self.submissionData[indexPath.row]
                let installationTitle = NSAttributedString.stylizedText("Instalasi Tujuan: ", font: UIFont.robotoRegular(10), color: UIColor.customPlaceholderColor)
                let installation = NSAttributedString.stylizedText(adjustedData.tujuanName ?? "-", font: UIFont.robotoBold(12), color: UIColor.customPrimaryColor)
                
                let fullInstallationTitle = NSMutableAttributedString()
                fullInstallationTitle.append(installationTitle)
                fullInstallationTitle.append(installation)
                
                let assetCountTitle = NSAttributedString.stylizedText("Jumlah Alat: ", font: UIFont.robotoRegular(10), color: UIColor.customPlaceholderColor)
                let assetCount = NSAttributedString.stylizedText(adjustedData.qtyApprove ?? "-", font: UIFont.robotoBold(12), color: UIColor.customPrimaryColor)
                
                let fullAssetCountTitle = NSMutableAttributedString()
                fullAssetCountTitle.append(assetCountTitle)
                fullAssetCountTitle.append(assetCount)
                
                cell.setupCell(
                    destination: fullInstallationTitle,
                    date: adjustedData.createdAt ?? "-",
                    title: adjustedData.alatName ?? "-",
                    description: adjustedData.instalasiName ?? "-",
                    assetCount: fullAssetCountTitle,
                    status: adjustedData.statusText ?? "-")
                
            } else {
                let adjustedData = self.requestData[indexPath.row]
                
                let destinationInstallationTitle = NSAttributedString.stylizedText("Instalasi Tujuan: ", font: UIFont.robotoRegular(10), color: UIColor.customPlaceholderColor)
                let destinationInstallation = NSAttributedString.stylizedText(adjustedData.fromInstalasiText ?? "-", font: UIFont.robotoBold(12), color: UIColor.customPrimaryColor)
                
                let fullInstallationTitle = NSMutableAttributedString()
                fullInstallationTitle.append(destinationInstallationTitle)
                fullInstallationTitle.append(destinationInstallation)
                
                let destinationTitle = NSAttributedString.stylizedText("Tujuan: ", font: UIFont.robotoRegular(10), color: UIColor.customPlaceholderColor)
                let destination = NSAttributedString.stylizedText(adjustedData.toRoomText ?? "-", font: UIFont.robotoBold(12), color: UIColor.customPrimaryColor)
                
                let fullDestinationText = NSMutableAttributedString()
                fullDestinationText.append(destinationTitle)
                fullDestinationText.append(destination)
                
                cell.setupCell(
                    destination: fullInstallationTitle,
                    date: adjustedData.serial ?? "-",
                    title: adjustedData.assetName ?? "-",
                    description: adjustedData.toInstalasiText ?? "-",
                    assetCount: fullDestinationText,
                    status: adjustedData.statusText ?? "-")
            }
        case .returning:
            if segmentedControl.selectedSegmentIndex == 0 {
                let adjustedData = self.loanData[indexPath.row]
                
                let destinationInstallation = NSAttributedString.stylizedText(adjustedData.fromInstalasiText ?? "-", font: UIFont.robotoBold(12), color: UIColor.customPrimaryColor)
                
                let serialNumberTitle = NSAttributedString.stylizedText("Tujuan: ", font: UIFont.robotoRegular(10), color: UIColor.customPlaceholderColor)
                let serialNumber = NSAttributedString.stylizedText(adjustedData.toRoomText ?? "-", font: UIFont.robotoBold(12), color: UIColor.customPrimaryColor)
                
                let fullSerialNumberText = NSMutableAttributedString()
                fullSerialNumberText.append(serialNumberTitle)
                fullSerialNumberText.append(serialNumber)
                
                cell.setupCell(
                    destination: destinationInstallation,
                    date: adjustedData.serial ?? "-",
                    title: adjustedData.assetName ?? "-",
                    description: adjustedData.toInstalasiText ?? "-",
                    assetCount: fullSerialNumberText)
            } else {
                let adjustedData = self.borrowedData[indexPath.row]
                
                let destinationInstallation = NSAttributedString.stylizedText(adjustedData.fromInstalasiText ?? "-", font: UIFont.robotoBold(12), color: UIColor.customPrimaryColor)
                
                let serialNumberTitle = NSAttributedString.stylizedText("Tujuan: ", font: UIFont.robotoRegular(10), color: UIColor.customPlaceholderColor)
                let serialNumber = NSAttributedString.stylizedText(adjustedData.toRoomText ?? "-", font: UIFont.robotoBold(12), color: UIColor.customPrimaryColor)
                
                let fullSerialNumberText = NSMutableAttributedString()
                fullSerialNumberText.append(serialNumberTitle)
                fullSerialNumberText.append(serialNumber)
                
                cell.setupCell(
                    destination: destinationInstallation,
                    date: adjustedData.serial ?? "-",
                    title: adjustedData.assetName ?? "-",
                    description: adjustedData.toInstalasiText ?? "-",
                    assetCount: fullSerialNumberText)
            }
        default: break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        switch presenter.type {
        case .loan:
            if segmentedControl.selectedSegmentIndex == 0 {
                presenter.navigateToEquipmentManagementDetail(from: navigation, self.submissionData[indexPath.row].idRl ?? "")
            } else {
                presenter.showApproveConfirmationPopUp(from: navigation, id: self.requestData[indexPath.row].idRl ?? "", self)
            }
        case .returning:
            if segmentedControl.selectedSegmentIndex == 0 {
                AppLogger.log("-- GO TO DETAIL")
            } else {
                AppLogger.log("-- GO TO DETAIL")
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard scrollView == scrollView,
              let presenter = self.presenter
        else { return }
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if presenter.type == .returning {
            if maximumOffset - currentOffset <= 0.0 && presenter.isCanLoad {
                self.showSpinner(true)
                
                DispatchQueue.main.async {
                    presenter.fetchNextPage()
                }
            }
        }
    }
    
}
