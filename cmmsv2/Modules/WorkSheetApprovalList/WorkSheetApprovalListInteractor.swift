//
//  WorkSheetApprovalListInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 30/07/24.
//

import Foundation
import Combine

class WorkSheetApprovalListInteractor: BaseInteractor {
    
    func getWorkSheetApproval(
        woType: String? = nil,
        woStatus: String? = nil,
        limit: Int? = nil,
        page: Int? = nil) -> AnyPublisher<WorkSheetApprovalListEntity, Error> {
            return api.requestApiPublisher(.approvalList(
                woType: woType,
                woStatus: woStatus,
                limit: limit,
                page: page))
        }
    
    func approveWorkSheet(data: ApproveWorkSheetRequest) -> AnyPublisher<ApproveWorkSheetEntity, Error> {
        return api.requestApiPublisher(.approveWorkSheet(data: data))
    }
    
}
