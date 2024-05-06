//
//  AssetDetailView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 01/05/24.
//

import UIKit
import XLPagerTabStrip

class AssetDetailView: BaseViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var containerContentStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerHeaderView: UIView!
    @IBOutlet weak var containerTabBarView: UIView!
    @IBOutlet weak var seeDetailButton: UIView!
    @IBOutlet weak var assetImageView: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var assetNameLabel: UILabel!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var assetTypeLabel: UILabel!
    @IBOutlet weak var seeProgressButton: GeneralButton!
    @IBOutlet weak var stripTabBarView: UIView!
    @IBOutlet weak var stripTabBarViewHeightConstraint: NSLayoutConstraint!
    
    var presenter: AssetDetailPresenter?
    var generalInfoData: EquipmentDetail?
    var filesData: [File] = []
    var costData: EquipmentMainCoast?
    var technicalData: EquipmentTechnical?
    var acceptanceData: DeliveryAcceptanceData?
    var maxContentHeight: CGFloat = 0
    
    var generalInfoView: GeneralInformationView?
    var toolsInfoView: ToolsInformationView?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.setupStripTabBar(in: stripTabBarView)
        self.observeContentHeight(heightConstraint: stripTabBarViewHeightConstraint)
    }
    
}

extension AssetDetailView {
    
    private func setupBody() {
        fetchInitialData()
        bindingData()
        setupView()
        setupAction()
        setupStripView()
    }
    
    private func fetchInitialData() {
        guard let presenter else { return }
        presenter.fetchInitialData()
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$assetInfoData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self = self else { return }
                if let data = data {
                    self.generalInfoData = data
                    self.assetNameLabel.text = data.txtName
                    self.assetImageView.loadImageUrl(data.valImage ?? "")
                    self.serialNumberLabel.text = "SN: \(data.txtSerial ?? "")"
                    self.assetTypeLabel.text = presenter.type == .medic ? "Medic" : "Non-Medic"
                }
            }
            .store(in: &anyCancellable)
    }
    
    private func setupGeneralInfoView() {
        if let assetGeneralView = self.generalInfoView,
           let data = self.generalInfoData {
            assetGeneralView.ownerInfoView.configure(infoTitle: "Pemilik", icon: "ic_user_rounded_square", detailInfoTitle: data.txtRuangan ?? "-N/A-", detailInfoDesc: data.txtSubRuangan ?? "-N/A-")
            assetGeneralView.locationInfoView.configure(infoTitle: "Lokasi", icon: "ic_pin_location_rounded_square", detailInfoTitle: data.txtLokasiInstalasi ?? "-N/A-", detailInfoDesc: data.txtLokasiName ?? "-N/A-")
        }
    }
    
    private func setupToolsInfoView() {
        if let assetToolsView = self.toolsInfoView,
           let data = self.generalInfoData {
            assetToolsView.serialNumberView.configureView(title: "Serial Number", value: data.txtSerial ?? "-N/A-")
            assetToolsView.toolTypeView.configureView(title: "Tipe Alat", value: data.txtType ?? "-N/A-")
            assetToolsView.distributorView.configureView(title: "Distributor", value: data.txtDistributor ?? "-N/A-")
            assetToolsView.ageBenefitView.configureView(title: "Usia Manfaat", value: data.txtUsiaTeknis ?? "-N/A-")
            assetToolsView.simakView.configureView(title: "Simak", value: data.nameSimak ?? "-N/A-")
            assetToolsView.aspakView.configureView(title: "Aspak", value: data.syncAspak ?? "-N/A-")
        }
    }
    
    private func setupView() {
        customNavigationView.configure(type: .plain)
        customNavigationView.arrowLeftBackButton.tintColor = .white
        assetImageView.makeCornerRadius(12)
        headerView.makeCornerRadius(12)
        headerView.addShadow(0.8)
        containerTabBarView.makeCornerRadius(12)
        containerTabBarView.addShadow(0.8)
        seeDetailButton.makeCornerRadius(12)
        seeDetailButton.addShadow(0.8)
        seeProgressButton.configure(title: "Lihat Progres", type: .bordered, backgroundColor: .white, titleColor: UIColor.customDarkGrayColor)
    }
    
    private func setupAction() {
        seeDetailButton.gesture()
            .sink { [weak self] _ in
                guard self != nil else { return }
                AppLogger.log("-- CLICKED")
            }
            .store(in: &anyCancellable)
        
        seeProgressButton.gesture()
            .sink { [weak self] _ in
                guard self != nil else { return }
                AppLogger.log("-- CLICKED")
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
    
    private func setupStripView() {
        let generalInformation = GeneralInformationView(nibName: String(describing: GeneralInformationView.self), bundle: nil)
        self.generalInfoView = generalInformation
        
        let toolsInformation = ToolsInformationView(nibName: String(describing: ToolsInformationView.self), bundle: nil)
        self.toolsInfoView = toolsInformation
        
        let acceptanceInformation = AcceptanceInformationView(nibName: String(describing: AcceptanceInformationView.self), bundle: nil)
        
        let mutationInformation = MutationInformationView(nibName: String(describing: MutationInformationView.self), bundle: nil)
        
        let additionalDocument = AdditionalDocumentsView(nibName: String(describing: AdditionalDocumentsView.self), bundle: nil)
        
        self.views = [generalInformation, toolsInformation, acceptanceInformation, mutationInformation, additionalDocument]
    }
    
}
