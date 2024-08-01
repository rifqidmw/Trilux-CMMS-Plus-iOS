//
//  AssetDetailPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 01/05/24.
//

import Foundation
import UIKit

class AssetDetailPresenter: BasePresenter {
    
    private let interactor: AssetDetailInteractor
    private let router: AssetDetailRouter
    let type: AssetType
    let data: Equipment?
    var trackData: [TrackComplaintData] = []
    
    @Published public var assetInfoData: EquipmentDetail?
    @Published public var assetFilesData: [File] = []
    @Published public var assetCostData: EquipmentMainCoast?
    @Published public var assetTechnicalData: EquipmentTechnical?
    @Published public var assetAcceptanceData: DeliveryAcceptanceData?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    init(interactor: AssetDetailInteractor, router: AssetDetailRouter, type: AssetType, data: Equipment) {
        self.interactor = interactor
        self.router = router
        self.type = type
        self.data = data
    }
    
}

extension AssetDetailPresenter {
    
    func fetchInitialData() {
        guard let data,
              let id = data.id
        else { return }
        fetchAssetDetail(id: id)
        fetchAssetTechnical(id: id)
        fetchAssetCost(id: id)
        fetchAcceptanceAsset(id: id)
        fetchAssetFiles(id: id)
        fetchComplaintTracking(id: id)
    }
    
    func fetchAssetDetail(id: String) {
        self.isLoading = true
        interactor.getAssetDetailInformation(id: id)
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
                              let equipment = data.equipment
                        else { return }
                        self.assetInfoData = equipment
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchAssetFiles(id: String) {
        self.isLoading = true
        interactor.getAssetFiles(id: id)
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
                receiveValue: { files in
                    DispatchQueue.main.async {
                        guard let data = files.data,
                              let equipment = data.equipmentFiles,
                              let fileAcceptance = equipment.filePenerimaan,
                              let supportingFile = equipment.filePendukung
                        else { return }
                        if let mergedFiles = self.mergeFiles(filePenerimaan: fileAcceptance, filePendukung: supportingFile) {
                            self.assetFilesData = mergedFiles
                        }
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    private func mergeFiles(filePenerimaan: [File], filePendukung: [File]) -> [File]? {
        return filePenerimaan + filePendukung
    }
    
    func fetchAssetCost(id: String) {
        self.isLoading = true
        interactor.getAssetMainCost(id: id)
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
                receiveValue: { cost in
                    DispatchQueue.main.async {
                        guard let data = cost.data,
                              let costData = data.equipment
                        else { return }
                        self.assetCostData = costData
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchAssetTechnical(id: String) {
        self.isLoading = true
        interactor.getAssetTechnical(id: id)
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
                receiveValue: { technical in
                    guard let data = technical.data,
                          let technicalData = data.equipment
                    else { return }
                    self.assetTechnicalData = technicalData
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchAcceptanceAsset(id: String) {
        self.isLoading = true
        interactor.getAssetAcceptance(id: id)
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
                receiveValue: { acceptance in
                    DispatchQueue.main.async {
                        guard let data = acceptance.data else { return }
                        self.assetAcceptanceData = data
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchComplaintTracking(id: String) {
        self.isLoading = true
        interactor.getComplaintTracking(id: id)
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
                receiveValue: { tracking in
                    DispatchQueue.main.async {
                        guard let data = tracking.data else { return }
                        self.trackData = data
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}

extension AssetDetailPresenter {
    
    func showTrackingBottomSheet(from navigation: UINavigationController) {
        let bottomSheet = TrackProgressBottomSheet(nibName: String(describing: TrackProgressBottomSheet.self), bundle: nil)
        bottomSheet.data = self.trackData
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
}
