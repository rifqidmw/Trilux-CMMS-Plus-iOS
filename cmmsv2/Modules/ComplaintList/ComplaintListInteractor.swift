//
//  ComplaintListInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/03/24.
//

import Combine

class ComplaintListInteractor: BaseInteractor {
    
    func getComplaintList(
        page: Int? = nil,
        limit: Int? = nil,
        equipmentId: String? = nil,
        status: String? = nil,
        dateFilter: String? = nil,
        keyword: String? = nil) -> AnyPublisher<ComplaintEntity, Error> {
            return api.requestApiPublisher(.getComplaintList(
                page: page,
                limit: limit,
                equipmentId: equipmentId,
                status: status,
                dateFilter: dateFilter,
                keyword: keyword))
            
        }
    
    func getTechnicianList(job: String) -> AnyPublisher<SelectTechnicianEntity, Error> {
        return api.requestApiPublisher(.userFilter(job: job))
    }
    
    func createLanjutan(engineerId: String?, complainId: String?, dueDate: String?, engineerPendamping: [String]?) -> AnyPublisher<CreateLanjutanEntity, Error> {
        return api.requestApiPublisher(.createLanjutan(engineerId: engineerId ?? "", complainId: complainId ?? "", dueDate: dueDate ?? "", engineerPendamping: engineerPendamping ?? []))
    }
    
    func createCorrective(engineerId: String?, complainId: String?, dueDate: String?, engineerPendamping: [String]?) -> AnyPublisher<AcceptCorrectiveEntity, Error> {
        return api.requestApiPublisher(.createCorrective(engineerId: engineerId ?? "", complainId: complainId ?? "", dueDate: dueDate ?? "", engineerPendamping: engineerPendamping ?? []))
    }
    
    func deleteLk(idLk: String?) -> AnyPublisher<DeleteComplaintEntity, Error> {
        return api.requestApiPublisher(.deleteLk(id: idLk ?? ""))
    }
    
    func deleteComplaint(_ id: String?) -> AnyPublisher<DeleteComplaintResponseEntity, Error> {
        return api.requestApiPublisher(.deleteComplaint(id: id ?? ""))
    }
    
}
