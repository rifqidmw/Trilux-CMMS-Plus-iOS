//
//  ComplaintInformationView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/08/24.
//

import UIKit
import XLPagerTabStrip
import SkeletonView

protocol ComplaintInformationViewDelegate: AnyObject {
    func didTapComplaintItem(id: String)
}

class ComplaintInformationView: BaseViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var containerContentStackView: UIStackView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var emptyView: EmptyView!
    
    var limit: Int = 20
    var page: Int = 1
    var isCanLoad = true
    var isFetchingMore = false
    var data: [EquipmentComplaintData] = []
    weak var delegate: ComplaintInformationViewDelegate?
    weak var parentView: EquipmentMaintenanceView?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.data.removeAll()
    }
    
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: "Pengaduan")
    }
    
}

extension ComplaintInformationView {
    
    private func setupBody() {
        setupView()
        setupTableView()
        fetchInitialData()
        bindingData()
    }
    
    private func setupView() {
        emptyView.configure("Oppsss Pengaduan Kosong", description: "Maaf, informasi pengaduan mengenai pemeliharaan asset belum tersedia saat ini.")
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(AssetMaintenanceInfoCell.nib, forCellReuseIdentifier: AssetMaintenanceInfoCell.identifier)
        self.tableView.separatorStyle = .none
        self.countLabel.isSkeletonable = true
        self.countLabel.showAnimatedGradientSkeleton()
        self.tableView.isSkeletonable = true
        self.tableView.showAnimatedGradientSkeleton()
    }
    
    private func fetchInitialData() {
        guard let view = parentView,
              let presenter = view.presenter
        else { return }
        presenter.fetchInspectionData(limit: self.limit, id: presenter.idAsset ?? "", page: self.page)
        presenter.fetchEquipmentComplaint(limit: self.limit, id: presenter.idAsset, page: self.page)
    }
    
    private func bindingData() {
        guard let view = parentView,
              let presenter = view.presenter
        else { return }
        presenter.$equipmentComplaintInfoData
            .sink { [weak self] data in
                guard let self
                else {
                    self?.showSpinner(false)
                    return
                }
                self.data = data
                self.reloadTableViewWithAnimation(self.tableView)
                self.showSpinner(false)
                self.tableView.hideSkeleton()
                self.countLabel.hideSkeleton()
                self.emptyView.isHidden = !data.isEmpty
                self.countLabel.text = "Berhasil menemukan \(data.count) item"
                self.containerContentStackView.isHidden = data.isEmpty
            }
            .store(in: &anyCancellable)
    }
    
    private func showSpinner(_ isShow: Bool) {
        self.spinner.isHidden = !isShow
        isShow ? self.spinner.startAnimating() : self.spinner.stopAnimating()
    }
    
    func fetchNextPage() {
        guard let view = parentView,
              let presenter = view.presenter
        else { return }
        guard !isFetchingMore && isCanLoad else { return }
        page += 1
        presenter.fetchEquipmentComplaint(limit: self.limit, id: presenter.idAsset ?? "", page: self.page)
    }
    
}

extension ComplaintInformationView: SkeletonTableViewDataSource, SkeletonTableViewDelegate, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AssetMaintenanceInfoCell.identifier, for: indexPath) as? AssetMaintenanceInfoCell
        else {
            return UITableViewCell()
        }
        
        let adjustedData = self.data[indexPath.row]
        let image = adjustedData.photos?.first?.thumb ?? ""
        
        let titleComplaint = NSAttributedString.stylizedText("Keluhan: ", font: UIFont.robotoBold(12), color: UIColor.customPlaceholderColor)
        let complaintLabel = NSAttributedString.stylizedText(adjustedData.txtTitle ?? "-", font: UIFont.robotoBold(12), color: UIColor.customDarkGrayColor)
        let fullComplaintLabel = NSMutableAttributedString()
        fullComplaintLabel.append(titleComplaint)
        fullComplaintLabel.append(complaintLabel)
        
        let titleDescription = NSAttributedString.stylizedText("Kronologi: ", font: UIFont.robotoBold(12), color: UIColor.customPlaceholderColor)
        let descriptionLabel = NSAttributedString.stylizedText(adjustedData.txtPengaduan ?? "-", font: UIFont.robotoBold(12), color: UIColor.customDarkGrayColor)
        let fullDescriptionLabel = NSMutableAttributedString()
        fullDescriptionLabel.append(titleDescription)
        fullDescriptionLabel.append(descriptionLabel)
        
        let lkCount = "Lembar Kerja \(adjustedData.detailLK?.count ?? 0) Lembar"
        
        cell.setupCell(image: image, firstText: fullComplaintLabel, secondText: fullDescriptionLabel, fifthText: lkCount, secondDate: adjustedData.txtTanggal ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate else { return }
        let id = self.data[indexPath.row].idComplain ?? ""
        delegate.didTapComplaintItem(id: id)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard scrollView == scrollView else { return }
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 0.0 && self.isCanLoad {
            self.showSpinner(true)
            
            DispatchQueue.main.async {
                self.fetchNextPage()
            }
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return AssetMaintenanceInfoCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
}
