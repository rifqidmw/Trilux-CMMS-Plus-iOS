//
//  UserProfilePresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/01/24.
//

import Foundation
import UIKit

class UserProfilePresenter: BasePresenter {
    
    private let interactor: UserProfileInteractor
    private let router = UserProfileRouter()
    
    @Published public var userProfile: User?
    @Published public var userProfileImage: EditProfileUser?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isLoadProfile: Bool = false
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
                        UserDefaults.standard.setValue(userProfile.txtName, forKey: "txtName")
                        UserDefaults.standard.setValue(userProfile.valImage, forKey: "valImage")
                        UserDefaults.standard.setValue(userProfile.valImageId, forKey: "valImageId")
                        self.userProfile = userProfile
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func updateProfile(name: String, position: String, workUnit: String, imageId: Int, phoneNumber: String) {
        self.isLoadProfile = true
        interactor.updateProfile(name: name, position: position, workUnit: workUnit, imageId: imageId, phoneNumber: phoneNumber)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        self.isLoadProfile = false
                    case .failure(let error):
                        AppLogger.log(error, logType: .kNetworkResponseError)
                        self.errorMessage = error.localizedDescription
                        self.isLoadProfile = false
                        self.isError = true
                    }
                },
                receiveValue: { user in
                    DispatchQueue.main.async {
                        guard let data = user.data,
                              let profile = data.user
                        else { return }
                        self.userProfileImage = profile
                        self.fetchInitData()
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}

extension UserProfilePresenter {
    
    func navigateToChangePassword(navigation: UINavigationController) {
        router.goToChangePassword(navigation: navigation)
    }
    
    func navigateToEditProfile(navigation: UINavigationController, data: User) {
        router.goToEditProfile(navigation: navigation, data: data)
    }
    
    func navigateToLoginPage(navigation: UINavigationController, data: HospitalTheme) {
        router.navigateToLoginPage(navigation: navigation, data: data)
    }
    
    func showLogoutPopUp(navigation: UINavigationController, delegate: LogoutPopUpBottomSheetDelegate) {
        let bottomSheet = LogoutPopUpBottomSheet(nibName: String(describing: LogoutPopUpBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showBottomSheetSignature(navigation: UINavigationController, data: User, delegate: SignatureBottomSheetDelegate) {
        let bottomSheet = SignatureBottomSheet(nibName: String(describing: SignatureBottomSheet.self), bundle: nil)
        bottomSheet.data = data
        bottomSheet.delegate = delegate
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
}
