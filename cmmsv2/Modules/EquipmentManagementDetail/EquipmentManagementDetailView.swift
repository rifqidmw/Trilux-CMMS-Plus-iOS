//
//  EquipmentManagementDetailView.swift
//  cmmsv2
//
//  Created by macbook  on 16/09/24.
//

import UIKit

class EquipmentManagementDetailView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var generalInformationContainerView: UIView!
    @IBOutlet weak var generalInfoHeaderView: CustomHeaderView!
    @IBOutlet weak var requestedInstallationView: InformationCardView!
    @IBOutlet weak var dateView: InformationCardView!
    @IBOutlet weak var timeView: InformationCardView!
    
    @IBOutlet weak var installationProviderView: InformationCardView!
    @IBOutlet weak var assetLoanCountView: InformationCardView!
    @IBOutlet weak var assetApproveCountView: InformationCardView!
    
    @IBOutlet weak var containerAssetListView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var initialHeightTableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var deleteButton: GeneralButton!
    
    var presenter: EquipmentManagementDetailPresenter?
    var data: [SubmissionDetail] = []
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension EquipmentManagementDetailView {
    
    private func setupBody() {
        setupView()
        setupAction()
        fetchInitialData()
        bindingData()
        setupTableView()
    }
    
    private func fetchInitialData() {
        guard let presenter else { return }
        presenter.fetchInitialData()
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$submissionDetailData
            .sink { [weak self] data in
                guard let self,
                      let data,
                      let detail = data.data,
                      let list = detail.detail
                else { return }
                self.data = list
                self.reloadTableViewWithAnimation(self.tableView)
                self.hideLoadingPopup()
                
                self.generalInfoHeaderView.configure(icon: "ic_notes_board", title: detail.alatname ?? "-", type: .plain)
                self.requestedInstallationView.configureView(title: "Instalasi Pemohon", value: detail.location_pemohon ?? "-")
                
                if let createdAtString = detail.created_at, let createdAtDate = parseDate(from: createdAtString) {
                    let formattedDate = String.formattedDate(createdAtDate)
                    self.dateView.configureView(title: "Tanggal", value: formattedDate)
                    
                    let formattedTime = String.formattedTime(createdAtDate)
                    self.timeView.configureView(title: "Waktu", value: formattedTime)
                } else {
                    self.dateView.configureView(title: "Tanggal", value: "-")
                    self.timeView.configureView(title: "Waktu", value: "-")
                }
                
                self.installationProviderView.configureView(title: "Instalasi Penyedia", value: detail.to_instalasi ?? "-")
                self.assetLoanCountView.configureView(title: "Jumlah Permintaan Alat", value: detail.qty ?? "-")
                self.assetApproveCountView.configureView(title: "Jumlah Approve Alat", value: detail.qty_approve ?? "-")
                self.calculateTotalHeight(for: self.tableView)
            }
            .store(in: &anyCancellable)
        
        presenter.$deleteSubmissionData
            .sink { [weak self] data in
                guard let self,
                      let data,
                      let navigation = self.navigationController
                else { return }
                self.hideLoadingPopup()
                if data.message == "Success" {
                    navigation.popViewController(animated: true)
                } else {
                    self.showAlert(title: "Terjadi Kesalahan", message: data.message)
                }
            }
            .store(in: &anyCancellable)
    }
    
    private func setupView() {
        self.showLoadingPopup()
        self.customNavigationView.configure(toolbarTitle: "Detail Mutasi", type: .plain)
        [self.generalInformationContainerView,
         self.containerAssetListView].forEach {
            $0.makeCornerRadius(12)
            $0.layer.opacity = 1.0
            $0.addShadow(4, position: .bottom, opacity: 0.2)
        }
        self.deleteButton.configure(title: "Hapus", backgroundColor: UIColor.customIndicatorColor3, titleColor: UIColor.customIndicatorColor4)
    }
    
    private func setupAction() {
        deleteButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let presenter = self.presenter,
                      let id = presenter.id,
                      let navigation = self.navigationController
                else { return }
                presenter.showDeleteConfirmationPopUp(from: navigation, id: id, self)
            }
            .store(in: &anyCancellable)
        
        customNavigationView.arrowLeftBackButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                navigation.popViewController(animated: true)
            }
            .store(in: &anyCancellable)
    }
    
    private func parseDate(from dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: dateString)
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(MutationItemCell.nib, forCellReuseIdentifier: MutationItemCell.identifier)
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.isScrollEnabled = false
    }
    
}

extension EquipmentManagementDetailView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MutationItemCell.identifier, for: indexPath) as? MutationItemCell
        else {
            return UITableViewCell()
        }
        
        let adjustedData = self.data[indexPath.row]
        cell.setupCell(adjustedData.imgUrl ?? "", firstRoom: adjustedData.from_room_text ?? "-", secondRoom: adjustedData.to_room_text ?? "-", serialNumber: adjustedData.serial ?? "-")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func calculateTotalHeight(for tableView: UITableView) {
        var totalHeight: CGFloat = 0
        
        for row in 0..<tableView.numberOfRows(inSection: 0) {
            let indexPath = IndexPath(row: row, section: 0)
            totalHeight += tableView.rectForRow(at: indexPath).height
        }
        self.initialHeightTableViewConstraint.constant = totalHeight
    }
    
}

extension EquipmentManagementDetailView: ConfirmationReturningBottomDelegate {
    
    func didTapConfirm(_ idx: String) {
        guard let presenter else { return }
        self.showLoadingPopup()
        presenter.deleteSubmission(id: idx)
    }
    
}
