//
//  HistoryListPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/03/24.
//

import UIKit

class HistoryListPresenter: BasePresenter {
    
    private let interactor: HistoryListInteractor
    private let router = HistoryListRouter()
    
    init(interactor: HistoryListInteractor) {
        self.interactor = interactor
    }
    
    @Published public var historyData: [WorkSheetListEntity] = []
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    var page: Int = 1
    var limit: Int = 20
    var tipe: Int = -1
    var status: Int = 100
    var keyword: String = ""
    var isCanLoad = true
    var isFetchingMore = false
    
}

extension HistoryListPresenter {
    
    func fetchInitData() {
        self.fetchHistoryList(limit: self.limit, page: self.page, tipe: self.tipe, status: self.status, keyword: self.keyword)
    }
    
    func fetchHistoryList(limit: Int, page: Int, tipe: Int, status: Int, keyword: String) {
        self.isLoading = true
        interactor.getComplaintHistoryList(limit: limit, page: page, tipe: tipe, keyword: keyword, status: status)
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
                        guard let data = history.data
                        else { return }
                        let historyList = data.compactMap { item in
                            return WorkSheetListEntity(
                                id: item.idAsset ?? "",
                                uniqueNumber: item.createAt ?? "",
                                workName: item.assetName ?? "",
                                workDesc: item.lkEngineer ?? "",
                                serial: item.serial ?? "",
                                installation: item.instalasi ?? "",
                                room: item.ruangan ?? "",
                                dateTime: item.dateText ?? "",
                                brandName: item.brandName ?? "",
                                lkStatus: item.lkStatus,
                                category: WorkSheetCategory.none,
                                status: WorkSheetStatus(rawValue: item.txtStatus ?? "") ?? WorkSheetStatus.none)
                        }
                        self.historyData.append(contentsOf: historyList)
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchNextPage() {
        guard !isFetchingMore && isCanLoad else { return }
        page += 1
        fetchHistoryList(limit: self.limit, page: self.page, tipe: self.tipe, status: self.status, keyword: self.keyword)
    }
    
}

extension HistoryListPresenter {
    
    func navigateToHistoryDetail(navigation: UINavigationController, data: WorkSheetListEntity) {
        router.navigateToHistoryDetail(navigation: navigation, data: data)
    }
    
}
