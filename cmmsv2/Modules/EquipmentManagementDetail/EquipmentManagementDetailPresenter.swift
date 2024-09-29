//
//  EquipmentManagementDetailPresenter.swift
//  cmmsv2
//
//  Created by macbook  on 16/09/24.
//

import Foundation
import UIKit

class EquipmentManagementDetailPresenter: BasePresenter {
    
    private let interactor: EquipmentManagementDetailInteractor
    private let router: EquipmentManagementDetailRouter
    let type: EquipmentManagementType
    var id: String?
    
    @Published public var submissionDetailData: SubmissionDetailEntity?
    @Published public var mutationDetailData: MutationDetailEntity?
    @Published public var deleteSubmissionData: ReturningEntity?
    @Published public var deleteMutationData: ReturningEntity?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    init(interactor: EquipmentManagementDetailInteractor, router: EquipmentManagementDetailRouter, type: EquipmentManagementType, id: String?) {
        self.interactor = interactor
        self.router = router
        self.type = type
        self.id = id
    }
    
}

extension EquipmentManagementDetailPresenter {
    
    func fetchInitialData() {
        switch type {
        case .loan, .returning:
            fetchSubmissionDetail(id: self.id ?? "")
        case .mutation:
            fetchMutationDetail(id: self.id ?? "")
        case .amprah: break
        }
    }
    
    func fetchSubmissionDetail(id: String?) {
        self.isLoading = true
        interactor.getSubmissionDetail(id: id)
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
                receiveValue: { submissionData in
                    DispatchQueue.main.async {
                        self.submissionDetailData = submissionData
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func deleteSubmission(id: String?) {
        self.isLoading = true
        interactor.deleteSubmission(id: id)
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
                receiveValue: { deleteSubmissionData in
                    DispatchQueue.main.async {
                        self.deleteSubmissionData = deleteSubmissionData
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchMutationDetail(id: String?) {
        self.isLoading = true
        interactor.getMutationDetail(id: id)
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
                receiveValue: { mutationData in
                    DispatchQueue.main.async {
                        self.mutationDetailData = mutationData
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func deleteMutation(id: String?) {
        self.isLoading = true
        interactor.deleteMutation(id: id)
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
                receiveValue: { deleteMutationData in
                    DispatchQueue.main.async {
                        self.deleteMutationData = deleteMutationData
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}

extension EquipmentManagementDetailPresenter {
    
    func showDeleteConfirmationPopUp(from navigation: UINavigationController, id: String?, _ delegate: ConfirmationReturningBottomDelegate) {
        let bottomSheet = ConfirmationReturningBottomSheet(nibName: String(describing: ConfirmationReturningBottomSheet.self), bundle: nil)
        bottomSheet.id = id ?? ""
        bottomSheet.delegate = delegate
        bottomSheet.type = .delete
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
}
