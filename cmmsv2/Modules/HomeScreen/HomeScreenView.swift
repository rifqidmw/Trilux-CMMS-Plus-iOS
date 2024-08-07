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
        scanningButton.configure(title: "Scan Alat", type: .withIcon, icon: "ic_scan")
        categoryView.delegate = self
        categoryView.updateDataForRole()
    }
    
    private func checkStoredNotificationList(_ data: [NotificationList]) {
        guard let storedNotifications = AppManager.getNotificationList() else { return }
        if storedNotifications.isEqual(to: data) {
            AppManager.setIsOpenedNotification(false)
        } else {
            AppManager.setIsOpenedNotification(true)
            AppManager.setNotificationList(data)
        }
    }
    
    private func fetchInitData() {
        guard let presenter else { return }
        presenter.fetchInitData()
        presenter.fetchListNotificationData()
        if RoleManager.shared.currentUserRole == .engineer {
            presenter.fetchReminderPreventive(date: String.getCurrentDateString("yyyy-MM-dd"))
        }
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
                    presenter.showExpiredBottomSheet(navigation: navigation, expiredDate: data.expiredDate)
                }
            }
            .store(in: &anyCancellable)
        
        presenter.$reminderData
            .sink { [weak self] data in
                guard let self = self,
                      let detail = data,
                      let list = detail.data,
                      !list.isEmpty,
                      let navigation = self.navigationController
                else { return }
                
                presenter.reminderList = list
                presenter.showReminderPreventiveBottomSheet(navigation: navigation, delegate: self)
            }
            .store(in: &anyCancellable)
        
        presenter.$notification
            .sink { [weak self] data in
                guard let self else { return }
                self.checkStoredNotificationList(data)
            }
            .store(in: &anyCancellable)
    }
    
    private func setupNavigationView() {
        guard let hospital = AppManager.getHospital(),
              let user = AppManager.getUser(),
              let name = user.txtName,
              let hospitalName = hospital.name,
              let image = user.valImage,
              let position = user.valPosition
        else { return }
        RoleManager.shared.updateRole(with: position)
        self.navigationView.configure(username: name, headline: hospitalName, image: image, type: .homeToolbar)
    }
    
    private func setupAction() {
        guard let presenter else { return }
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
                      let navigation = self.navigationController
                else { return }
                presenter.navigateToUserProfile(navigation: navigation)
            }
            .store(in: &anyCancellable)
        
        navigationView.notificationView.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                presenter.navigateToNotificationList(navigation: navigation)
            }
            .store(in: &anyCancellable)
        
        searchButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                presenter.navigateToAssetFilter(from: navigation)
            }
            .store(in: &anyCancellable)
    }
    
}
