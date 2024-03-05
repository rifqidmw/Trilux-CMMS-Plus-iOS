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
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    var page: Int = 1
    var limit: Int = 10
    var isCanLoad = true
    var isFetchingMore = false
    
    init(interactor: NotificationListInteractor) {
        self.interactor = interactor
    }
    
}

extension NotificationListPresenter {
    
    func fetchInitData() {
        self.fetchListNotificationData(page: self.page, limit: self.limit)
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
    
    func fetchNextPage() {
        guard !isFetchingMore && isCanLoad else { return }
        page += 1
        fetchListNotificationData(page: page, limit: limit)
    }
    
}

extension NotificationListPresenter {
    
    func showDetailNotificationBottomSheet(navigation: UINavigationController) {
        router.showDetailNotificationBottomSheet(navigation: navigation)
    }
    
}
