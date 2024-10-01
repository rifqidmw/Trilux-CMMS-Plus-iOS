//
//  RatingListView.swift
//  cmmsv2
//
//  Created by macbook  on 01/10/24.
//

import UIKit
import SkeletonView

class RatingListView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var presenter: RatingListPresenter?
    var ratingList: [RatingData] = []
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension RatingListView {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupTableView()
        fetchInitialData()
        bindingData()
    }
    
    private func setupTableView() {
        self.tableView.register(RatingCell.nib, forCellReuseIdentifier: RatingCell.identifier)
        self.tableView.isSkeletonable = true
        self.tableView.showAnimatedGradientSkeleton()
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$ratingList
            .sink { [weak self] data in
                guard let self else {
                    self?.showSpinner(false)
                    return
                }
                self.showSpinner(false)
                self.tableView.hideSkeleton()
                self.reloadTableViewWithAnimation(self.tableView)
                self.ratingList = data
            }
            .store(in: &anyCancellable)
    }
    
    private func fetchInitialData() {
        guard let presenter else { return }
        presenter.fetchInitialData()
    }
    
    private func setupView() {
        customNavigationView.configure(toolbarTitle: "Rating", type: .plain)
        DispatchQueue.main.async {
            self.tableView.isSkeletonable = true
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
    
}

extension RatingListView: SkeletonTableViewDataSource, SkeletonTableViewDelegate, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ratingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RatingCell.identifier, for: indexPath) as? RatingCell
        else {
            return UITableViewCell()
        }
        
        let adjustedData = self.ratingList[indexPath.row]
        cell.setupCell(
            date: adjustedData.valDate,
            title: adjustedData.txtTitle,
            rating: adjustedData.valRating,
            serialNumber: adjustedData.txtSubTitle ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter else { return }
        let contentOffset = tableView.contentOffset
        let id = self.ratingList[indexPath.row].id
        self.showLoadingPopup()
        presenter.fetchWorkSheetDetail(id: String(id ?? 0)) { [weak self] in
            guard let self = self,
                  let navigation = self.navigationController else { return }
            
            DispatchQueue.main.async {
                self.hideLoadingPopup()
                if let data = presenter.workSheetDetail,
                   let worksheet = data.data {
                    presenter.showRatingBottomSheet(navigation: navigation, data: worksheet, self)
                } else {
                    self.showAlert(title: "Terjadi Kesalahan", message: "Data tidak ditemukan")
                }
                self.tableView.setContentOffset(contentOffset, animated: false)
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
                self.reloadTableViewWithAnimation(self.tableView)
            }
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return RatingCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
}

extension RatingListView: RatingBottomSheetDelegate {
    
    func didTapPicture(img: String) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToDetailDocument(navigation: navigation, file: img, type: .image)
    }
    
    func didTapRating(isCanRating: String) {
        if isCanRating == "0" {
            self.showAlert(title: "Terjadi kesalahan", message: "Maaf, lembar kerja ini belum bisa diberikan Rating.")
        } else {
            self.showAlert(title: "Pemberitahuan", message: "Lembar kerja ini sudah bisa diberikan Rating.")
        }
    }
    
}
