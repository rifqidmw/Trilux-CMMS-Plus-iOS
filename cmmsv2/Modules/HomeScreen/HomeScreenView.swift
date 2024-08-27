//
//  HomeScreenView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/01/24.
//

import UIKit
import DGCharts

class HomeScreenView: BaseViewController {
    
    @IBOutlet weak var navigationView: CustomNavigationView!
    @IBOutlet weak var searchButton: GeneralButton!
    @IBOutlet weak var categoryView: CategorySectionView!
    @IBOutlet weak var scanningButton: GeneralButton!
    @IBOutlet weak var bannerButton: UIImageView!
    @IBOutlet weak var complaintChartSectionView: DashboardChartView!
    @IBOutlet weak var correctiveChartSectionView: DashboardChartView!
    @IBOutlet weak var medicChartSectionView: DashboardChartView!
    @IBOutlet weak var nonMedicChartSectionView: DashboardChartView!
    @IBOutlet weak var assetChartSectionView: DashboardChartView!
    
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
        bannerButton.makeCornerRadius(8)
        bannerButton.addShadow(0.2)
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
        presenter.fetchDashboardStatistic()
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
        
        presenter.$dashboardStatistic
            .sink { [weak self] data in
                guard let self, let statistic = data?.data?.woStatistics else { return }
                self.configureComplaintChart(statistic)
                self.configureCorrectiveChart(statistic)
                self.configureMedicChart(statistic)
                self.configureNonMedicChart(statistic)
                self.configureAssetChart(statistic)
                
                if RoleManager.shared.currentUserRole == .room {
                    self.medicChartSectionView.isHidden = true
                    self.nonMedicChartSectionView.isHidden = true
                } else {
                    self.assetChartSectionView.isHidden = true
                }
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
        
        bannerButton.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                self.showAlert(title: "Dashboard Page")
            }
            .store(in: &anyCancellable)
    }
    
}

extension HomeScreenView {
    
    private func configureComplaintChart(_ data: [WOStatistic]) {
        let filteredComplaintItem = data.filter { $0.name?.hasPrefix("Pengaduan") ?? false }
        let complaintEntries = filteredComplaintItem.compactMap { item in
            let pieChartEntries = PieChartDataEntry(value: Double(item.count ?? "") ?? 0.0, label: item.name)
            return pieChartEntries
        }
        let complaintDataSet = PieChartDataSet(entries: complaintEntries)
        let complaintColorSet = [UIColor.customPrimaryColor, UIColor.customDarkYellowColor, UIColor.customGreenColor]
        let totalComplaintCount = filteredComplaintItem.reduce(0) { result, item in
            result + (Int(item.count ?? "") ?? 0)
        }
        let data = ChartAppearanceEntity(
            titleSection: "Pengaduan",
            pieEntries: complaintEntries,
            pieDataSet: complaintDataSet,
            pieChartColors: complaintColorSet,
            centerPieChartText: String(totalComplaintCount),
            pieChartTitleText: "Total Pengaduan",
            chartCount: String(totalComplaintCount),
            barStatistic: filteredComplaintItem)
        
        self.complaintChartSectionView.configure(data, from: .complaint)
        self.complaintChartSectionView.delegate = self
    }
    
    private func configureCorrectiveChart(_ data: [WOStatistic]) {
        let filteredCorrectiveItem = data.filter { $0.name?.hasPrefix("Korektif") ?? false }
        let correctiveEntries = filteredCorrectiveItem.compactMap { item in
            let correctiveChartEntrie = PieChartDataEntry(value: Double(item.count ?? "") ?? 0.0, label: item.name)
            return correctiveChartEntrie
        }
        let correctiveDataSet = PieChartDataSet(entries: correctiveEntries)
        let correctiveColorSet = [UIColor.customPrimaryColor, UIColor.customDarkYellowColor, UIColor.customRedColor]
        let totalCorrectiveCount = filteredCorrectiveItem.reduce(0) { result, item in
            result + (Int(item.count ?? "") ?? 0)
        }
        let data = ChartAppearanceEntity(
            titleSection: "Korektif",
            pieEntries: correctiveEntries,
            pieDataSet: correctiveDataSet,
            pieChartColors: correctiveColorSet,
            centerPieChartText: String(totalCorrectiveCount),
            pieChartTitleText: "Total Korektif",
            chartCount: String(totalCorrectiveCount),
            barStatistic: filteredCorrectiveItem)
        
        self.correctiveChartSectionView.configure(data, from: .corrective)
        self.correctiveChartSectionView.delegate = self
    }
    
    private func configureMedicChart(_ data: [WOStatistic]) {
        let filteredMedicItem = data.filter {
            ($0.name?.contains("alat medik") ?? false) && $0.name != "Total alat alat medik"
        }
        
        let medicEntries = filteredMedicItem.compactMap { item in
            let medicChartEntries = PieChartDataEntry(value: Double(item.count ?? "") ?? 0.0, label: item.name)
            return medicChartEntries
        }
        let medicDataSet = PieChartDataSet(entries: medicEntries)
        let medicTotalCount = filteredMedicItem.reduce(0) { result, item in
            result + (Int(item.count ?? "") ?? 0)
        }
        let data = ChartAppearanceEntity(
            titleSection: "Alat Medik",
            pieEntries: medicEntries,
            pieDataSet: medicDataSet,
            pieChartColors: assetStatisticColors,
            centerPieChartText: String(medicTotalCount),
            pieChartTitleText: "Total Alat Medik",
            chartCount: String(medicTotalCount),
            barStatistic: filteredMedicItem)
        
        self.medicChartSectionView.configure(data, from: .medic)
        self.medicChartSectionView.delegate = self
    }
    
    private func configureNonMedicChart(_ data: [WOStatistic]) {
        let filteredNonMedicItem = data.filter {
            ($0.name?.contains("alat non") ?? false) && $0.name != "Total alat alat medik"
        }
        
        let nonMedicEntries = filteredNonMedicItem.compactMap { item in
            let nonMedicChartEntries = PieChartDataEntry(value: Double(item.count ?? "") ?? 0.0, label: item.name)
            return nonMedicChartEntries
        }
        let nonMedicChartSet = PieChartDataSet(entries: nonMedicEntries)
        let nonMedicChartCount = filteredNonMedicItem.reduce(0) { result, item in
            result + (Int(item.count ?? "") ?? 0)
        }
        let data = ChartAppearanceEntity(
            titleSection: "Alat Non Medik",
            pieEntries: nonMedicEntries,
            pieDataSet: nonMedicChartSet,
            pieChartColors: assetStatisticColors,
            centerPieChartText: String(nonMedicChartCount),
            pieChartTitleText: "Total Alat Non Medik",
            chartCount: String(nonMedicChartCount),
            barStatistic: filteredNonMedicItem)
        
        self.nonMedicChartSectionView.configure(data, from: .nonMedic)
        self.nonMedicChartSectionView.delegate = self
    }
    
    private func configureAssetChart(_ data: [WOStatistic]) {
        let filteredAssetItem = data.filter { ($0.name?.contains("alat") ?? false) }
        
        let assetEntries = filteredAssetItem.compactMap { item in
            let allAssetEntries = PieChartDataEntry(value: Double(item.count ?? "") ?? 0.0, label: item.name)
            return allAssetEntries
        }
        let assetChartSet = PieChartDataSet(entries: assetEntries)
        let assetChartCount = filteredAssetItem.reduce(0) { result, item in
            result + (Int(item.count ?? "") ?? 0)
        }
        let data = ChartAppearanceEntity(
            titleSection: "Alat",
            pieEntries: assetEntries,
            pieDataSet: assetChartSet,
            pieChartColors: assetStatisticColors,
            centerPieChartText: String(assetChartCount),
            pieChartTitleText: "Total Alat",
            chartCount: String(assetChartCount),
            barStatistic: filteredAssetItem)
        
        self.assetChartSectionView.configure(data, from: .medic)
        self.assetChartSectionView.delegate = self
    }
    
}
