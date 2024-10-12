//
//  MutationSubmissionPresenter.swift
//  cmmsv2
//
//  Created by macbook  on 10/10/24.
//

import UIKit

class MutationSubmissionPresenter: BasePresenter {
    
    private let interactor: MutationSubmissionInteractor
    private let router = MutationSubmissionRouter()
    
    @Published public var installationList: [InstallationListData] = []
    @Published public var equipmentList: [EquipmentListData] = []
    @Published public var mutationResponse: MutationSubmissionResponse?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    init(interactor: MutationSubmissionInteractor) {
        self.interactor = interactor
    }
    
}

extension MutationSubmissionPresenter {
    
    func fetchInstallationList(completion: (() -> Void)? = nil) {
        self.isLoading = true
        interactor.getListInstallation()
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
                receiveValue: { installation in
                    DispatchQueue.main.async {
                        guard let data = installation.data else { return }
                        self.installationList = data
                        completion?()
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchEquipmentList(_ id: String?, completion: (() -> Void)? = nil) {
        self.isLoading = true
        interactor.getListEquipment(id ?? "")
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
                receiveValue: { equipment in
                    DispatchQueue.main.async {
                        guard let data = equipment.data else { return }
                        self.equipmentList = data
                        completion?()
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func createSubmission(_ data: MutationSubmissionRequest?) {
        self.isLoading = true
        interactor.createSubmissionMutation(data)
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
                receiveValue: { response in
                    DispatchQueue.main.async {
                        self.mutationResponse = response
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}

extension MutationSubmissionPresenter {
    
    func showInstallationBottomSheet(from navigation: UINavigationController, for data: [MutationSubmissionBottomSheetData], perfom delegate: MutationSubmissionBottomSheetDelegate) {
        let bottomSheet = MutationSubmissionBottomSheet(nibName: String(describing: MutationSubmissionBottomSheet.self), bundle: nil)
        bottomSheet.type = .installation
        bottomSheet.delegate = delegate
        bottomSheet.data = data
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showEquipmentBottomSheet(from navigation: UINavigationController, for data: [MutationSubmissionBottomSheetData], perfom delegate: MutationSubmissionBottomSheetDelegate) {
        let bottomSheet = MutationSubmissionBottomSheet(nibName: String(describing: MutationSubmissionBottomSheet.self), bundle: nil)
        bottomSheet.type = .equipment
        bottomSheet.delegate = delegate
        bottomSheet.data = data
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
}
