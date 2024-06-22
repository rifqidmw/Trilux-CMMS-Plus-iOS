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
        self.setupBody()
        self.validateUser()
    }
    
    override func willAppear() {
        super.willAppear()
        self.setupNavigationView()
    }
}

extension HomeScreenView {
    
    private func setupBody() {
        fetchInitData()
        bindingData()
        setupView()
        setupAction()
    }
    
    private func setupView() {
        setupNavigationView()
        searchButton.configure(type: .searchbutton)
        scanningButton.configure(title: "Scanning Alat", type: .withIcon, icon: "ic_scan")
        categoryView.delegate = self
    }
    
    private func fetchInitData() {
        guard let presenter else { return }
        presenter.fetchInitData()
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$expiredData
            .sink { [weak self] data in
                guard let self,
                      let data = data,
                      let navigation = self.navigationController
                else { return }
                if data.isExpired == 1 {
                    self.showOverlay()
                    presenter.showExpiredBottomSheet(navigation: navigation, expiredDate: data.expiredDate)
                }
            }
            .store(in: &anyCancellable)
    }
    
    private func setupNavigationView() {
        guard let name = UserDefaults.standard.string(forKey: "txtName"),
              let hospitalName = UserDefaults.standard.string(forKey: "hospitalName"),
              let image = UserDefaults.standard.string(forKey: "valImage")
        else { return }
        
        navigationView.configure(username: name, headline: hospitalName, image: image, type: .homeToolbar)
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
                
                presenter.navigateToScan(navigation: navigation)
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
        
        navigationView.notificationView.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let presenter,
                      let navigation = self.navigationController
                else { return }
                
                presenter.navigateToNotificationList(navigation: navigation)
            }
            .store(in: &anyCancellable)
    }
    
}
