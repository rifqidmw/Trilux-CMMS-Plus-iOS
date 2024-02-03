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
    
    @Published public var userData: EditProfileEntity?
    
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
                        guard let userData = user.data
                        else { return }
                        
                        switch user.message {
                        case .success:
                            self.userData = user
                            self.backToPreviousPage(navigation: navigation)
                        default: break
                        }
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}

extension EditProfilePresenter {
    
    func backToPreviousPage(navigation: UINavigationController) {
        router.backToPreviousPage(navigation: navigation)
    }
    
}
