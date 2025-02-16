//
//  CorrectiveHoldListView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/03/24.
//

import UIKit
import SkeletonView

class DelayCorrectiveListView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var searchTextField: SearchTextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var emptyView: UIView!
    
    var presenter: DelayCorrectiveListPresenter?
    var data: [Complaint] = []
    var bottomSheet: AddComplaintBottomSheet?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.validateUser()
    }
    
}

extension DelayCorrectiveListView {
    
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
                
                self.emptyView.isHidden = !data.isEmpty
                self.tableView.isHidden = data.isEmpty
            }
            .store(in: &anyCancellable)
        
        presenter.$advanceWorkSheet
            .sink { [weak self] data in
                guard let self, let data else { return }
                if data.message == "Success" {
                    self.hideLoadingPopup()
                    self.dismissBottomSheet()
                    self.fetchInitialData()
                    self.reloadTableViewWithAnimation(self.tableView)
                }
            }
            .store(in: &anyCancellable)
        
        presenter.$acceptCorrective
            .sink { [weak self] data in
                guard let self, let data else { return }
                if data.message == "Success" {
                    self.hideLoadingPopup()
                    self.dismissBottomSheet()
                    self.fetchInitialData()
                    self.reloadTableViewWithAnimation(self.tableView)
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
    }
    
    private func setupView() {
        customNavigationView.configure(toolbarTitle: "Korektif Tertunda", type: .plain)
        searchTextField.delegate = self
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
        tableView.showAnimatedGradientSkeleton()
    }
    
}

extension DelayCorrectiveListView: SkeletonTableViewDataSource, SkeletonTableViewDelegate, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CorrectiveTVC.identifier, for: indexPath) as? CorrectiveTVC,
              let complaint = presenter?.complaint[indexPath.row]
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(data: self.data[indexPath.row], delegate: self, complaint: complaint)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        let complaintSelected = self.data[indexPath.row]
        presenter.navigateToComplaintDetail(navigation: navigation, id: String(complaintSelected.id ?? 0))
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard scrollView == scrollView, let presenter = self.presenter else { return }
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 0.0 && presenter.isCanLoad {
            self.showSpinner(true)
            
            DispatchQueue.main.async {
                presenter.fetchNextPage()
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
