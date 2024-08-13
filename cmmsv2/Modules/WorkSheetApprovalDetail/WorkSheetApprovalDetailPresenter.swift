//
//  WorkSheetApprovalDetailPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/08/24.
//

import Foundation

class WorkSheetApprovalDetailPresenter: BasePresenter {
    
    private let interactor: WorkSheetApprovalDetailInteractor
    private let router: WorkSheetApprovalDetailRouter
    let id: String?
    
    @Published public var approvalData: HistoryDetailEntity?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    init(interactor: WorkSheetApprovalDetailInteractor, router: WorkSheetApprovalDetailRouter, id: String) {
        self.interactor = interactor
        self.router = router
        self.id = id
    }
    
}

extension WorkSheetApprovalDetailPresenter {
    
    func fetchInitData() {
        guard let id else { return }
        self.fetchApproval(id: id)
    }
    
    func fetchApproval(id: String) {
        self.isLoading = true
        interactor.getApprovalDetail(id: id)
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
                receiveValue: { approval in
                    DispatchQueue.main.async {
                        self.approvalData = approval
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}
