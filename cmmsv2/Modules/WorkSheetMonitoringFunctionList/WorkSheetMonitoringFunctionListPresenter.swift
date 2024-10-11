//
//  WorkSheetListPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/01/24.
//

import UIKit

class WorkSheetMonitoringFunctionListPresenter: BasePresenter {
    
    private let interactor: WorkSheetMonitoringFunctionListInteractor
    private let router = WorkSheetMonitoringFunctionListRouter()
    
    init(interactor: WorkSheetMonitoringFunctionListInteractor) {
        self.interactor = interactor
    }
    
    @Published public var workSheetData: [WorkSheetListEntity] = []
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    var page: Int = 1
    var limit: Int = 20
    var tipe: Int = 21
    var status: Int = -1
    var keyword: String = ""
    var isCanLoad = true
    var isFetchingMore = false
    
}

extension WorkSheetMonitoringFunctionListPresenter {
    
    func fetchInitData(keyword: String? = nil) {
        if let keyword = keyword {
            self.keyword = keyword
        }
        
        self.page = 1
        self.workSheetData.removeAll()
        self.fetchWorkSheetMonitoringFunctionList(
            limit: self.limit,
            page: self.page,
            tipe: self.tipe,
            status: self.status,
            keyword: self.keyword)
    }
    
    func fetchWorkSheetMonitoringFunctionList(
        limit: Int,
        page: Int,
        tipe: Int,
        status: Int,
        keyword: String) {
            self.isLoading = true
            interactor.getWorkSheetMonitoringFunctionList(
                limit: limit,
                page: page,
                tipe: tipe,
                keyword: keyword,
                status: status)
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
                        guard let data = worksheet.data else { return }
                        let worksheetList = data.compactMap { item in
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
                        
                        let filteredData = worksheetList.filter { newItem in
                            !self.workSheetData.contains(where: { $0.idLK == newItem.idLK })
                        }
                        
                        self.workSheetData.append(contentsOf: filteredData)
                    }
                }
            )
            .store(in: &anyCancellable)
        }
    
    func fetchNextPage() {
        guard !isFetchingMore && isCanLoad else { return }
        page += 1
        fetchWorkSheetMonitoringFunctionList(
            limit: self.limit,
            page: self.page,
            tipe: self.tipe,
            status: self.status,
            keyword: self.keyword)
    }
    
}
