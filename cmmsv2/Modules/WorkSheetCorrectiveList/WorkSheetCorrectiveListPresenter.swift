//
//  WorkSheetCorrectivePresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/03/24.
//

import Foundation

class WorkSheetCorrectiveListPresenter: BasePresenter {
    
    private let interactor: WorkSheetCorrectiveListInteractor
    private let router = WorkSheetCorrectiveListRouter()
    
    init(interactor: WorkSheetCorrectiveListInteractor) {
        self.interactor = interactor
    }
    
    @Published public var workSheetData: [WorkSheetListEntity] = []
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    var woType: Int = 1
    var woStatus: String = ""
    var limit: Int = 10
    var sort: String = ""
    var hasObstacle: Int = -1
    var keyword: String = ""
    var page: Int = 1
    var isCanLoad = true
    var isFetchingMore = false
    
}

extension WorkSheetCorrectiveListPresenter {
    
    func fetchInitData() {
        self.fetchWorkSheetCorrectiveList(
            woType: self.woType,
            woStatus: self.woStatus,
            limit: self.limit,
            sort: self.sort,
            hasObstacle: self.hasObstacle,
            keyword: self.keyword,
            page: self.page)
    }
    
    func fetchWorkSheetCorrectiveList(woType: Int,
                                      woStatus: String,
                                      limit: Int,
                                      sort: String,
                                      hasObstacle: Int,
                                      keyword: String,
                                      page: Int) {
        self.isLoading = true
        interactor.getWorkSheetCorrectiveList(woType: woType,
                                              woStatus: woStatus,
                                              limit: limit,
                                              sort: sort,
                                              hasObstacle: hasObstacle,
                                              keyword: keyword,
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
            receiveValue: { worksheet in
                DispatchQueue.main.async {
                    guard let data = worksheet.data,
                          let worksheetData = data.wo
                    else { return }
                    
                    let workorderData = worksheetData.compactMap { item in
                        return WorkSheetListEntity(id: item.valEquipmentId ?? "",
                                                   uniqueNumber: item.txtSubTitle ?? "",
                                                   workName: item.txtTitle ?? "",
                                                   workDesc: item.txtRuangan ?? "",
                                                   serial: item.txtSubTitle ?? "",
                                                   installation: item.complain?.equipment?.txtLokasiInstalasi ?? "",
                                                   room: item.txtRuangan ?? "",
                                                   dateTime: item.valDate ?? "",
                                                   category: WorkSheetCategory(rawValue: item.complain?.equipment?.txtKalibrasi ?? "") ?? WorkSheetCategory.none,
                                                   status: WorkSheetStatus(rawValue: item.txtStatus ?? "") ?? WorkSheetStatus.none)
                    }
                    self.workSheetData.append(contentsOf: workorderData)
                }
            }
        )
        .store(in: &anyCancellable)
    }
    
    func fetchNextPage() {
        guard !isFetchingMore && isCanLoad else { return }
        page += 1
        self.fetchWorkSheetCorrectiveList(
            woType: self.woType,
            woStatus: self.woStatus,
            limit: self.limit,
            sort: self.sort,
            hasObstacle: self.hasObstacle,
            keyword: self.keyword,
            page: self.page)
    }
    
}
