//
//  LoginPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/01/24.
//

import UIKit
import CoreData

class LoginPresenter: BasePresenter {
    
    private let interactor: LoginInteractor
    private let router = LoginRouter()
    
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
                    DispatchQueue.main.async {
                        self.userData = user
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
