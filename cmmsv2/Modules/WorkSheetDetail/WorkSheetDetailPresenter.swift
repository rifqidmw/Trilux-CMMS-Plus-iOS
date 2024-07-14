//
//  WorkSheetOnsitePreventiveDetailPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/02/24.
//

import Foundation
import UIKit

class WorkSheetDetailPresenter: BasePresenter {
    
    private let interactor: WorkSheetDetailInteractor
    private let router: WorkSheetDetailRouter
    let type: WorkSheetDetailType?
    let data: WorkSheetRequestEntity?
    let activity: WorkSheetActivityType?
    
    @Published public var monitoringFunctionData: MonitoringFunctionEntity?
    @Published public var calibratorList: [Kalibrator] = []
    @Published public var saveWorkSheet: SaveWorkSheetResponseEntity?
    @Published public var sparePartList: [SearchSparePartData] = []
    @Published public var dataLK: LKData?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    var sparePartKey: String = ""
    var statusData: [WorkingStatusEntity] = [
        WorkingStatusEntity(id: "0", lkStatus: "3", label: "Selesai, Bisa digunakan Kembali"),
        WorkingStatusEntity(id: "1", lkStatus: "2", label: "Dalam Proses Pengerjaan")
    ]
    var finishStatusData: [WorkingFinishStatusEntity] = [
        WorkingFinishStatusEntity(id: "0", lkFinishstt: "0", label: "Selesai")
    ]
    
    init(interactor: WorkSheetDetailInteractor,
         router: WorkSheetDetailRouter,
         type: WorkSheetDetailType,
         data: WorkSheetRequestEntity,
         activity: WorkSheetActivityType) {
        self.interactor = interactor
        self.router = router
        self.type = type
        self.data = data
        self.activity = activity
    }
    
}

extension WorkSheetDetailPresenter {
    
    func fetchInitialData() {
        guard let data else { return }
        switch self.type {
        case .monitoring, .preventive, .calibration:
            self.fetchMonitoringFunctionDetail(id: data.id, action: data.action)
            if case .calibration = self.type {
                self.fetchCalibratorList()
            } else if case .preventive = self.type {
                self.fetchSparePartList(key: self.sparePartKey)
            }
        default: break
        }
    }
    
    func fetchMonitoringFunctionDetail(id: String?, action: String?) {
        self.isLoading = true
        interactor.getDetailMonitoringFunction(id: id, action: action)
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
                        self.monitoringFunctionData = worksheet
                        self.dataLK = worksheet.data
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchCalibratorList() {
        self.isLoading = true
        interactor.getCalibratorList()
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
                receiveValue: { calibrator in
                    DispatchQueue.main.async {
                        guard let data = calibrator.data else { return }
                        self.calibratorList = data
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func saveWorkSheet(data: LKStartRequest) {
        self.isLoading = true
        interactor.saveWorkSheet(data: data)
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
                receiveValue: { workSheetSaved in
                    DispatchQueue.main.async {
                        self.saveWorkSheet = workSheetSaved
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchSparePartList(key: String? = nil) {
        self.isLoading = true
        interactor.getSparePartList(key: key ?? "")
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
                receiveValue: { sparePart in
                    DispatchQueue.main.async {
                        guard let sparePartData = sparePart.data else { return }
                        self.sparePartList = sparePartData
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}

extension WorkSheetDetailPresenter {
    
    func showInputBottomSheet(from navigation: UINavigationController, delegate: InputBottomSheetDelegate, type: InputBottomSheetType) {
        let bottomSheet = InputBottomSheet(nibName: String(describing: InputBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        bottomSheet.type = type
        router.showBottomSheet(nav: navigation, bottomSheetView: bottomSheet)
    }
    
    func showSelectSparePartBottomSheet(from navigation: UINavigationController, delegate: SparePartBottomSheetDelegate, type: SparePartBottomSheetType) {
        let bottomSheet = SparePartBottomSheet(nibName: String(describing: SparePartBottomSheet.self), bundle: nil)
        bottomSheet.data = self.sparePartList
        bottomSheet.delegate = delegate
        bottomSheet.type = type
        router.showBottomSheet(nav: navigation, bottomSheetView: bottomSheet)
    }
    
    func showSelectStatusBottomSheet(from navigation: UINavigationController, delegate: SelectStatusBottomSheetDelegate, type: SelectStatusType) {
        let bottomSheet = SelectStatusBottomSheet(nibName: String(describing: SelectStatusBottomSheet.self), bundle: nil)
        bottomSheet.statusData = self.statusData
        bottomSheet.finishStatusData = self.finishStatusData
        bottomSheet.type = type
        bottomSheet.delegate = delegate
        router.showBottomSheet(nav: navigation, bottomSheetView: bottomSheet)
    }
    
}
