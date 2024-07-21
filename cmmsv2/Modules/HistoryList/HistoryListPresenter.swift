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
    var hasObstacle: Int = -1
    var woStatus: String = "approved"
    var isCanLoad = true
    var isFetchingMore = false
    
}

extension HistoryListPresenter {
    
    func fetchInitData(hasObstacle: Int? = nil) {
        if let hasObstacle = hasObstacle {
            self.hasObstacle = hasObstacle
        }
        self.page = 1
        self.historyData.removeAll()
        self.fetchHistoryList(
            woStatus: self.woStatus,
            limit: self.limit,
            hasObstacle: self.hasObstacle, page: self.page
        )
    }
    
    func fetchHistoryList(
        woStatus: String? = nil,
        limit: Int? = nil,
        hasObstacle: Int? = nil,
        page: Int? = nil) {
            self.isLoading = true
            interactor.getComplaintHistoryList(
                woStatus: woStatus,
                limit: limit,
                hasObstacle: hasObstacle,
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
                receiveValue: { history in
                    DispatchQueue.main.async {
                        guard let data = history.data,
                              let worksheet = data.wo
                        else { return }
                        let workSheetList = worksheet.compactMap { item in
                            return WorkSheetListEntity(
                                idLK: String(item.id ?? 0),
                                idAsset: String(item.complain?.equipment?.id ?? 0),
                                serialNumber: item.txtSubTitle ?? "",
                                title: item.txtTitle ?? "",
                                room: item.txtRuangan ?? "",
                                installation: item.complain?.equipment?.txtLokasiInstalasi ?? "",
                                dateTime: item.valDate ?? "",
                                brandName: item.txtType ?? "",
                                lkNumber: item.infoLk?.lkNumber,
                                category: WorkSheetCategory(rawValue: item.complain?.equipment?.txtKalibrasi ?? "") ?? WorkSheetCategory.none,
                                status: WorkSheetStatus(rawValue: item.txtStatus ?? "") ?? WorkSheetStatus.none
                            )
                        }
                        self.historyData.append(contentsOf: workSheetList)
                    }
                }
            )
            .store(in: &anyCancellable)
        }
    
    func fetchNextPage() {
        guard !isFetchingMore && isCanLoad else { return }
        page += 1
        self.fetchHistoryList(
            woStatus: self.woStatus,
            limit: self.limit,
            hasObstacle: self.hasObstacle,
            page: self.page)
    }
    
}

extension HistoryListPresenter {
    
    func navigateToHistoryDetail(navigation: UINavigationController, data: WorkSheetListEntity) {
        router.navigateToHistoryDetail(navigation: navigation, data: data)
    }
    
    func showHistorySortBottomSheet(from navigation: UINavigationController, _ delegate: SortingHistoryBottomSheetDelegate) {
        let bottomSheet = SortingHistoryBottomSheet(nibName: String(describing: SortingHistoryBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
}
