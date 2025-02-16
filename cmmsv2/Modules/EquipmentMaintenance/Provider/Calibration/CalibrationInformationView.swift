//
//  CalibrationInformationView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/08/24.
//

import UIKit
import XLPagerTabStrip
import SkeletonView

protocol CalibrationInformationViewDelegate: AnyObject {
    func didTapCalibrationItem(id: String)
}

class CalibrationInformationView: BaseViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var containerContentStackView: UIStackView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: EmptyView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var limit: Int = 20
    var page: Int = 1
    var isCanLoad = true
    var isFetchingMore = false
    var data: [EquipmentCalibrationData] = []
    weak var delegate: CalibrationInformationViewDelegate?
    weak var parentView: EquipmentMaintenanceView?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.data.removeAll()
    }
    
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: "Kalibrasi")
    }
    
}

extension CalibrationInformationView {
    
    private func setupBody() {
        setupView()
        setupTableView()
        fetchInitialData()
        bindingData()
    }
    
    private func setupView() {
        emptyView.configure("Oppsss Kalibrasi Kosong", description: "Maaf, informasi kalibrasi mengenai pemeliharaan asset belum tersedia saat ini.")
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
        presenter.fetchCalibrationData(limit: self.limit, id: presenter.idAsset, page: self.page)
    }
    
    private func bindingData() {
        guard let view = parentView,
              let presenter = view.presenter
        else { return }
        presenter.$equipmentCalibrationInfoData
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
        presenter.fetchCalibrationData(limit: self.limit, id: presenter.idAsset ?? "", page: self.page)
    }
    
}

extension CalibrationInformationView: SkeletonTableViewDataSource, SkeletonTableViewDelegate, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AssetMaintenanceInfoCell.identifier, for: indexPath) as? AssetMaintenanceInfoCell
        else {
            return UITableViewCell()
        }
        
        let adjustedData = self.data[indexPath.row]
        let id = adjustedData.id ?? ""
        let date = adjustedData.tglKalibrasi ?? ""
        
        let titleStatus = NSAttributedString.stylizedText("Status: ", font: UIFont.robotoBold(10), color: UIColor.customPlaceholderColor)
        let statusLabel = NSAttributedString.stylizedText(adjustedData.sttLaik ?? "-", font: UIFont.robotoBold(10), color: UIColor.customDarkGrayColor)
        let fullStatusLabel = NSMutableAttributedString()
        fullStatusLabel.append(titleStatus)
        fullStatusLabel.append(statusLabel)
        
        let evaluationTitle = NSAttributedString.stylizedText("Evaluasi & Rekomendasi: ", font: UIFont.robotoBold(10), color: UIColor.customPlaceholderColor)
        let evaluationLabel = NSAttributedString.stylizedText(adjustedData.metode ?? "-", font: UIFont.robotoBold(10), color: UIColor.customDarkGrayColor)
        let fullEvaluationTitle = NSMutableAttributedString()
        fullEvaluationTitle.append(evaluationTitle)
        fullEvaluationTitle.append(evaluationLabel)
        
        let technicianTitle = NSAttributedString.stylizedText("Teknisi: ", font: UIFont.robotoBold(10), color: UIColor.customPlaceholderColor)
        let technicianLabel = NSAttributedString.stylizedText(adjustedData.petugas ?? "-", font: UIFont.robotoBold(10), color: UIColor.customDarkGrayColor)
        let fullTechnicianLabel = NSMutableAttributedString()
        fullTechnicianLabel.append(technicianTitle)
        fullTechnicianLabel.append(technicianLabel)
        
        cell.setupCell(serialNumber: id, firstDate: date, firstText: fullStatusLabel, secondText: fullEvaluationTitle, thirdText: fullTechnicianLabel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate else { return }
        let id = self.data[indexPath.row].id ?? ""
        delegate.didTapCalibrationItem(id: id)
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
