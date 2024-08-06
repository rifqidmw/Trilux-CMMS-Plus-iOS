//
//  EquipmentMaintenancePresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/08/24.
//

import Foundation
import UIKit

class EquipmentMaintenancePresenter: BasePresenter {
    
    private let interactor: EquipmentMaintenanceInteractor
    private let router: EquipmentMaintenanceRouter
    var idAsset: String?
    
    @Published public var technicalInfoData: EquipmentTechnical?
    @Published public var mainStatusInfoData: EquipmentMainStatusEntity?
    @Published public var assetCostInfoData: EquipmentMainCoast?
    @Published public var inspectionInfoData: [InspectionData] = []
    @Published public var preventiveInfoData: [InspectionData] = []
    @Published public var equipmentComplaintInfoData: [EquipmentComplaintData] = []
    @Published public var equipmentCalibrationInfoData: [EquipmentCalibrationData] = []
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    init(interactor: EquipmentMaintenanceInteractor, router: EquipmentMaintenanceRouter, idAsset: String) {
        self.interactor = interactor
        self.router = router
        self.idAsset = idAsset
    }
    
}

extension EquipmentMaintenancePresenter {
    
    func fetchInitialData() {
        guard let idAsset else { return }
        fetchTechnicalInfoData(id: idAsset)
        fetchEquipmentMainStatus(id: idAsset)
        fetchAssetCost(id: idAsset)
    }
    
    func fetchTechnicalInfoData(id: String) {
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
                receiveValue: { techData in
                    DispatchQueue.main.async {
                        guard let data = techData.data else { return }
                        self.technicalInfoData = data.equipment
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchEquipmentMainStatus(id: String) {
        self.isLoading = true
        interactor.getAssetMainStatus(id: id)
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
                receiveValue: { mainStatus in
                    DispatchQueue.main.async {
                        self.mainStatusInfoData = mainStatus
                    }
                }
            )
            .store(in: &anyCancellable)
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
                        self.assetCostInfoData = costData
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchInspectionData(limit: Int, id: String?, page: Int) {
        self.isLoading = true
        interactor.getInspection(limit: limit, id: id ?? "", page: page)
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
                receiveValue: { inspection in
                    DispatchQueue.main.async {
                        guard let inspectionList = inspection.data else { return }
                        self.inspectionInfoData = inspectionList
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchPreventiveData(limit: Int, id: String?, page: Int) {
        self.isLoading = true
        interactor.getPreventive(limit: limit, id: id ?? "", page: page)
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
                        guard let inspectionList = preventive.data else { return }
                        self.preventiveInfoData = inspectionList
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchCalibrationData(limit: Int, id: String?, page: Int) {
        self.isLoading = true
        interactor.getCalibration(limit: limit, id: id ?? "", page: page)
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
                receiveValue: { calibration in
                    DispatchQueue.main.async {
                        guard let calibrationList = calibration.data else { return }
                        self.equipmentCalibrationInfoData = calibrationList
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchEquipmentComplaint(limit: Int, id: String?, page: Int) {
        self.isLoading = true
        interactor.getEquipmentComplaint(limit: limit, id: id ?? "", page: page)
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
                receiveValue: { complaint in
                    DispatchQueue.main.async {
                        guard let complaintList = complaint.data else { return }
                        self.equipmentComplaintInfoData.append(contentsOf: complaintList)
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}
