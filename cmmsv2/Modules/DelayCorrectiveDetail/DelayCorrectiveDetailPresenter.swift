//
//  DelayCorrectiveDetailPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 31/05/24.
//

import Foundation

class DelayCorrectiveDetailPresenter: BasePresenter {
    
    private let interactor: DelayCorrectiveDetailInteractor
    private let router: DelayCorrectiveDetailRouter
    let id: String?
    
    @Published public var complaintData: DelayCorrectiveData?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    init(interactor: DelayCorrectiveDetailInteractor, router: DelayCorrectiveDetailRouter, id: String) {
        self.interactor = interactor
        self.router = router
        self.id = id
    }
    
}

extension DelayCorrectiveDetailPresenter {
    
    func fetchInitialData() {
        guard let id else { return }
        fetchComplaintCorrectiveDetail(id: id)
    }
    
    func fetchComplaintCorrectiveDetail(id: String?) {
        self.isLoading = true
        interactor.getDetailCorrective(id: id ?? "")
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
                receiveValue: { complains in
                    DispatchQueue.main.async {
                        guard let data = complains.data, let detail = data.complain else { return }
                        self.complaintData = detail
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}
