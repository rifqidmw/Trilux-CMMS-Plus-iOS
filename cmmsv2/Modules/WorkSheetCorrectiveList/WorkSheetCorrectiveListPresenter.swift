//
//  WorkSheetCorrectivePresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/03/24.
//

import UIKit

class WorkSheetCorrectiveListPresenter: BasePresenter {
    
    private let interactor: WorkSheetCorrectiveListInteractor
    private let router = WorkSheetCorrectiveListRouter()
    
    init(interactor: WorkSheetCorrectiveListInteractor) {
        self.interactor = interactor
    }
    
    @Published public var workSheetData: [WorkSheetListEntity] = []
    @Published public var workOrderData: [WorkOrder] = []
    var filterStatusData: [StatusFilterEntity] = [
        StatusFilterEntity(id: "0", status: .open),
        StatusFilterEntity(id: "1", status: .progress),
        StatusFilterEntity(id: "2", status: .finish),
        StatusFilterEntity(id: "3", status: .rated),
        StatusFilterEntity(id: "4", status: .approved),
        StatusFilterEntity(id: "5", status: .delay),
        StatusFilterEntity(id: "6", status: .failed),
    ]
    var sortingHistoryData: [SortingEntity] = [
        SortingEntity(id: "0", sortType: .latest),
        SortingEntity(id: "1", sortType: .longest)
    ]
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    var woType: Int = 1
    var woStatus: String = "open,progress,finished,rated,approved,delay,failed"
    var limit: Int = 20
    var sort: String = "terbaru"
    var hasObstacle: Int = -1
    var keyword: String = ""
    var page: Int = 1
    var isCanLoad = true
    var isFetchingMore = false
    
}

extension WorkSheetCorrectiveListPresenter {
    
    func fetchInitData(keyword: String? = nil, woStatus: String? = nil, sort: String? = nil) {
        if let keyword = keyword {
            self.keyword = keyword
        }
        
        if let woStatus = woStatus {
            self.woStatus = woStatus
        }
        
        if let sort = sort {
            self.sort = sort
        }
        
        self.page = 1
        self.workSheetData.removeAll()
        self.fetchWorkSheetCorrectiveList(
            woType: self.woType,
            woStatus: self.woStatus,
            limit: self.limit,
            sort: self.sort,
            hasObstacle: self.hasObstacle,
            keyword: self.keyword,
            page: self.page)
    }
    
    func fetchWorkSheetCorrectiveList(
        woType: Int,
        woStatus: String,
        limit: Int,
        sort: String,
        hasObstacle: Int,
        keyword: String,
        page: Int) {
            self.isLoading = true
            interactor.getWorkSheetCorrectiveList(
                woType: woType,
                woStatus: woStatus,
                limit: limit,
                sort: sort,
                hasObstacle: hasObstacle,
                keyword: keyword,
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
                receiveValue: { worksheet in
                    DispatchQueue.main.async {
                        guard let data = worksheet.data,
                              let worksheet = data.wo
                        else { return }
                        let workSheetList = worksheet.compactMap { item in
                            return WorkSheetListEntity(
                                idLK: item.valEquipmentId ?? "",
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
                        self.workSheetData.append(contentsOf: workSheetList)
                        self.workOrderData.append(contentsOf: worksheet)
                    }
                }
            )
            .store(in: &anyCancellable)
        }
    
    func fetchNextPage() {
        guard !isFetchingMore && isCanLoad else { return }
        page += 1
        self.fetchWorkSheetCorrectiveList(
            woType: self.woType,
            woStatus: self.woStatus,
            limit: self.limit,
            sort: self.sort,
            hasObstacle: self.hasObstacle,
            keyword: self.keyword,
            page: self.page)
    }
    
}

extension WorkSheetCorrectiveListPresenter {
    
    func showBottomSheetCorrective(navigation: UINavigationController, data: WorkOrder, delegate: WorkSheetCorrectiveBottomSheetDelegate) {
        let bottomSheet = WorkSheetCorrectiveBottomSheet(nibName: String(describing: WorkSheetCorrectiveBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        bottomSheet.data = data
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showFilterStatusBottomSheet(from navigation: UINavigationController, delegate: FilterStatusBottomSheetDelegate) {
        let bottomSheet = FilterStatusBottomSheet(nibName: String(describing: FilterStatusBottomSheet.self), bundle: nil)
        bottomSheet.data = self.filterStatusData
        bottomSheet.delegate = delegate
        bottomSheet.type = .multiple
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showHistorySortBottomSheet(from navigation: UINavigationController, _ delegate: SortingBottomSheetDelegate) {
        let bottomSheet = SortingBottomSheet(nibName: String(describing: SortingBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        bottomSheet.data = self.sortingHistoryData
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
}
