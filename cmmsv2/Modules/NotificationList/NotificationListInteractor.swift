//
//  NotificationListInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 18/02/24.
//

import Combine

class NotificationListInteractor: BaseInteractor {
    
    func getNotification(page: Int, limit: Int) -> AnyPublisher<NotificationListEntity, Error> {
        return api.requestApiPublisher(.getNotification(page: page, limit: limit))
    }
    
    func getWorkSheetNotification(id: String?) -> AnyPublisher<HistoryDetailEntity, Error> {
        return api.requestApiPublisher(.detailHistory(id: id ?? ""))
    }
    
    func getWorkSheetCorrectiveList() -> AnyPublisher<WorkSheetCorrectiveListEntity, Error> {
        return api.requestApiPublisher(.workSheetCorrective())
    }
    
    func getComplaintList() -> AnyPublisher<ComplaintEntity, Error> {
        return api.requestApiPublisher(.getComplaintList())
        
    }
    
}
