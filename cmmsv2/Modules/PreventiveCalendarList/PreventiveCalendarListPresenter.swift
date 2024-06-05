//
//  PreventiveCalendarListPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 18/03/24.
//

import Foundation
import UIKit

class PreventiveCalendarListPresenter: BasePresenter {
    
    private let interactor: PreventiveCalendarListInteractor
    private let router = PreventiveCalendarListRouter()
    
    init(interactor: PreventiveCalendarListInteractor) {
        self.interactor = interactor
    }
    
    @Published public var preventiveList: [PreventiveScheduleData] = []
    @Published public var preventiveScheduleList: [WorkSheetListEntity] = []
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    var limit: Int = 20
    var page: Int = 1
    var isCanLoad = true
    var isFetchingMore = false
    
}

extension PreventiveCalendarListPresenter {
    
    func fetchInitData(idEngineer: String? = nil, month: String? = nil) {
        self.fetchCalendarPreventiveList(idEngineer: idEngineer, month: month)
    }
    
    func fetchCalendarPreventiveList(idEngineer: String? = nil, month: String? = nil) {
        self.isLoading = true
        interactor.getPreventiveCalendarList(idEngineer: idEngineer, month: month)
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
                        guard let preventiveData = preventive.data else { return }
                        self.preventiveList = preventiveData
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchPreventiveSchedule(idEngineer: String? = nil, date: String? = nil, page: Int? = nil, limit: Int? = nil) {
        self.isLoading = true
        interactor.getSchedulePreventiveList(idEngineer: idEngineer, date: date, page: page, limit: limit)
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
                        
                        let preventiveDataList = data.compactMap { item in
                            return WorkSheetListEntity(
                                id: item.idAsset ?? "",
                                uniqueNumber: item.lkNumber ?? "",
                                workName: item.assetName ?? "",
                                workDesc: item.lkLabel ?? "",
                                serial: item.serial ?? "",
                                installation: item.instalasi ?? "",
                                room: item.ruangan ?? "",
                                dateTime: item.dateText ?? "",
                                brandName: item.brandName ?? "",
                                lkStatus: item.lkStatus,
                                category: WorkSheetCategory.none,
                                status: WorkSheetStatus(rawValue: item.txtStatus ?? "") ?? WorkSheetStatus.none)
                        }
                        self.preventiveScheduleList = preventiveDataList
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchNextPage(idEngineer: String? = nil, date: String? = nil) {
        guard !isFetchingMore && isCanLoad else { return }
        page += 1
        fetchPreventiveSchedule(idEngineer: idEngineer, date: date, page: self.page, limit: self.limit)
    }
    
}

extension PreventiveCalendarListPresenter {
    
    func navigateToLoadPreventive(from navigation: UINavigationController, data: WorkSheetListEntity) {
        router.navigateToLoadPreventive(navigation, data: data)
    }
    
    func showPreventiveBottomSheet(from navigation: UINavigationController, delegate: PreventiveSchedulerBottomSheetDelegate) {
        router.showPreventiveBottomSheet(navigation, delegate: delegate)
    }
    
}
