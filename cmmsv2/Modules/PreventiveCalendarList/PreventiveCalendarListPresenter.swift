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
    var technicianList: SelectTechnicianEntity?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    var idEngineer: String? = ""
    var limit: Int = 20
    var page: Int = 1
    var isCanLoad = true
    var isFetchingMore = false
    
}

extension PreventiveCalendarListPresenter {
    
    func fetchInitData(idEngineer: String? = nil, month: String? = nil) {
        if let idEngineer = idEngineer {
            self.idEngineer = idEngineer
        }
        
        self.page = 1
        self.preventiveList.removeAll()
        self.preventiveScheduleList.removeAll()
        self.fetchCalendarPreventiveList(idEngineer: idEngineer, month: month)
        self.fetchTechnicianList(job: "2")
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
    
    func fetchPreventiveSchedule(date: String? = nil, page: Int? = nil, limit: Int? = nil) {
        self.isLoading = true
        interactor.getSchedulePreventiveList(date: date, page: page, limit: limit)
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
                                idLK: item.idLK ?? "",
                                idAsset: item.idAsset ?? "",
                                serialNumber: item.serial ?? "",
                                title: item.assetName ?? "",
                                description: item.lkInfo ?? "",
                                room: item.ruangan ?? "",
                                installation: item.instalasi ?? "",
                                dateTime: item.dateText ?? "",
                                brandName: item.brandName ?? "",
                                lkNumber: item.lkNumber ?? "",
                                lkStatus: item.lkStatus ?? "",
                                category: WorkSheetCategory.none,
                                status: WorkSheetStatus(rawValue: item.txtStatus ?? "") ?? WorkSheetStatus.none
                            )
                        }
                        self.preventiveScheduleList = preventiveDataList
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchNextPage(date: String? = nil) {
        guard !isFetchingMore && isCanLoad else { return }
        page += 1
        fetchPreventiveSchedule(date: date, page: self.page, limit: self.limit)
    }
    
    func fetchTechnicianList(job: String) {
        self.isLoading = true
        interactor.getTechnicianList(job: job)
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
                receiveValue: { technicians in
                    DispatchQueue.main.async {
                        self.technicianList = technicians
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}

extension PreventiveCalendarListPresenter {
    
    func navigateToLoadPreventive(from navigation: UINavigationController, data: WorkSheetListEntity) {
        router.navigateToLoadPreventive(navigation, data: data)
    }
    
    func showPreventiveBottomSheet(from navigation: UINavigationController, delegate: PreventiveSchedulerBottomSheetDelegate) {
        router.showPreventiveBottomSheet(navigation, delegate: delegate)
    }
    
    func showSelectTechnicianBottomSheet(from navigation: UINavigationController, _ delegate: SelectTechnicianBottomSheetDelegate) {
        let bottomSheet = SelectTechnicianBottomSheet(nibName: String(describing: SelectTechnicianBottomSheet.self), bundle: nil)
        let userList = self.technicianList?.data?.users?.compactMap { item in
            return TechnicianEntity(id: item.valId, name: item.txtName, isSelected: false)
        }
        bottomSheet.data = userList ?? []
        bottomSheet.type = .selectOne
        bottomSheet.delegate = delegate
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
}
