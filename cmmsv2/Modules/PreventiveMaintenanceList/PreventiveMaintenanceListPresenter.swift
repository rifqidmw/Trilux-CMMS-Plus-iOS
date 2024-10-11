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
    var installationList: [InstallationData] = []
    var filterStatusData: [StatusFilterEntity] = [
        StatusFilterEntity(id: "-1", status: .all),
        StatusFilterEntity(id: "1", status: .open),
        StatusFilterEntity(id: "2", status: .progress),
        StatusFilterEntity(id: "3", status: .rated),
        StatusFilterEntity(id: "10", status: .approved),
        StatusFilterEntity(id: "100", status: .finish)
    ]
    var sortingHistoryData: [SortingEntity] = [
        SortingEntity(id: "0", sortType: .latest, hasObstacle: -1),
        SortingEntity(id: "1", sortType: .longest, hasObstacle: -1)
    ]
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    var limit: Int = 20
    var page: Int = 1
    var sort: String = "terbaru"
    var keyword: String = ""
    var idInstallation: String = ""
    var status: String = "-1"
    var isCanLoad = true
    var isFetchingMore = false
    
}

extension PreventiveMaintenanceListPresenter {
    
    func fetchInitData(
        keyword: String? = nil,
        sort: String? = nil,
        status: String? = nil,
        idInstallation: String? = nil) {
            if let keyword = keyword {
                self.keyword = keyword
            }
            
            if let status = status {
                self.status = status
            }
            
            if let sort = sort {
                self.sort = sort
            }
            
            if let idInstallation = idInstallation {
                self.idInstallation = idInstallation
            }
            
            self.page = 1
            self.preventiveData.removeAll()
            self.fetchWorkSheetPreventiveList(
                limit: self.limit,
                sort: self.sort,
                keyword: self.keyword,
                idInstallation: self.idInstallation,
                status: self.status,
                page: self.page)
        }
    
    func fetchWorkSheetPreventiveList(
        limit: Int,
        sort: String,
        keyword: String,
        idInstallation: String,
        status: String,
        page: Int) {
            self.isLoading = true
            interactor.getWorkSheetPreventive(
                limit: limit,
                sort: sort,
                keyword: keyword,
                idInstallation: idInstallation,
                status: status,
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
                receiveValue: { preventive in
                    DispatchQueue.main.async {
                        guard let data = preventive.data else { return }
                        let preventiveData = data.compactMap { item in
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
                        
                        let filteredData = preventiveData.filter { newItem in
                            !self.preventiveData.contains(where: { $0.idLK == newItem.idLK })
                        }
                        
                        self.preventiveData.append(contentsOf: filteredData)
                    }
                }
            )
            .store(in: &anyCancellable)
        }
    
    func fetchInstallationList() {
        self.isLoading = true
        interactor.getInstallationList()
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
                receiveValue: { installation in
                    DispatchQueue.main.async {
                        guard let data = installation.data else { return }
                        self.installationList = data
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchNextPage() {
        guard !isFetchingMore && isCanLoad else { return }
        page += 1
        self.fetchWorkSheetPreventiveList(
            limit: self.limit,
            sort: self.sort,
            keyword: self.keyword,
            idInstallation: self.idInstallation,
            status: self.status,
            page: self.page)
    }
    
}

extension PreventiveMaintenanceListPresenter {
    
    func showFilterStatusBottomSheet(from navigation: UINavigationController, delegate: FilterStatusBottomSheetDelegate) {
        let bottomSheet = FilterStatusBottomSheet(nibName: String(describing: FilterStatusBottomSheet.self), bundle: nil)
        bottomSheet.data = self.filterStatusData
        bottomSheet.delegate = delegate
        bottomSheet.type = .single
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showHistorySortBottomSheet(from navigation: UINavigationController, _ delegate: SortingBottomSheetDelegate) {
        let bottomSheet = SortingBottomSheet(nibName: String(describing: SortingBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        bottomSheet.data = self.sortingHistoryData
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showInstallationBottomSheet(from navigation: UINavigationController, _ delegate: InstallationBottomSheetDelegate) {
        let bottomSheet = InstallationBottomSheet(nibName: String(describing: InstallationBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        bottomSheet.data = self.installationList
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
}
