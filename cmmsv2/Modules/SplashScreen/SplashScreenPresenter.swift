//
//  SplashScreenPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 02/02/24.
//

import Foundation

class SplashScreenPresenter: BasePresenter {
    
    private let interactor: SplashScreenInteractor
    private let router = SplashScreenRouter()
    
    @Published public var userData: UserProfileEntity?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    init(interactor: SplashScreenInteractor) {
        self.interactor = interactor
    }
    
}

extension SplashScreenPresenter {
    
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
                        self.userData = user
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}

extension SplashScreenPresenter {
    
    func navigateToRegistrationHospital() {
        router.navigateToRegistrationHospital()
    }
    
    func navigateToLoginPage(data: HospitalTheme) {
        router.navigateToLoginPage(data: data)
    }
    
    func navigateToHomeScreen() {
        router.navigateToHomeScreen()
    }
    
}
