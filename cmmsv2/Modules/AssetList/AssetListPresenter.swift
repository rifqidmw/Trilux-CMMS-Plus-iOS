//
//  AssetListPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/02/24.
//

import UIKit

class AssetListPresenter: BasePresenter {
    
    private let interactor: AssetListInteractor
    private let router: AssetListRouter
    let type: AssetType
    
    @Published public var equipmentData: EquipmentEntity?
    @Published public var equipment: [Equipment] = []
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    var installationList: [InstallationData] = []
    var sortingHistoryData: [SortingEntity] = [
        SortingEntity(id: "0", sortType: .latest),
        SortingEntity(id: "1", sortType: .longest)
    ]
    var categoryFilterData: [SortingEntity] = [
        SortingEntity(id: "0", sortType: .medic),
        SortingEntity(id: "1", sortType: .equipment)
    ]
    var assetConditionFilterData: [AssetConditionEntity] = [
        AssetConditionEntity(id: "0", assetCondition: .all),
        AssetConditionEntity(id: "1", assetCondition: .good),
        AssetConditionEntity(id: "2", assetCondition: .notOperated),
        AssetConditionEntity(id: "3", assetCondition: .damaged),
        AssetConditionEntity(id: "4", assetCondition: .badlyDamaged)
    ]
    var statusCalibrationFilterData: [CalibrationConditionEntity] = [
        CalibrationConditionEntity(id: "0", calibrationCondition: .all),
        CalibrationConditionEntity(id: "1", calibrationCondition: .laik),
        CalibrationConditionEntity(id: "2", calibrationCondition: .unlaik)
    ]
    
    var search: String = ""
    var condition: String = ""
    var group: String = ""
    var sttKalibrasi: String = ""
    var category: String = ""
    var sort: String = "terbaru"
    var sttQr: String = "-1"
    var idInstallation: String = ""
    var idRoom: String = ""
    var page: Int = 1
    var limit: Int = 20
    var isCanLoad = true
    var isFetchingMore = false
    
    init(interactor: AssetListInteractor, router: AssetListRouter, type: AssetType) {
        self.interactor = interactor
        self.router = router
        self.type = type
    }
    
}

extension AssetListPresenter {
    
    func fetchInitData(
        group: String? = nil,
        sort: String? = nil,
        idInstallation: String? = nil,
        category: String? = nil,
        condition: String? = nil,
        sttCalibration: String? = nil) {
            if let group = group {
                self.group = group
            }
            
            if let sort = sort {
                self.sort = sort
            }
            
            if let idInstallation = idInstallation {
                self.idInstallation = idInstallation
            }
            
            if let category = category {
                self.category = category
            }
            
            if let condition = condition {
                self.condition = condition
            }
            
            if let sttCalibration = sttCalibration {
                self.sttKalibrasi = sttCalibration
            }
            
            self.page = 1
            self.equipment.removeAll()
            self.fetchAssetListData(
                search: self.search,
                condition: self.condition,
                limit: self.limit,
                type: self.group,
                sttKalibrasi: self.sttKalibrasi,
                category: self.category,
                sort: self.sort,
                sttQr: self.sttQr,
                idInstallation: self.idInstallation,
                idRoom: self.idRoom,
                page: self.page)
        }
    
    func fetchAssetListData(
        search: String,
        condition: String,
        limit: Int,
        type: String,
        sttKalibrasi: String,
        category: String,
        sort: String,
        sttQr: String,
        idInstallation: String,
        idRoom: String,
        page: Int) {
            self.isLoading = true
            interactor.getListAsset(
                search: search,
                condition: condition,
                limit: limit,
                type: type,
                sttKalibrasi: sttKalibrasi,
                category: category,
                sort: sort,
                sttQr: sttQr,
                idInstallation: idInstallation,
                idRoom: idRoom,
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
                receiveValue: { asset in
                    DispatchQueue.main.async {
                        guard let data = asset.data,
                              let newData = data.equipments
                        else { return }
                        self.equipmentData = asset
                        let filteredData = newData.filter { newItem in
                            !self.equipment.contains(where: { $0.id == newItem.id })
                        }
                        self.equipment.append(contentsOf: filteredData)
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
        self.page += 1
        self.fetchAssetListData(
            search: self.search,
            condition: self.condition,
            limit: self.limit,
            type: self.group,
            sttKalibrasi: self.sttKalibrasi,
            category: self.category,
            sort: self.sort,
            sttQr: self.sttQr,
            idInstallation: self.idInstallation,
            idRoom: self.idRoom,
            page: self.page)
    }
    
}

extension AssetListPresenter {
    
    func showSortBottomSheet(from navigation: UINavigationController, _ delegate: SortingBottomSheetDelegate) {
        let bottomSheet = SortingBottomSheet(nibName: String(describing: SortingBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        bottomSheet.data = self.sortingHistoryData
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showCategoryFilterBottomSheet(from navigation: UINavigationController, _ delegate: SortingBottomSheetDelegate, optionalDelegate: SortingBottomSheetDelegateOptional) {
        let bottomSheet = SortingBottomSheet(nibName: String(describing: SortingBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        bottomSheet.optionalDelegate = optionalDelegate
        bottomSheet.data = self.categoryFilterData
        bottomSheet.type = .category
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showConditionFilterBottomSheet(from navigation: UINavigationController, _ delegate: ConditionFilterBottomSheetDelegate) {
        let bottomSheet = ConditionFilterBottomSheet(nibName: String(describing: ConditionFilterBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        bottomSheet.assetFilterData = self.assetConditionFilterData
        bottomSheet.calibrationFilterData = self.statusCalibrationFilterData
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showInstallationBottomSheet(from navigation: UINavigationController, _ delegate: InstallationBottomSheetDelegate) {
        let bottomSheet = InstallationBottomSheet(nibName: String(describing: InstallationBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        bottomSheet.data = self.installationList
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
}
