//
//  EquipmentManagementPresenter.swift
//  cmmsv2
//
//  Created by macbook  on 10/09/24.
//

import Foundation
import Combine
import UIKit

class EquipmentManagementListPresenter: BasePresenter {
    
    private let interactor: EquipmentManagementListInteractor
    private let router: EquipmentManagementListRouter
    let type: EquipmentManagementType
    
    @Published public var equipmentSubmissionData: EquipmentManagementSubmissionEntity?
    @Published public var equipmentRequestData: EquipmentManagementRequestEntity?
    @Published public var returningLoanData: EquipmentManagementRequestEntity?
    @Published public var returningBorrowedData: EquipmentManagementRequestEntity?
    @Published public var approvedRequestedData: ReturningEntity?
    let floatingActionData: [FloatingActionEntity] = [
        FloatingActionEntity(image: "plus", title: "Pilih dari list"),
        FloatingActionEntity(image: "barcode.viewfinder", title: "Scan")
    ]
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    var page: Int = 1
    var limit: Int = 20
    var isCanLoad = true
    var isFetchingMore = false
    
    init(interactor: EquipmentManagementListInteractor, router: EquipmentManagementListRouter, type: EquipmentManagementType) {
        self.interactor = interactor
        self.router = router
        self.type = type
    }
    
}

extension EquipmentManagementListPresenter {
    
    func fetchInitData() {
        switch type {
        case .returning:
            fetchReturningLoanList(limit: limit, page: page)
        case .loan:
            fetchEquipmentSubmission()
        }
    }
    
    func fetchEquipmentSubmission() {
        isLoading = true
        interactor.getLoanSubmissionList()
            .sink(
                receiveCompletion: handleCompletion(_:),
                receiveValue: { submissionData in
                    DispatchQueue.main.async {
                        self.equipmentSubmissionData = submissionData
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchEquipmentRequest() {
        isLoading = true
        interactor.getLoanRequestList()
            .sink(
                receiveCompletion: handleCompletion(_:),
                receiveValue: { requestData in
                    DispatchQueue.main.async {
                        self.equipmentRequestData = requestData
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchReturningLoanList(limit: Int, page: Int) {
        isLoading = true
        interactor.getReturningLoanList(limit: limit, page: page)
            .sink(
                receiveCompletion: handleCompletion(_:),
                receiveValue: { returningLoanData in
                    DispatchQueue.main.async {
                        self.returningLoanData = returningLoanData
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchReturningBorrowedList(limit: Int, page: Int) {
        isLoading = true
        interactor.getReturningBorrowedList(limit: limit, page: page)
            .sink(
                receiveCompletion: handleCompletion(_:),
                receiveValue: { returningBorrowedData in
                    DispatchQueue.main.async {
                        self.returningBorrowedData = returningBorrowedData
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchNextPage() {
        guard !isFetchingMore && isCanLoad else { return }
        page += 1
        fetchInitData()
    }
    
    private func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            isLoading = false
        case .failure(let error):
            errorMessage = error.localizedDescription
            isLoading = false
            isError = true
            AppLogger.log(error, logType: .kNetworkResponseError)
        }
    }
    
    func approveRequested(id: String?) {
        self.isLoading = true
        interactor.approveRequested(id: id)
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
                receiveValue: { approveRequestedData in
                    DispatchQueue.main.async {
                        self.approvedRequestedData = approveRequestedData
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}

extension EquipmentManagementListPresenter {
    
    func navigateToAssetMedicList(navigation: UINavigationController) {
        router.navigateToAssetMedicList(navigation: navigation)
    }
    
    func navigateToEquipmentManagementDetail(from navigation: UINavigationController, _ id: String?) {
        router.navigateToEquipmentManagementDetail(from: navigation, id ?? "")
    }
    
    func showApproveConfirmationPopUp(from navigation: UINavigationController, id: String?, _ delegate: ConfirmationReturningBottomDelegate) {
        let bottomSheet = ConfirmationReturningBottomSheet(nibName: String(describing: ConfirmationReturningBottomSheet.self), bundle: nil)
        bottomSheet.id = id ?? ""
        bottomSheet.delegate = delegate
        bottomSheet.type = .approve
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
}
