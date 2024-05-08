//
//  AssetDetailView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 01/05/24.
//

import UIKit
import XLPagerTabStrip
import SkeletonView

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
    @Published public var generalInfoData: EquipmentDetail?
    @Published public var filesData: [File] = []
    @Published public var costData: EquipmentMainCoast?
    @Published public var technicalData: EquipmentTechnical?
    @Published public var acceptanceData: DeliveryAcceptanceData?
    @Published public var isLoading: Bool = false
    var maxContentHeight: CGFloat = 0
    
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
        
        presenter.$assetTechnicalData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self = self else { return }
                if let data = data {
                    self.technicalData = data
                }
            }
            .store(in: &anyCancellable)
        
        presenter.$assetAcceptanceData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self = self else { return }
                if let data = data {
                    self.acceptanceData = data
                }
            }
            .store(in: &anyCancellable)
        
        presenter.$assetCostData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self = self else { return }
                if let data = data {
                    self.costData = data
                }
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
                isLoad ? self.showAnimationSkeleton() : self.hideAnimationSkeleton()
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
        generalInformation.parentView = self
        
        let toolsInformation = ToolsInformationView(nibName: String(describing: ToolsInformationView.self), bundle: nil)
        toolsInformation.parentView = self
        
        let acceptanceInformation = AcceptanceInformationView(nibName: String(describing: AcceptanceInformationView.self), bundle: nil)
        acceptanceInformation.parentView = self
        
        let mutationInformation = MutationInformationView(nibName: String(describing: MutationInformationView.self), bundle: nil)
        mutationInformation.parentView = self
        
        let additionalDocument = AdditionalDocumentsView(nibName: String(describing: AdditionalDocumentsView.self), bundle: nil)
        additionalDocument.parentView = self
        
        self.views = [generalInformation, toolsInformation, acceptanceInformation, mutationInformation, additionalDocument]
    }
    
    private func showAnimationSkeleton() {
        [self.assetImageView,
         self.assetNameLabel,
         self.serialNumberLabel,
         self.assetTypeLabel,
         self.seeProgressButton].forEach {
            $0.isSkeletonable = true
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideAnimationSkeleton() {
        [self.assetImageView,
         self.assetNameLabel,
         self.serialNumberLabel,
         self.assetTypeLabel,
         self.seeProgressButton].forEach {
            $0.hideSkeleton()
        }
    }
    
}
