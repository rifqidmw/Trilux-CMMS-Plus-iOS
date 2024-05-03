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
    var maxContentHeight: CGFloat = 0
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.setupStripTabBar(in: stripTabBarView)
    }
    
}

extension AssetDetailView {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupStripView()
        observeContentHeight()
    }
    
    private func setupView() {
        customNavigationView.configure(type: .plain)
        customNavigationView.arrowLeftBackButton.tintColor = .white
        assetImageView.makeCornerRadius(12)
        headerView.makeCornerRadius(12)
        containerTabBarView.makeCornerRadius(12)
        seeDetailButton.makeCornerRadius(12)
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
        
        let toolsInformation = ToolsInformationView(nibName: String(describing: ToolsInformationView.self), bundle: nil)
        
        let acceptanceInformation = AcceptanceInformationView(nibName: String(describing: AcceptanceInformationView.self), bundle: nil)
        
        self.views = [generalInformation, toolsInformation, acceptanceInformation]
    }
    
    private func observeContentHeight() {
        NotificationCenter.default.addObserver(forName: Notification.Name("ContentHeightDidChange"), object: nil, queue: .main) { [weak self] notification in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if let height = notification.userInfo?["contentHeight"] as? CGFloat {
                    UIView.animate(withDuration: 0.3) {
                        self.stripTabBarViewHeightConstraint.constant = height
                        self.view.layoutIfNeeded()
                    }
                }
            }
        }
    }
    
}
