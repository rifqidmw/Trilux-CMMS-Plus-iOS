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
    @Published public var returningLoanData: [EquipmentManagementRequestData] = []
    @Published public var returningBorrowedData: [EquipmentManagementRequestData] = []
    @Published public var approvedRequestedData: ReturningEntity?
    @Published public var mutationSubmissionData: MutationRequestEntity?
    @Published public var mutationRequestData: MutationRequestEntity?
    @Published public var amprahList: [AmprahListData] = []
    @Published public var mutationResponse: AmprahMutationResponse?
    var amprahRoomList: [AmprahRoomData] = []
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
        case .loan:
            fetchEquipmentSubmission()
        case .returning:
            fetchReturningLoanList(limit: limit, page: page)
        case .mutation:
            fetchMutationSubmission()
        case .amprah:
            fetchAmprahList(limit: limit, page: page)
            fetchRoomList()
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
    
    func fetchRoomList() {
        isLoading = true
        interactor.getAmprahRoomList()
            .sink(
                receiveCompletion: handleCompletion(_:),
                receiveValue: { amprahRoom in
                    DispatchQueue.main.async {
                        self.amprahRoomList = amprahRoom.data ?? []
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
                        guard let newData = returningLoanData.data else { return }
                        
                        let filteredData = newData.filter { newItem in
                            !self.returningLoanData.contains(where: { $0.id == newItem.id })
                        }
                        
                        self.returningLoanData.append(contentsOf: filteredData)
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
                        guard let newData = returningBorrowedData.data else { return }
                        
                        let filteredData = newData.filter { newItem in
                            !self.returningBorrowedData.contains(where: { $0.id == newItem.id })
                        }
                        
                        self.returningBorrowedData.append(contentsOf: filteredData)
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchAmprahList(limit: Int, page: Int) {
        isLoading = true
        interactor.getAmprahList(limit: limit, page: page)
            .sink(
                receiveCompletion: handleCompletion(_:),
                receiveValue: { amprahList in
                    DispatchQueue.main.async {
                        guard let newData = amprahList.data else { return }
                        
                        let filteredData = newData.filter { newItem in
                            !self.amprahList.contains(where: { $0.id == newItem.id })
                        }
                        
                        self.amprahList.append(contentsOf: filteredData)
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func mutationAmprah(_ data: AmprahMutationRequest?) {
        isLoading = true
        interactor.amprahMutation(data: data)
            .sink(
                receiveCompletion: handleCompletion(_:),
                receiveValue: { response in
                    DispatchQueue.main.async {
                        self.mutationResponse = response
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
    
    func fetchMutationSubmission() {
        isLoading = true
        interactor.getMutationSubmissionList()
            .sink(
                receiveCompletion: handleCompletion(_:),
                receiveValue: { submissionData in
                    DispatchQueue.main.async {
                        self.mutationSubmissionData = submissionData
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchMutationRequest() {
        isLoading = true
        interactor.getMutationRequestList()
            .sink(
                receiveCompletion: handleCompletion(_:),
                receiveValue: { requestData in
                    DispatchQueue.main.async {
                        self.mutationRequestData = requestData
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
    
    func navigateToEquipmentManagementDetail(from navigation: UINavigationController, _ id: String?, type: EquipmentManagementType) {
        router.navigateToEquipmentManagementDetail(from: navigation, id ?? "", type: type)
    }
    
    func showApproveConfirmationPopUp(from navigation: UINavigationController, id: String?, _ delegate: ConfirmationReturningBottomDelegate) {
        let bottomSheet = ConfirmationReturningBottomSheet(nibName: String(describing: ConfirmationReturningBottomSheet.self), bundle: nil)
        bottomSheet.id = id ?? ""
        bottomSheet.delegate = delegate
        bottomSheet.type = .approve
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showRoomListBottomSheet(navigation: UINavigationController, _ delegate: RoomListBottomSheetDelegate, id: String?) {
        let bottomSheet = RoomListBottomSheet(nibName: String(describing: RoomListBottomSheet.self), bundle: nil)
        bottomSheet.data = amprahRoomList
        bottomSheet.id = id ?? ""
        bottomSheet.delegate = delegate
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func navigateToMutationSubmission(from navigation: UINavigationController) {
        router.navigateToMutationSubmission(from: navigation)
    }
    
}
