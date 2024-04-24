//
//  AssetListPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/02/24.
//

import Foundation

class AssetListPresenter: BasePresenter {
    
    private let interactor: AssetListInteractor
    private let router: AssetListRouter
    let assetType: AssetType
    
    @Published public var equipmentData: EquipmentEntity?
    @Published public var equipment: [Equipment] = []
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    var serial: String = ""
    var locationId: String = ""
    var search: String = ""
    var page: Int = 1
    var limit: Int = 20
    var isCanLoad = true
    var isFetchingMore = false
    
    init(interactor: AssetListInteractor, router: AssetListRouter, assetType: AssetType) {
        self.interactor = interactor
        self.router = router
        self.assetType = assetType
    }
    
}

extension AssetListPresenter {
    
    func fetchInitData() {
        self.fetchAssetListData(serial: self.serial, locationId: self.locationId, limit: self.limit, page: self.page, search: self.search)
    }
    
    func fetchAssetListData(
        serial: String, locationId: String, limit: Int, page: Int, search: String) {
            self.isLoading = true
            interactor.getListAsset(
                serial: serial,
                locationId: locationId,
                limit: limit,
                page: page,
                search: search,
                type: self.assetType.getStringValue(),
                sstMedic: self.assetType.getStringValue())
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
                              let equipment = data.equipments
                        else { return }
                        self.equipmentData = asset
                        self.equipment.append(contentsOf: equipment)
                        
                    }
                }
            )
            .store(in: &anyCancellable)
        }
    
    func fetchNextPage() {
        guard !isFetchingMore && isCanLoad else { return }
        page += 1
        fetchAssetListData(serial: self.serial, locationId: self.locationId, limit: self.limit, page: self.page, search: self.search)
    }
    
}
