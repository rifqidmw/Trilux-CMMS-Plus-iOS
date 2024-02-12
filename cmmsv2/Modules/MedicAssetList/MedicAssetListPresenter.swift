//
//  MedicAssetListPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/02/24.
//

import Foundation

class MedicAssetListPresenter: BasePresenter {
    
    private let interactor: MedicAssetListInteractor
    private let router = MedicAssetListRouter()
    
    @Published public var equipmentData: EquipmentEntity?
    @Published public var equipment: [Equipment] = []
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    var serial: String = ""
    var locationId: String = ""
    var search: String = ""
    var type: String = "medik"
    var sstMedic: String = "medik"
    var page: Int = 1
    var limit: Int = 10
    var isCanLoad = true
    var isFetchingMore = false
    
    init(interactor: MedicAssetListInteractor) {
        self.interactor = interactor
    }
    
}

extension MedicAssetListPresenter {
    
    func fetchInitData() {
        self.fetchAssetListData(serial: self.serial, locationId: self.locationId, limit: self.limit, page: self.page, search: self.search, type: self.type, sstMedic: self.sstMedic)
    }
    
    func fetchAssetListData(
        serial: String, locationId: String, limit: Int, page: Int, search: String, type: String, sstMedic: String) {
            self.isLoading = true
            interactor.getListAsset(
                serial: serial,
                locationId: locationId,
                limit: limit,
                page: page,
                search: search,
                type: type,
                sstMedic: sstMedic)
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
        fetchAssetListData(serial: serial, locationId: locationId, limit: limit, page: page, search: search, type: type, sstMedic: sstMedic)
    }
    
}
