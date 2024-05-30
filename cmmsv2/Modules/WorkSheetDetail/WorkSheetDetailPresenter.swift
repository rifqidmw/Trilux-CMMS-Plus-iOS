//
//  WorkSheetOnsitePreventiveDetailPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/02/24.
//

import Foundation

class WorkSheetDetailPresenter: BasePresenter {
    
    private let interactor: WorkSheetDetailInteractor
    private let router: WorkSheetDetailRouter
    let type: WorkSheetDetailType?
    let data: WorkSheetRequestEntity?
    
    @Published public var monitoringFunctionData: MonitoringFunctionEntity?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    init(interactor: WorkSheetDetailInteractor, router: WorkSheetDetailRouter, type: WorkSheetDetailType, data: WorkSheetRequestEntity) {
        self.interactor = interactor
        self.router = router
        self.type = type
        self.data = data
    }
    
}

extension WorkSheetDetailPresenter {
    
    func fetchInitialData() {
        guard let data else { return }
        self.fetchMonitoringFunctionDetail(id: data.id, action: data.action)
    }
    
    func fetchMonitoringFunctionDetail(id: String?, action: String?) {
        self.isLoading = true
        interactor.getDetailMonitoringFunction(id: id, action: action)
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
                receiveValue: { worksheet in
                    DispatchQueue.main.async {
                        self.monitoringFunctionData = worksheet
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}
