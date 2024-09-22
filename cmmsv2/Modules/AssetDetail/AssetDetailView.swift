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
    @IBOutlet weak var updateTechDataButton: GeneralButton!
    @IBOutlet weak var stripTabBarView: UIView!
    @IBOutlet weak var stripTabBarViewHeightConstraint: NSLayoutConstraint!
    
    weak var delegate: AdditionalDocumentsViewDelegate?
    var presenter: AssetDetailPresenter?
    
    @Published public var generalInfoData: EquipmentDetail?
    @Published public var filesData: [File] = []
    @Published public var costData: EquipmentMainCoast?
    @Published public var technicalData: EquipmentTechnical?
    @Published public var acceptanceData: DeliveryAcceptanceData?
    @Published public var isLoading: Bool = false
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.setupStripTabBar(in: stripTabBarView)
        self.observeContentHeight(heightConstraint: stripTabBarViewHeightConstraint)
        self.validateUser()
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
        presenter.$assetData
            .sink { [weak self] data in
                guard let self,
                      let data,
                      let navigation = self.navigationController
                else { return }
                if data.status == 301 {
                    self.showAlert(title: "Terjadi Kesalahan!", message: data.message) {
                        navigation.popViewController(animated: true)
                    }
                }
            }
            .store(in: &anyCancellable)
        
        presenter.$assetInfoData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self = self, let data else { return }
                self.generalInfoData = data
                self.assetNameLabel.text = data.txtName
                self.backgroundImageView.loadImageUrl(data.valImage ?? "")
                self.assetImageView.loadImageUrl(data.valImage ?? "")
                self.serialNumberLabel.text = "SN: \(data.txtSerial ?? "")"
                self.assetTypeLabel.text = presenter.type == .medic ? "Medic" : "Non-Medic"
            }
            .store(in: &anyCancellable)
        
        presenter.$assetTechnicalData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self = self, let data else { return }
                self.technicalData = data
            }
            .store(in: &anyCancellable)
        
        presenter.$assetAcceptanceData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self = self, let data else { return }
                self.acceptanceData = data
            }
            .store(in: &anyCancellable)
        
        presenter.$assetCostData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self = self, let data else { return }
                self.costData = data
            }
            .store(in: &anyCancellable)
        
        presenter.$assetFilesData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self = self else { return }
                self.filesData = data
            }
            .store(in: &anyCancellable)
        
        presenter.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoad in
                guard let self else { return }
                self.isLoading = isLoad
                isLoad ? self.showLoadingPopup() : self.hideLoadingPopup()
            }
            .store(in: &anyCancellable)
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
        seeProgressButton.configure(title: "Lihat Progres", type: .bordered)
        updateTechDataButton.configure(title: "Update Data Teknis", type: .withIcon, icon: "ic_pencil_with_canvas_outline")
        updateTechDataButton.isHidden = RoleManager.shared.currentUserRole == .engineer
        
    }
    
    private func setupAction() {
        guard let presenter else { return }
        seeDetailButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController,
                      let id = presenter.id
                else { return }
                presenter.navigateToDetailInformation(from: navigation, id)
            }
            .store(in: &anyCancellable)
        
        seeProgressButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                if presenter.trackData.isEmpty {
                    self.showAlert(title: "Terjadi kesalahan", message: "Maaf data tidak ditemukan")
                } else {
                    presenter.showTrackingBottomSheet(from: navigation)
                }
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
        
        updateTechDataButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController,
                      let id = presenter.id
                else { return }
                presenter.navigateToUpdateTechnicalData(from: navigation, id)
            }
            .store(in: &anyCancellable)
    }
    
    private func setupStripView() {
        let generalInformation = GeneralInformationView(nibName: String(describing: GeneralInformationView.self), bundle: nil)
        generalInformation.parentView = self
        
        let toolsInformation = ToolsInformationView(nibName: String(describing: ToolsInformationView.self), bundle: nil)
        toolsInformation.parentView = self
        
        let acceptanceInformation = AcceptanceInformationView(nibName: String(describing: AcceptanceInformationView.self), bundle: nil)
        acceptanceInformation.parentView = self
        
        let mutationInformation = MutationInformationView(nibName: String(describing: MutationInformationView.self), bundle: nil)
        mutationInformation.parentView = self
        
        let additionalDocument = AdditionalDocumentsView(nibName: String(describing: AdditionalDocumentsView.self), bundle: nil)
        additionalDocument.parentView = self
        self.delegate = self
        
        self.views = [generalInformation, toolsInformation, acceptanceInformation, mutationInformation, additionalDocument]
    }
    
}

extension AssetDetailView: AdditionalDocumentsViewDelegate {
    
    func didSelectImageDocument(url: String, type: DocumentType) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToDetailDocument(navigation: navigation, file: url, type: type)
    }
    
}
