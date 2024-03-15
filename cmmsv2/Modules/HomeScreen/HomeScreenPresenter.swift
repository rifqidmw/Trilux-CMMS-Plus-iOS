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
    
}

extension HomeScreenPresenter {
    
    func showBottomSheetAllCategories(navigation: UINavigationController) {
        let bottomSheet = AllCategoriesBottomSheet(nibName: String(describing: AllCategoriesBottomSheet.self), bundle: nil)
        router.showBottomSheet(view: bottomSheet, navigation: navigation)
    }
    
    func showBottomSheetWorkSheet(navigation: UINavigationController, delegate: WorkSheetBottomSheetDelegate) {
        let bottomSheet = WorkSheetBottomSheet(nibName: String(describing: WorkSheetBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        router.showBottomSheet(view: bottomSheet, navigation: navigation)
    }
    
    func showBottomSheetAsset(navigation: UINavigationController, delegate: AssetBottomSheetDelegate) {
        let bottomSheet = AssetBottomSheet(nibName: String(describing: AssetBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        router.showBottomSheet(view: bottomSheet, navigation: navigation)
    }
    
    func showExpiredBottomSheet(navigation: UINavigationController, expiredDate: String) {
        let bottomSheet = ExpiredBottomSheet(nibName: String(describing: ExpiredBottomSheet.self), bundle: nil)
        bottomSheet.expiredDate = expiredDate
        router.showBottomSheet(view: bottomSheet, navigation: navigation)
    }
    
    func navigateToWorkSheetList(navigation: UINavigationController) {
        router.navigateToWorkSheetList(navigation: navigation)
    }
    
    func navigateToWorkSheetOnsitePreventive(navigation: UINavigationController) {
        router.navigateToWorkSheetOnsitePreventive(navigation: navigation)
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
    
}
