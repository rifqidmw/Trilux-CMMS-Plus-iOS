//
//  ComplaintListView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/03/24.
//

import UIKit
import SkeletonView

class ComplaintListView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var containerSearchTextField: UIView!
    @IBOutlet weak var searchTextField: SearchTextField!
    @IBOutlet weak var containerTitleView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var actionTabBarView: ActionBarView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var presenter: ComplaintListPresenter?
    var data: [Complaint] = []
    var bottomSheet: AddComplaintBottomSheet?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.validateUser()
    }
    
}

extension ComplaintListView {
    
    private func setupBody() {
        fetchInitialData()
        bindingData()
        setupView()
        setupAction()
        setupTableView()
    }
    
    private func fetchInitialData() {
        guard let presenter else { return }
        presenter.fetchInitData()
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$complaint
            .sink { [weak self] data in
                guard let self
                else {
                    self?.showSpinner(false)
                    return
                }
                
                self.data = data
                self.reloadTableViewWithAnimation(self.tableView)
                self.hideLoadingPopup()
                self.tableView.hideSkeleton()
                self.showSpinner(false)
            }
            .store(in: &anyCancellable)
        
        presenter.$advanceWorkSheet
            .sink { [weak self] data in
                guard let self, let data else { return }
                self.hideLoadingPopup()
                self.dismissBottomSheet()
                self.reloadTableViewWithAnimation(self.tableView)
                
                if data.message == "Success" {
                    self.fetchInitialData()
                } else {
                    self.showAlert(title: "Terjadi Kesalahan", message: data.message)
                }
            }
            .store(in: &anyCancellable)
        
        presenter.$acceptCorrective
            .sink { [weak self] data in
                guard let self, let data else { return }
                self.hideLoadingPopup()
                self.dismissBottomSheet()
                self.reloadTableViewWithAnimation(self.tableView)
                
                if data.message == "Success" {
                    self.fetchInitialData()
                } else {
                    self.showAlert(title: "Terjadi Kesalahan", message: data.message)
                }
            }
            .store(in: &anyCancellable)
        
        presenter.$deletedLkData
            .sink { [weak self] data in
                guard let self, let data else { return }
                self.hideLoadingPopup()
                self.dismissBottomSheet()
                self.reloadTableViewWithAnimation(self.tableView)
                
                if data.message == "Success" {
                    self.fetchInitialData()
                } else {
                    self.showAlert(title: "Terjadi Kesalahan", message: data.message)
                }
            }
            .store(in: &anyCancellable)
        
        presenter.$deletedComplaintData
            .sink { [weak self] data in
                guard let self, let data else { return }
                self.hideLoadingPopup()
                self.dismissBottomSheet()
                self.reloadTableViewWithAnimation(self.tableView)
                
                if data.message == "Success" {
                    self.fetchInitialData()
                } else {
                    self.showAlert(title: "Terjadi Kesalahan", message: data.message)
                }
            }
            .store(in: &anyCancellable)
    }
    
    private func setupView() {
        guard let presenter else { return }
        customNavigationView.configure(toolbarTitle: presenter.type == .engineer ? "Pengaduan Korektif" : "Daftar Pengaduan", type: .plain)
        actionTabBarView.configure(fourthIcon: "gearshape", fourthTitle: "Status")
        actionTabBarView.delegate = self
        searchTextField.delegate = self
        spinner.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.tableView.showAnimatedGradientSkeleton()
        }
        
        if presenter.type == .room {
            self.containerTitleView.isHidden = true
            self.containerSearchTextField.isHidden = true
        }
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
    
    private func showSpinner(_ isShow: Bool) {
        self.spinner.isHidden = !isShow
        isShow ? self.spinner.startAnimating() : self.spinner.stopAnimating()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CorrectiveTVC.nib, forCellReuseIdentifier: CorrectiveTVC.identifier)
        tableView.separatorStyle = .none
        tableView.isSkeletonable = true
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.showAnimatedGradientSkeleton()
    }
    
}

extension ComplaintListView: SkeletonTableViewDataSource, SkeletonTableViewDelegate, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CorrectiveTVC.identifier, for: indexPath) as? CorrectiveTVC,
              let complaint = presenter?.complaint[indexPath.row],
              let presenter
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(data: self.data[indexPath.row], delegate: self, complaint: complaint, type: presenter.type)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        let adjustedData = self.data[indexPath.row]
        switch presenter.type {
        case .engineer:
            presenter.navigateToComplaintDetail(navigation: navigation, id: String(adjustedData.id ?? 0))
        case .room:
            if let isDelegatable = adjustedData.valDelegatable {
                if isDelegatable {
                    // MARK: - TEMPORARY SET
                    presenter.showComplaintActionBottomSheet(from: navigation, delegate: self, String(adjustedData.id ?? 0), type: .delegate, valType: "0")
                } else {
                    presenter.showComplaintActionBottomSheet(from: navigation, delegate: self, String(adjustedData.id ?? 0), type: .detail)
                }
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard scrollView == scrollView, let presenter = self.presenter else { return }
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 0.0 && presenter.isCanLoad {
            self.showSpinner(true)
            
            DispatchQueue.main.async {
                presenter.fetchNextPage()
                self.tableView.reloadData()
            }
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return CorrectiveTVC.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
}
