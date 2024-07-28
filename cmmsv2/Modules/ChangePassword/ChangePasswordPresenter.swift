//
//  ChangePasswordPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/01/24.
//

import UIKit

class ChangePasswordPresenter: BasePresenter {
    
    private let interactor: ChangePasswordInteractor
    private let router = ChangePasswordRouter()
    
    @Published public var userData: UserProfileEntity?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    init(interactor: ChangePasswordInteractor) {
        self.interactor = interactor
    }
    
}

extension ChangePasswordPresenter {
    
    func changeUserPassword(oldPassword: String, confirmPassword: String, password: String, navigation: UINavigationController) {
        self.isLoading = true
        interactor.changeUserPassword(oldPassword: oldPassword, confirmPassword: confirmPassword, password: password)
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
