//
//  RegistrationHospitalPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 06/01/24.
//

import Combine
import UIKit

class RegistrationHospitalPresenter: BasePresenter {
    
    private let interactor: RegistrationHospitalInteractor
    private let router = RegistrationHospitalRouter()
    
    @Published public var hospitalData: Hospital?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    init(interactor: RegistrationHospitalInteractor) {
        self.interactor = interactor
    }
    
}

extension RegistrationHospitalPresenter {
    
    func registerHospital(code: String, navigation: UINavigationController) {
        self.isLoading = true
        interactor.registerHospital(code: code)
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
                receiveValue: { hospital in
                    self.hospitalData = hospital
                    
                    switch hospital.message {
                    case .success:
                        UserDefaults.standard.setValue(true, forKey: "isRegistered")
                        self.navigateToLoginPage(navigation: navigation, data: hospital)
                    default: break
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}

extension RegistrationHospitalPresenter {
    
    func navigateToLoginPage(navigation: UINavigationController, data: Hospital) {
        router.goToLoginPage(navigation: navigation, data: data)
    }
    
}
