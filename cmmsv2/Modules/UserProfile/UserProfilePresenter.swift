//
//  UserProfilePresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/01/24.
//

import UIKit

class UserProfilePresenter: BasePresenter {
    
    private let interactor: UserProfileInteractor
    private let router = UserProfileRouter()
    
    @Published public var userProfile: User?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    init(interactor: UserProfileInteractor) {
        self.interactor = interactor
    }
    
}

extension UserProfilePresenter {
    
    func fetchInitData() {
        self.isLoading = true
        interactor.getUserProfile()
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
                receiveValue: { user in
                    DispatchQueue.main.async {
                        guard let userData = user.data,
                              let userProfile = userData.user
                        else { return }
                        
                        self.userProfile = userProfile
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}

extension UserProfilePresenter {
    
    func backToPreviousPage(navigation: UINavigationController) {
        router.backToPreviousPage(navigation: navigation)
    }
    
    func navigateToChangePassword(navigation: UINavigationController) {
        router.goToChangePassword(navigation: navigation)
    }
    
    func navigateToEditProfile(navigation: UINavigationController) {
        router.goToEditProfile(navigation: navigation)
    }
    
    func navigateToLoginPage(navigation: UINavigationController, data: HospitalTheme) {
        router.navigateToLoginPage(navigation: navigation, data: data)
    }
    
    func showLogoutPopUp(navigation: UINavigationController, delegate: LogoutPopUpBottomSheetDelegate) {
        router.showPopUpLogout(navigation: navigation, delegate: delegate)
    }
    
    func showBottomSheetChangePicture(navigation: UINavigationController) {
        router.showChangePictureBottomSheet(navigation: navigation)
    }
    
}
