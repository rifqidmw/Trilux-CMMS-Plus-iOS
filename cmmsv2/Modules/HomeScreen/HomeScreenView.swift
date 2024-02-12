//
//  HomeScreenView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/01/24.
//

import UIKit

class HomeScreenView: BaseViewController {
    
    @IBOutlet weak var navigationView: CustomNavigationView!
    @IBOutlet weak var searchButton: GeneralButton!
    @IBOutlet weak var categoryView: CategorySectionView!
    @IBOutlet weak var scanningButton: GeneralButton!
    
    var presenter: HomeScreenPresenter?
    
    override func didLoad() {
        super.didLoad()
        setupBody()
    }
    
}

extension HomeScreenView {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        guard let txtName = UserDefaults.standard.string(forKey: "txtName"),
              let hospitalName = UserDefaults.standard.string(forKey: "hospitalName"),
              let image = UserDefaults.standard.string(forKey: "valImage")
        else { return }
        
        navigationView.configure(username: txtName, headline: hospitalName, image: image, type: .homeToolbar)
        searchButton.configure(type: .searchbutton)
        scanningButton.configure(title: "Scanning Alat", type: .withIcon, icon: "ic_scan")
        categoryView.delegate = self
    }
    
    private func setupAction() {
        scanningButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController,
                      let presenter = self.presenter
                else {
                    return
                }
                
                self.showOverlay()
                presenter.showBottomSheetDetailInformation(navigation: navigation)
            }
            .store(in: &anyCancellable)
        
        navigationView.profileImageView.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let presenter,
                      let navigation = self.navigationController
                else { return }
                
                presenter.navigateToUserProfile(navigation: navigation)
            }
            .store(in: &anyCancellable)
    }
    
}

extension HomeScreenView: HomeScreenCategoryDelegate {
    
    func didTapAllCategory() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        self.showOverlay()
        presenter.showBottomSheetAllCategories(navigation: navigation)
    }
    
    func didTapAsset() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        self.showOverlay()
        presenter.showBottomSheetAsset(navigation: navigation)
    }
    
    func didTapComplaint() {
        AppLogger.log("CLICKED")
    }
    
    func didTapWorkSheet() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        self.showOverlay()
        presenter.showBottomSheetWorkSheet(navigation: navigation)
    }
    
    func didTapPreventiveMaintenance() {
        AppLogger.log("CLICKED")
    }
    
    func didTapCalibration() {
        AppLogger.log("CLICKED")
    }
    
    func didTapHistory() {
        AppLogger.log("CLICKED")
    }
    
    func didTapLogBook() {
        AppLogger.log("CLICKED")
    }
    
    func didTapToolSuggestions() {
        AppLogger.log("CLICKED")
    }
    
    func didTapPreventiveCalendar() {
        AppLogger.log("CLICKED")
    }
    
}
