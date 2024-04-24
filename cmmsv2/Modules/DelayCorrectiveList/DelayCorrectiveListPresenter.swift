//
//  CorrectiveHoldListPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/03/24.
//

import Foundation

class DelayCorrectiveListPresenter: BasePresenter {
    
    private let interactor: DelayCorrectiveListInteractor
    private let router = DelayCorrectiveListRouter()
    
    init(interactor: DelayCorrectiveListInteractor) {
        self.interactor = interactor
    }
    
    @Published public var complaintData: [ComplaintListEntity] = []
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    var equipmentId: String = ""
    var status: String = "delay"
    var dateFilter: String = "4"
    var keyword: String = ""
    var page: Int = 1
    var limit: Int = 20
    var isCanLoad = true
    var isFetchingMore = false
    
}

extension DelayCorrectiveListPresenter {
    
    func fetchInitData() {
        self.fetchComplaintListData(equipmentId: self.equipmentId,
                                    status: self.status,
                                    limit: self.limit,
                                    page: self.page,
                                    dateFilter: self.dateFilter,
                                    keyword: self.keyword)
    }
    
    func fetchComplaintListData(
        equipmentId: String, status: String, limit: Int, page: Int, dateFilter: String, keyword: String) {
            self.isLoading = true
            interactor.getComplaintList(
                page: page,
                limit: limit,
                equipmentId: equipmentId,
                status: status,
                dateFilter: dateFilter,
                keyword: keyword)
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
                receiveValue: { complains in
                    DispatchQueue.main.async {
                        guard let data = complains.data,
                              let complainsData = data.complains
                        else { return }
                        let complaintList = complainsData.compactMap { item in
                            return ComplaintListEntity(
                                id: item.id ?? 0,
                                image: item.valSenderImg ?? "",
                                date: item.txtComplainTime ?? "",
                                type: item.txtRuangan ?? "",
                                title: item.valEquipmentName ?? "",
                                description: item.txtSenderName ?? "",
                                technician: item.txtEngineerName ?? "",
                                damage: item.txtTitle ?? "",
                                status: CorrectiveStatusType(rawValue: item.txtStatus ?? "") ?? .none,
                                isActionActive: item.canDeleteLk ?? false)
                        }
                        self.complaintData.append(contentsOf: complaintList)
                    }
                }
            )
            .store(in: &anyCancellable)
        }
    
    func fetchNextPage() {
        guard !isFetchingMore && isCanLoad else { return }
        page += 1
        fetchComplaintListData(equipmentId: self.equipmentId,
                               status: self.status,
                               limit: self.limit,
                               page: self.page,
                               dateFilter: self.dateFilter,
                               keyword: self.keyword)
    }
    
}
