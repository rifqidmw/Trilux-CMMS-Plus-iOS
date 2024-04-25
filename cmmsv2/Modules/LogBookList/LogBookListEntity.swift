//
//  LogBookEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 17/03/24.
//

import Foundation

struct LogBookListEntity: Codable {
    let data: [LogBookData]?
    let reff: ReffLK?
    let message: String?
    let status: Int?
    
    enum CodingKeys: CodingKey {
        case data
        case reff
        case message
        case status
    }
}

struct LogBookData: Codable {
    let id_lk: String?
    let tanggal: String?
    let timestamp: Int?
    let time: String?
    let tindakan: [String]?
    let lk_number: String?
    let lk_info: String?
    
    enum CodingKeys: CodingKey {
        case id_lk
        case tanggal
        case timestamp
        case time
        case tindakan
        case lk_number
        case lk_info
    }
}
