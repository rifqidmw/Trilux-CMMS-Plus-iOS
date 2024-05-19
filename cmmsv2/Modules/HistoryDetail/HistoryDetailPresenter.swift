//
//  HistoryDetailPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 18/05/24.
//

import Foundation

class HistoryDetailPresenter: BasePresenter {
    
    private let interactor: HistoryDetailInteractor
    private let router: HistoryDetailRouter
    let data: WorkSheetListEntity?
    
    @Published public var historyDetail: WorkOrderHistory?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    init(interactor: HistoryDetailInteractor, router: HistoryDetailRouter, data: WorkSheetListEntity) {
        self.interactor = interactor
        self.router = router
        self.data = data
    }
    
}

extension HistoryDetailPresenter {
    
    func fetchInitData() {
        guard let data, let id = data.id else { return }
        self.fetchHistoryDetail(id: id)
    }
    
    func fetchHistoryDetail(id: String) {
        self.isLoading = true
        interactor.getHistoryDetail(id: id)
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
                receiveValue: { history in
                    DispatchQueue.main.async {
                        guard let data = history.data, let historyData = data.woDetail else { return }
                        self.historyDetail = historyData
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}
