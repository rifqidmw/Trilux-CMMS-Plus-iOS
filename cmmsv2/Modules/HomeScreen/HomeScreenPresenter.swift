//
//  HomeScreenPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/01/24.
//

import UIKit

class HomeScreenPresenter: BasePresenter {
    
    private let interactor: HomeScreenInteractor
    private let router = HomeScreenRouter()
    
    @Published public var expiredData: ExpiredData?
    @Published public var reminderData: ReminderPreventiveEntity?
    @Published public var notification: [NotificationList] = []
    @Published public var dashboardStatistic: DashboardStatisticEntity?
    var reminderList: [ReminderPreventiveData] = []
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    init(interactor: HomeScreenInteractor) {
        self.interactor = interactor
    }
    
}

extension HomeScreenPresenter {
    
    func fetchInitData() {
        self.isLoading = true
        interactor.getInfoExpired()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        self.isLoading = false
                    case .failure(let error):
                        AppLogger.log(error, logType: .kNetworkResponseError)
                        self.errorMessage = error.localizedDescription
                        self.isLoading = false
                        self.isError = true
                    }
                },
                receiveValue: { expired in
                    DispatchQueue.main.async {
                        self.expiredData = expired.data
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchReminderPreventive(date: String?) {
        self.isLoading = true
        interactor.getReminderPreventive(date: date ?? "")
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        self.isLoading = false
                    case .failure(let error):
                        AppLogger.log(error, logType: .kNetworkResponseError)
                        self.errorMessage = error.localizedDescription
                        self.isLoading = false
                        self.isError = true
                    }
                },
                receiveValue: { reminderData in
                    DispatchQueue.main.async {
                        guard let reminderList = reminderData.data else { return }
                        self.reminderData = reminderData
                        self.reminderList = reminderList
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchListNotificationData() {
        self.isLoading = true
        interactor.getNotification()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        self.isLoading = false
                    case .failure(let error):
                        AppLogger.log(error, logType: .kNetworkResponseError)
                        self.errorMessage = error.localizedDescription
                        self.isLoading = false
                        self.isError = true
                    }
                },
                receiveValue: { notif in
                    DispatchQueue.main.async {
                        guard let data = notif.data,
                              let newNotifications = data.notifications
                        else { return }
                        self.notification = newNotifications
                        AppManager.setNotificationList(newNotifications)
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchDashboardStatistic() {
        self.isLoading = true
        interactor.getStatisticLk()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        self.isLoading = false
                    case .failure(let error):
                        AppLogger.log(error, logType: .kNetworkResponseError)
                        self.errorMessage = error.localizedDescription
                        self.isLoading = false
                        self.isError = true
                    }
                },
                receiveValue: { statistic in
                    DispatchQueue.main.async {
                        self.dashboardStatistic = statistic
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}

extension HomeScreenPresenter {
    
    func showReminderPreventiveBottomSheet(navigation: UINavigationController, delegate: ReminderPreventiveBottomSheetDelegate) {
        let bottomSheet = ReminderPreventiveBottomSheet(nibName: String(describing: ReminderPreventiveBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        bottomSheet.data = self.reminderList
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showBottomSheetAllCategories(navigation: UINavigationController, delegate: AllCategoriesBottomSheetDelegate) {
        let bottomSheet = AllCategoriesBottomSheet(nibName: String(describing: AllCategoriesBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        bottomSheet.updateDataForRole()
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showBottomSheetWorkSheet(navigation: UINavigationController, delegate: WorkSheetBottomSheetDelegate) {
        let bottomSheet = WorkSheetBottomSheet(nibName: String(describing: WorkSheetBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showBottomSheetAsset(navigation: UINavigationController, delegate: AssetBottomSheetDelegate) {
        let bottomSheet = AssetBottomSheet(nibName: String(describing: AssetBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showExpiredBottomSheet(navigation: UINavigationController, expiredDate: String) {
        let bottomSheet = ExpiredBottomSheet(nibName: String(describing: ExpiredBottomSheet.self), bundle: nil)
        bottomSheet.expiredDate = expiredDate
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func navigateToWorkSheetMonitoringList(from navigation: UINavigationController) {
        router.navigateToWorkSheetMonitoringList(from: navigation)
    }
    
    func navigateToWorkSheetCorrective(navigation: UINavigationController) {
        router.navigateToWorkSheetCorrective(navigation: navigation)
    }
    
    func navigateToUserProfile(navigation: UINavigationController) {
        router.goToUserProfile(navigation: navigation)
    }
    
    func navigateToAssetMedicList(navigation: UINavigationController) {
        router.navigateToAssetMedicList(navigation: navigation)
    }
    
    func navigateToAssetNonMedicList(navigation: UINavigationController) {
        router.navigateToAssetNonMedicList(navigation: navigation)
    }
    
    func navigateToScan(navigation: UINavigationController) {
        router.navigateToScan(navigation: navigation)
    }
    
    func navigateToNotificationList(navigation: UINavigationController) {
        router.navigateToNotificationList(navigation: navigation)
    }
    
    func navigateToComplaintList(navigation: UINavigationController) {
        router.navigateToComplaintList(navigation: navigation)
    }
    
    func navigateToCalibrationList(navigation: UINavigationController) {
        router.navigateToCalibrationList(navigation: navigation)
    }
    
    func navigateToPreventiveMaintenanceList(navigation: UINavigationController) {
        router.navigateToPreventiveMaintenanceList(navigation: navigation)
    }
    
    func navigateToDelayCorrectiveList(navigation: UINavigationController) {
        router.navigateToDelayCorrectiveList(navigation: navigation)
    }
    
    func navigateToHistoryList(navigation: UINavigationController) {
        router.navigateToHistoryList(navigation: navigation)
    }
    
    func navigateToLogBook(navigation: UINavigationController) {
        router.navigateToLogBook(navigation: navigation)
    }
    
    func navigateToCalendarPreventive(navigation: UINavigationController) {
        router.navigateToCalendarPreventive(navigation: navigation)
    }
    
    func navigateToWorkSheetApproval(from navigation: UINavigationController) {
        router.navigateToWorkSheetApproval(from: navigation)
    }
    
    func navigateToDashboardPage(navigation: UINavigationController) {
        router.navigateToDashboardPage(navigation: navigation)
    }
    
}
