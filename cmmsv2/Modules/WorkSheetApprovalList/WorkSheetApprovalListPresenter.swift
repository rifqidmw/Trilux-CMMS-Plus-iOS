//
//  WorkSheetApprovalListPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 30/07/24.
//

import Foundation

class WorkSheetApprovalListPresenter: BasePresenter {
    
    private let interactor: WorkSheetApprovalListInteractor
    private let router = WorkSheetApprovalListRouter()
    
    init(interactor: WorkSheetApprovalListInteractor) {
        self.interactor = interactor
    }
    
    @Published public var approvalList: [WorkSheetApproval] = []
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    var woType: String = "1"
    var woStatus: String = "open,progress,finished,rated"
    var limit: Int = 20
    var page: Int = 1
    var isCanLoad = true
    var isFetchingMore = false
    
}

extension WorkSheetApprovalListPresenter {
    
    func fetchInitData() {
        self.fetchWorkSheetApprovalList(
            woType: self.woType,
            woStatus: self.woStatus,
            limit: self.limit,
            page: self.page)
    }
    
    func fetchWorkSheetApprovalList(
        woType: String,
        woStatus: String,
        limit: Int,
        page: Int) {
            self.isLoading = true
            interactor.getWorkSheetApproval(
                woType: woType,
                woStatus: woStatus,
                limit: limit,
                page: page)
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
                        guard let data = approval.data,
                              let approvalList = data.wo
                        else { return }
                        self.approvalList.append(contentsOf: approvalList)
                    }
                }
            )
            .store(in: &anyCancellable)
        }
    
    func fetchNextPage() {
        guard !isFetchingMore && isCanLoad else { return }
        self.page += 1
        self.fetchWorkSheetApprovalList(
            woType: self.woType,
            woStatus: self.woStatus,
            limit: self.limit,
            page: self.page)
    }
    
}
