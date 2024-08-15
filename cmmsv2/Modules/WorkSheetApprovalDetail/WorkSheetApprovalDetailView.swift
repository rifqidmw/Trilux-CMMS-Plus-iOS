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
        containerAssetStackView.addShadow(2, position: .bottom, opacity: 0.2)
        assetImageView.makeCornerRadius(8, .topCurve)
        detailButton.configure(title: "Rincian", type: .bordered)
        approveButton.configure(title: "Setujui")
    }
    
    private func setupAction() {
        customNavigationView.arrowLeftBackButton.gesture()
            .sink { [weak self] _ in
                guard let self, let navigation = self.navigationController else { return }
                navigation.popViewController(animated: true)
            }
            .store(in: &anyCancellable)
    }
    
    private func fetchInitialData() {
        guard let presenter else { return }
        presenter.fetchInitData()
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$approvalData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self, let rating = data?.data?.woDetail?.valRating else { return }
                self.hideLoadingPopup()
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
            }
            .store(in: &anyCancellable)
        
        presenter.$isLoading
            .sink { [weak self] isLoading in
                guard let self else { return }
                isLoading ? self.showLoadingPopup() : self.hideLoadingPopup()
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
