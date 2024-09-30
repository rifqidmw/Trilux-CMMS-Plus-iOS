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
    var mutationSubmissionData: [MutationRequestData] = []
    var mutationRequestData: [MutationRequestData] = []
    var amprahListData: [AmprahListData] = []
    
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
        
        presenter.$mutationSubmissionData
            .sink { [weak self] data in
                guard let self,
                      let data,
                      let dataList = data.data
                else {
                    self?.showSpinner(false)
                    return
                }
                self.mutationSubmissionData = dataList
                self.reloadTableViewWithAnimation(self.tableView)
                self.tableView.hideSkeleton()
            }
            .store(in: &anyCancellable)
        
        presenter.$mutationRequestData
            .sink { [weak self] data in
                guard let self,
                      let data,
                      let dataList = data.data
                else {
                    self?.showSpinner(false)
                    return
                }
                self.mutationRequestData = dataList
                self.reloadTableViewWithAnimation(self.tableView)
                self.tableView.hideSkeleton()
            }
            .store(in: &anyCancellable)
        
        presenter.$amprahList
            .sink { [weak self] data in
                guard let self,
                      let data,
                      let dataList = data.data
                else {
                    self?.showSpinner(false)
                    return
                }
                self.amprahListData = dataList
                self.reloadTableViewWithAnimation(self.tableView)
                self.tableView.hideSkeleton()
            }
            .store(in: &anyCancellable)
        
        presenter.$mutationResponse
            .sink { [weak self] data in
                guard let self,
                      let data
                else {
                    self?.showSpinner(false)
                    return
                }
                self.hideLoadingPopup()
                presenter.fetchInitData()
                self.reloadTableViewWithAnimation(self.tableView)
                if data.message == "Success" {
                    self.showAlert(title: "Pemberitahuan", message: "Perpindahan amprah berhasil")
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
        self.customNavigationView.configure(toolbarTitle: getToolbarTitle(for: presenter.type), type: .plain)
        self.floatingActionButton.data = presenter.floatingActionData
        self.floatingActionButton.delegate = self
        
        let segmentedItems: [EquipmentManagementSegmentedType]
        
        switch presenter.type {
        case .loan:
            segmentedItems = [.submission, .request]
            self.floatingActionButton.isHidden = (segmentedControl.selectedSegmentIndex != 0)
        case .mutation:
            segmentedItems = [.submission, .request]
            self.floatingActionButton.isHidden = false
        case .returning:
            segmentedItems = [.loan, .borrowed]
            self.floatingActionButton.isHidden = true
        case .amprah:
            segmentedItems = []
            self.segmentedControl.isHidden = true
            self.floatingActionButton.isHidden = true
        }
        
        setupSegmentedControl(with: segmentedItems)
        
        DispatchQueue.main.async {
            self.tableView.showAnimatedGradientSkeleton()
        }
    }
    
    private func getToolbarTitle(for type: EquipmentManagementType) -> String {
        switch type {
        case .returning: return "Pengembalian Alat"
        case .mutation: return "Mutasi"
        case .loan: return "Peminjaman Alat"
        case .amprah: return "Amprah"
        }
    }
    
    private func setupSegmentedControl(with items: [EquipmentManagementSegmentedType]) {
        segmentedControl.removeAllSegments()
        
        for (index, item) in items.enumerated() {
            segmentedControl.insertSegment(withTitle: item.getStringValue(), at: index, animated: false)
        }
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.isHidden = items.isEmpty
    }
    
    private func updateVisibilityFloatingButton(_ type: EquipmentManagementType) {
        switch type {
        case .loan:
            self.floatingActionButton.isHidden = (segmentedControl.selectedSegmentIndex != 0)
        case .returning:
            self.floatingActionButton.isHidden = true
        case .amprah:
            self.floatingActionButton.isHidden = true
        case .mutation:
            self.floatingActionButton.isHidden = false
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
              let presenter
        else { return }
        
        let isLoan = presenter.type == .loan
        self.updateVisibilityFloatingButton(presenter.type)
        switch selectedType {
        case .submission:
            isLoan ? presenter.fetchEquipmentSubmission() : presenter.fetchMutationSubmission()
        case .request:
            isLoan ? presenter.fetchEquipmentRequest() : presenter.fetchMutationRequest()
        case .borrowed:
            presenter.fetchReturningBorrowedList(limit: presenter.limit, page: presenter.page)
        case .loan:
            presenter.fetchReturningLoanList(limit: presenter.limit, page: presenter.page)
        case .none:
            break
        }
    }
    
    func showSpinner(_ isShow: Bool) {
        self.spinner.isHidden = !isShow
        isShow ? self.spinner.startAnimating() : self.spinner.stopAnimating()
    }
    
}
