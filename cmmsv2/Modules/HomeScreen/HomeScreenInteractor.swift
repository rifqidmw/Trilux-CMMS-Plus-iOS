//
//  HomeScreenInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/01/24.
//

import Combine

class HomeScreenInteractor: BaseInteractor {
    
    func getInfoExpired() -> AnyPublisher<ExpiredEntity, Error> {
        return api.requestApiPublisher(.infoExpired)
    }
    
    func getReminderPreventive(date: String?) -> AnyPublisher<ReminderPreventiveEntity, Error> {
        return api.requestApiPublisher(.reminderPreventive(date: date ?? ""))
    }
    
    func getNotification() -> AnyPublisher<NotificationListEntity, Error> {
        return api.requestApiPublisher(.getNotification(page: 1, limit: 300))
    }
    
}
