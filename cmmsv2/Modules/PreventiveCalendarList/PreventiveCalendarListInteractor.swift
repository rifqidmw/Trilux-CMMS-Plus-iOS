//
//  PreventiveCalendarListInteractor.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 18/03/24.
//

import Combine

class PreventiveCalendarListInteractor: BaseInteractor {
    
    func getPreventiveCalendarList(idEngineer: String? = nil, month: String? = nil) -> AnyPublisher<PreventiveScheduleListEntity, Error> {
        return api.requestApiPublisher(.calendarPreventiveList(idEngineer: idEngineer, month: month))
    }
    
    func getSchedulePreventiveList(date: String? = nil, page: Int? = nil, limit: Int? = nil) -> AnyPublisher<WorkSheetEntity, Error> {
        return api.requestApiPublisher(.schedulePreventiveList(date: date))
    }
    
    func getTechnicianList(job: String) -> AnyPublisher<SelectTechnicianEntity, Error> {
        return api.requestApiPublisher(.userFilter(job: job))
    }
    
}
