//
//  NotificationListPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 18/02/24.
//

import UIKit

class NotificationListPresenter: BasePresenter {
    
    private let interactor: NotificationListInteractor
    private let router = NotificationListRouter()
    
    @Published public var notificationData: NotificationListEntity?
    @Published public var notification: [NotificationList] = []
    @Published public var workSheetDetail: HistoryDetailEntity?
    @Published public var workSheetData: [WorkOrder] = []
    @Published public var complaintData: [ComplaintListEntity] = []
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    var page: Int = 1
    var limit: Int = 20
    var isCanLoad = true
    var isFetchingMore = false
    
    init(interactor: NotificationListInteractor) {
        self.interactor = interactor
    }
    
}

extension NotificationListPresenter {
    
    func fetchInitData() {
        self.fetchListNotificationData(page: self.page, limit: self.limit)
        self.fetchWorkSheetCorrectiveList()
        self.fetchComplaintList()
    }
    
    func fetchListNotificationData(page: Int, limit: Int) {
        self.isLoading = true
        interactor.getNotification(page: page, limit: limit)
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
                receiveValue: { notif in
                    DispatchQueue.main.async {
                        guard let data = notif.data,
                              let notification = data.notifications
                        else { return }
                        self.notificationData = notif
                        self.notification.append(contentsOf: notification)
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchWorkSheetDetail(id: String?) {
        self.isLoading = true
        interactor.getWorkSheetNotification(id: id ?? "")
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
                receiveValue: { workSheet in
                    DispatchQueue.main.async {
                        self.workSheetDetail = workSheet
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchNextPage() {
        guard !isFetchingMore && isCanLoad else { return }
        page += 1
        fetchListNotificationData(page: page, limit: limit)
    }
    
    func fetchWorkSheetCorrectiveList() {
        self.isLoading = true
        interactor.getWorkSheetCorrectiveList()
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
                        self.workSheetData = worksheetData
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchComplaintList() {
        self.isLoading = true
        interactor.getComplaintList()
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
                                status: CorrectiveStatusType(rawValue: item.txtStatus ?? "") ?? CorrectiveStatusType.none,
                                isActionActive: item.canDeleteLk ?? false)
                        }
                        self.complaintData.append(contentsOf: complaintList)
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}

extension NotificationListPresenter {
    
    func showBottomSheetCorrective(navigation: UINavigationController, data: WorkOrder, delegate: WorkSheetCorrectiveBottomSheetDelegate) {
        router.showBottomSheetCorrective(navigation: navigation, data: data, delegate: delegate)
    }
    
    func navigateToDetailWorkSheetCorrective(navigation: UINavigationController, data: WorkOrder) {
        router.navigateToDetailWorkSheetCorrective(navigation: navigation, data: data)
    }
    
    func navigateToComplaintDetail(navigation: UINavigationController, data: ComplaintListEntity) {
        router.navigateToComplaintDetail(navigation: navigation, data: data)
    }
    
}
