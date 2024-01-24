//
//  LoginPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/01/24.
//

import Foundation
import UIKit

class LoginPresenter: BasePresenter {
    
    private let interactor: LoginInteractor
    private let router = LoginRouter()
    
    @Published public var userProfile: User?
    @Published public var userData: UserProfileEntity?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    init(interactor: LoginInteractor) {
        self.interactor = interactor
    }
    
}

extension LoginPresenter {
    
    func loginUser(username: String, password: String, navigation: UINavigationController) {
        self.isLoading = true
        interactor.loginUser(username: username, password: password)
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
                    guard let userData = user.data,
                          let userProfile = userData.user
                    else { return }
                    
                    switch user.message {
                    case .success:
                        UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
                        
                        self.userProfile = userProfile
                        self.userData = user
                        self.navigateToHomeScreen(navigation: navigation)
                    case .errors:
                        self.isError = true
                    default: break
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}

extension LoginPresenter {
    
    func navigateToHomeScreen(navigation: UINavigationController) {
        router.goToHomeScreen(navigation: navigation)
    }
    
}
