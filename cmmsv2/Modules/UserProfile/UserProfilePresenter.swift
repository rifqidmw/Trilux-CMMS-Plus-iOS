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
    
    init(interactor: UserProfileInteractor) {
        self.interactor = interactor
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
    
    func showLogoutPopUp(navigation: UINavigationController) {
        router.showPopUpLogout(navigation: navigation)
    }
    
    func showBottomSheetChangePicture(navigation: UINavigationController) {
        router.showChangePictureBottomSheet(navigation: navigation)
    }
    
}
