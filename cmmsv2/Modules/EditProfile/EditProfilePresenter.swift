//
//  EditProfilePresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/01/24.
//

import UIKit

class EditProfilePresenter: BasePresenter {
    
    private let interactor: EditProfileInteractor
    private let router = EditProfileRouter()
    
    @Published public var userProfile: User?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    init(interactor: EditProfileInteractor) {
        self.interactor = interactor
    }
    
}

extension EditProfilePresenter {
    
    func updateUserProfile(name: String, position: String, workUnit: String, imageId: Int, phoneNumber: String, navigation: UINavigationController) {
        self.isLoading = true
        interactor.updateUserProfile(name: name, position: position, workUnit: workUnit, imageId: imageId, phoneNumber: phoneNumber)
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
                        switch user.message {
                        case .success:
                            navigation.popViewController(animated: true)
                        default: break
                        }
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
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
