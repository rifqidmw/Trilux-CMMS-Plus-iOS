//
//  CalibrationListPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 12/03/24.
//

import UIKit

class CalibrationListPresenter: BasePresenter {
    
    private let interactor: CalibrationListInteractor
    private let router = CalibrationListRouter()
    
    init(interactor: CalibrationListInteractor) {
        self.interactor = interactor
    }
    
    @Published public var calibrationData: [WorkSheetListEntity] = []
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    var keyword: String = ""
    var limit: Int = 20
    var page: Int = 1
    var isCanLoad = true
    var isFetchingMore = false
    
}

extension CalibrationListPresenter {
    
    func fetchInitData() {
        self.fetchCalibrationList(keyword: self.keyword, limit: self.limit, page: self.page)
    }
    
    func fetchCalibrationList(keyword: String, limit: Int, page: Int) {
        self.isLoading = true
        interactor.getCalibrationList(keyword: keyword, limit: limit, page: page)
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
                        guard let data = calibration.data
                        else { return }
                        
                        let calibrationData = data.compactMap { item in
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
                        self.calibrationData.append(contentsOf: calibrationData)
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchNextPage() {
        guard !isFetchingMore && isCanLoad else { return }
        page += 1
        self.fetchCalibrationList(keyword: self.keyword, limit: self.limit, page: self.page)
    }
    
}
