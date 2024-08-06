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
    @IBOutlet weak var searchTextField: SearchTextField!
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
    }
    
    private func setupView() {
        customNavigationView.configure(toolbarTitle: "Pengaduan Korektif", type: .plain)
        actionTabBarView.configure(fourthIcon: "gearshape", fourthTitle: "Status")
        actionTabBarView.delegate = self
        searchTextField.delegate = self
        spinner.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.tableView.showAnimatedGradientSkeleton()
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
        tableView.showAnimatedGradientSkeleton()
    }
    
}

extension ComplaintListView: SkeletonTableViewDataSource, SkeletonTableViewDelegate, UIScrollViewDelegate {
    
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
        presenter.navigateToComplaintDetail(navigation: navigation, id: String(self.data[indexPath.row].id ?? 0))
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
