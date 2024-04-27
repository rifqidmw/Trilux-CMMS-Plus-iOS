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
    
    func getSchedulePreventiveList(idEngineer: String? = nil, date: String? = nil, page: Int? = nil, limit: Int? = nil) -> AnyPublisher<WorkSheetEntity, Error> {
        return api.requestApiPublisher(.schedulePreventiveList(idEngineer: idEngineer, date: date))
    }
    
}
