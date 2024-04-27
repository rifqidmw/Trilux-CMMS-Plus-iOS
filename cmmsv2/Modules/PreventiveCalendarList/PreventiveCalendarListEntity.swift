//
//  PreventiveCalendarListEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 18/03/24.
//

import Foundation

struct PreventiveScheduleListEntity: Codable {
    let data: [PreventiveScheduleData]?
    let message: String?
    let status: Int?
    
    enum CodingKeys: CodingKey {
        case data
        case message
        case status
    }
}

struct PreventiveScheduleData: Codable {
    let date: String?
    let total: String?
    
    enum CodingKeys: CodingKey {
        case date
        case total
    }
}
