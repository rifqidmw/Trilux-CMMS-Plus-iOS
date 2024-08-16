//
//  WorkSheetApprovalDetailInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/08/24.
//

import Combine

class WorkSheetApprovalDetailInteractor: BaseInteractor {
    
    func getApprovalDetail(id: String?) -> AnyPublisher<HistoryDetailEntity, Error> {
        return api.requestApiPublisher(.detailHistory(id: id))
    }
    
    func approveWorkSheet(data: ApproveWorkSheetRequest) -> AnyPublisher<ApproveWorkSheetEntity, Error> {
        return api.requestApiPublisher(.approveWorkSheet(data: data))
    }
    
}
