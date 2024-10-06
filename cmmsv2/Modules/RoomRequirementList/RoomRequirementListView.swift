//
//  RoomRequirementListView.swift
//  cmmsv2
//
//  Created by macbook  on 03/10/24.
//

import UIKit
import SkeletonView

class RoomRequirementListView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var searchTextField: SearchTextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var floatingActionButton: FloatingActionButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var actionBarView: ActionBarView!
    
    var presenter: RoomRequirementListPresenter?
    var data: [RoomRequirementListData] = []
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.validateUser()
    }
    
}

extension RoomRequirementListView {
    
    private func setupBody() {
        setupView()
        setupAction()
        fetchInitialData()
        bindingData()
        setupTableView()
    }
    
    private func setupView() {
        customNavigationView.configure(toolbarTitle: "Kebutuhan Ruangan", type: .plain)
        actionBarView.configure(
            firstIcon: "calendar",
            firstTitle: "Tahun",
            secondIcon: "wrench.and.screwdriver",
            secondTitle: "Kondisi",
            thirdIcon: "arrow.up.arrow.down.square",
            thirdTitle: "Urutkan")
        floatingActionButton.configure(false)
        floatingActionButton.tappedDelegate = self
        actionBarView.delegate = self
        searchTextField.delegate = self
        DispatchQueue.main.async {
            self.tableView.isSkeletonable = true
            self.tableView.showAnimatedGradientSkeleton()
        }
    }
    
    private func fetchInitialData() {
        guard let presenter else { return }
        presenter.fetchInitData(group: presenter.type == .medic ? "0" : "1")
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$roomRequirementList
            .sink { [weak self] data in
                guard let self
                else {
                    self?.showSpinner(false)
                    return
                }
                self.data = data
                self.hideLoadingPopup()
                self.tableView.hideSkeleton()
                self.reloadTableViewWithAnimation(tableView)
                self.showSpinner(false)
            }
            .store(in: &anyCancellable)
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(RoomRequirementCell.nib, forCellReuseIdentifier: RoomRequirementCell.identifier)
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.separatorStyle = .none
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

extension RoomRequirementListView: SkeletonTableViewDataSource, SkeletonTableViewDelegate, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RoomRequirementCell.identifier, for: indexPath) as? RoomRequirementCell
        else {
            return UITableViewCell()
        }
        
        let adjustedData = self.data[indexPath.row]
        let dateText = NSAttributedString.stylizedText("\(adjustedData.tglKebutuhan ?? "") - ", font: UIFont.robotoRegular(14), color: UIColor.customPlaceholderColor)
        let idText = NSAttributedString.stylizedText(adjustedData.idUsulan ?? "", font: UIFont.robotoBold(14), color: UIColor.customPrimaryColor)
        
        let fullDateText = NSMutableAttributedString()
        fullDateText.append(dateText)
        fullDateText.append(idText)
        
        let installationText = NSAttributedString.stylizedText(adjustedData.namaInstalasi ?? "", font: UIFont.robotoRegular(12), color: UIColor.customPlaceholderColor)
        let byLabel = NSAttributedString.stylizedText(" oleh ", font: UIFont.robotoBold(12), color: UIColor.customDarkGrayColor)
        let roomNameText = NSAttributedString.stylizedText(adjustedData.namaRoom?.lowercased() ?? "", font: UIFont.robotoRegular(12), color: UIColor.customPlaceholderColor)
        
        let fullDescription = NSMutableAttributedString()
        fullDescription.append(installationText)
        fullDescription.append(byLabel)
        fullDescription.append(roomNameText)
        
        cell.setupCell(
            date: fullDateText,
            status: adjustedData.namaStatus ?? "",
            title: adjustedData.namaAlat ?? "",
            description: fullDescription,
            count: adjustedData.jumlah ?? "",
            suggestUnit: adjustedData.namaSatuan ?? "",
            suggestCharacteristic: adjustedData.namaSifat ?? "",
            realizationCount: adjustedData.jmlRealisasi ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        
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
        return RoomRequirementCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
}
