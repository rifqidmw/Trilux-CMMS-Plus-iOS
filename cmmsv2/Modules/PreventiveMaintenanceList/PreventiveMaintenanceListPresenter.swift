//
//  PreventiveMaintenanceListPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 11/03/24.
//

import UIKit

class PreventiveMaintenanceListPresenter: BasePresenter {
    
    private let interactor: PreventiveMaintenanceListInteractor
    private let router = PreventiveMaintenanceListRouter()
    
    init(interactor: PreventiveMaintenanceListInteractor) {
        self.interactor = interactor
    }
    
    @Published public var preventiveData: [WorkSheetListEntity] = []
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    var engineer: Int = 0
    var limit: Int = 20
    var page: Int = 1
    var isCanLoad = true
    var isFetchingMore = false
    
}

extension PreventiveMaintenanceListPresenter {
    
    func fetchInitData() {
        self.fetchWorkSheetPreventiveList(limit: self.limit, page: self.page, engineer: self.engineer)
    }
    
    func fetchWorkSheetPreventiveList(limit: Int,
                                      page: Int,
                                      engineer: Int) {
        self.isLoading = true
        interactor.getWorkSheetPreventive(limit: limit, page: page, engineer: engineer)
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
                receiveValue: { preventive in
                    DispatchQueue.main.async {
                        guard let data = preventive.data
                        else { return }
                        
                        let preventiveData = data.compactMap { item in
                            return WorkSheetListEntity(
                                id: item.idLK ?? "",
                                uniqueNumber: item.serial ?? "",
                                workName: item.assetName ?? "",
                                workDesc: item.lkLabel ?? "",
                                serial: item.idAsset ?? "",
                                installation: item.instalasi ?? "",
                                room: item.ruangan ?? "",
                                dateTime: item.dateText ?? "",
                                brandName: item.brandName ?? "",
                                lkStatus: item.lkStatus,
                                category: WorkSheetCategory.none,
                                status: WorkSheetStatus(rawValue: item.txtStatus ?? "") ?? WorkSheetStatus.none)
                        }
                        self.preventiveData.append(contentsOf: preventiveData)
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchNextPage() {
        guard !isFetchingMore && isCanLoad else { return }
        page += 1
        self.fetchWorkSheetPreventiveList(limit: self.limit, page: self.page, engineer: self.engineer)
    }
    
}
