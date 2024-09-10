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
    
    @Published public var notification: [NotificationList] = []
    @Published public var workSheetDetail: HistoryDetailEntity?
    @Published public var workSheetData: [WorkOrder] = []
    @Published public var complaintData: [Complaint] = []
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    var page: Int = 1
    var limit: Int = 80
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
                        self.notification.append(contentsOf: notification)
                        AppManager.setNotificationList(notification)
                        AppManager.setIsOpenedNotification(true)
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchWorkSheetDetail(id: String?, completion: (() -> Void)? = nil) {
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
                        completion?()
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
                        self.complaintData = complainsData
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}

extension NotificationListPresenter {
    
    func showBottomSheetCorrective(navigation: UINavigationController, data: WorkOrder, delegate: WorkSheetCorrectiveBottomSheetDelegate) {
        let bottomSheet = WorkSheetCorrectiveBottomSheet(nibName: String(describing: WorkSheetCorrectiveBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        bottomSheet.data = data
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
}
