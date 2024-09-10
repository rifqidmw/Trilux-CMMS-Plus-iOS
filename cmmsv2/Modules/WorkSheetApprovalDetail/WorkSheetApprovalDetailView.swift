//
//  WorkSheetApprovalDetailView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/08/24.
//

import UIKit

class WorkSheetApprovalDetailView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var containerRatingView: UIView!
    @IBOutlet weak var ratingByUserTitleLabel: UILabel!
    @IBOutlet weak var firstStarIconImageView: UIImageView!
    @IBOutlet weak var secondStarIconImageView: UIImageView!
    @IBOutlet weak var thirdStarIconImageView: UIImageView!
    @IBOutlet weak var fourthStarIconImageView: UIImageView!
    @IBOutlet weak var fifthStarIconImageView: UIImageView!
    
    @IBOutlet weak var containerAssetStackView: UIStackView!
    @IBOutlet weak var assetImageView: UIImageView!
    @IBOutlet weak var assetTitleLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var assetSerialNumberLabel: UILabel!
    @IBOutlet weak var assetInventarisLabel: UILabel!
    
    @IBOutlet weak var serialNumberView: InformationCardView!
    @IBOutlet weak var dateLkView: InformationCardView!
    @IBOutlet weak var responseLkTimeView: InformationCardView!
    @IBOutlet weak var startTimeLkView: InformationCardView!
    @IBOutlet weak var endTimeLkView: InformationCardView!
    @IBOutlet weak var workDurationLkView: InformationCardView!
    
    @IBOutlet weak var detailButton: GeneralButton!
    @IBOutlet weak var approveButton: GeneralButton!
    
    var presenter: WorkSheetApprovalDetailPresenter?
    var data: HistoryDetailEntity?
    
    override func didLoad() {
        super.didLoad()
        self.validateUser()
        self.setupBody()
    }
    
}

extension WorkSheetApprovalDetailView {
    
    private func setupBody() {
        setupView()
        setupAction()
        bindingData()
        fetchInitialData()
    }
    
    private func setupView() {
        customNavigationView.configure(toolbarTitle: "Approval Lembar Kerja", type: .plain)
        containerAssetStackView.makeCornerRadius(8)
        containerAssetStackView.addShadow(4, position: .bottom, opacity: 0.2)
        assetImageView.makeCornerRadius(8, .topCurve)
        detailButton.configure(title: "Rincian", type: .bordered)
    }
    
    private func setupAction() {
        guard let presenter else { return }
        customNavigationView.arrowLeftBackButton.gesture()
            .sink { [weak self] _ in
                guard let self, let navigation = self.navigationController else { return }
                navigation.popViewController(animated: true)
            }
            .store(in: &anyCancellable)
        
        detailButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController,
                      let detail = data?.data
                else { return }
                let data = WorkSheetRequestEntity(id: detail.woDetail?.valEngineerId, action: "lihat")
                presenter.navigateToDetailWorkSheet(navigation, data: data, type: .monitoring)
            }
            .store(in: &anyCancellable)
    }
    
    private func fetchInitialData() {
        guard let presenter else { return }
        self.showLoadingPopup()
        presenter.fetchInitData()
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$approvalData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self,
                      let detail = data?.data,
                      let woDetail = detail.woDetail
                else { return }
                
                let rating = woDetail.valRating ?? ""
                self.hideLoadingPopup()
                self.data = data
                self.userImageView.layer.cornerRadius = self.userImageView.bounds.width / 2
                self.userImageView.clipsToBounds = true
                self.userImageView.loadImageUrl(data?.data?.woDetail?.valEngineerAvatar ?? "-")
                self.userNameLabel.text = data?.data?.woDetail?.txtEngineerName ?? "-"
                self.updateStarIcons(rating: Int(rating) ?? 0)
                
                self.assetImageView.loadImageUrl(data?.data?.woDetail?.equipment?.valImage ?? "-")
                self.assetTitleLabel.text = data?.data?.woDetail?.equipment?.txtName ?? "-"
                self.roomLabel.text = data?.data?.woDetail?.equipment?.txtRuangan ?? "-"
                self.assetSerialNumberLabel.text = "\(data?.data?.woDetail?.equipment?.txtSerial ?? "-") - \(data?.data?.woDetail?.equipment?.txtBrand ?? "-")"
                self.assetInventarisLabel.text = data?.data?.woDetail?.equipment?.txtInventaris ?? "-"
                
                self.serialNumberView.configureView(title: "Nomor Lembar Kerja", value: data?.data?.woDetail?.valWoNumber ?? "-")
                self.dateLkView.configureView(title: "Tanggal", value: data?.data?.woDetail?.valDelegatedTime ?? "-")
                self.responseLkTimeView.configureView(title: "Response", value: data?.data?.woDetail?.complain?.txtResponseTime ?? "-")
                self.startTimeLkView.configureView(title: "Mulai Bekerja", value: data?.data?.woDetail?.valStartTime ?? "-")
                self.endTimeLkView.configureView(title: "Selesai Bekerja", value: data?.data?.woDetail?.valEndTime ?? "-")
                self.workDurationLkView.configureView(title: "Durasi Bekerja", value: data?.data?.woDetail?.valDuration ?? "-")
                
                if woDetail.complain?.valStatus == "1" {
                    approveButton.configure(title: "Setujui")
                    approvingWorkSheet()
                    
                } else {
                    approveButton.configure(title: "Disetujui", backgroundColor: UIColor.customPlaceholderColor, titleColor: UIColor.customLightGrayColor)
                }
                
                if data?.status == 404 {
                    self.showAlert(title: "Terjadi Kesalahan", message: data?.message) {
                        guard let navigation = self.navigationController else { return }
                        navigation.popViewController(animated: true)
                    }
                }
            }
            .store(in: &anyCancellable)
        
        presenter.$approvalWorkSheet
            .sink { [weak self] data in
                guard let self, let data else { return }
                self.hideLoadingPopup()
                if data.message == "Success" {
                    presenter.fetchInitData()
                    approveButton.configure(title: "Disetujui", backgroundColor: UIColor.customPlaceholderColor, titleColor: UIColor.customLightGrayColor)
                    approveButton.layoutIfNeeded()
                } else {
                    self.showAlert(title: "Terjadi Kesalahan", message: data.message)
                }
            }
            .store(in: &anyCancellable)
    }
    
    private func approvingWorkSheet() {
        approveButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let detail = self.data?.data?.woDetail,
                      let presenter
                else { return }
                self.showLoadingPopup()
                let requestData = ApproveWorkSheetRequest(woId: detail.valEngineerId, status: detail.stt_qr)
                presenter.approvingWorkSheet(data: requestData)
            }
            .store(in: &anyCancellable)
    }
    
}

extension WorkSheetApprovalDetailView {
    
    private func updateStarIcons(rating: Int) {
        let starImageViews = [firstStarIconImageView, secondStarIconImageView, thirdStarIconImageView, fourthStarIconImageView, fifthStarIconImageView]
        
        for (index, imageView) in starImageViews.enumerated() {
            if index < rating {
                imageView?.image = UIImage(named: "ic_star_fill")
            } else {
                imageView?.image = UIImage(named: "ic_star_opacity")
            }
        }
    }
    
}
