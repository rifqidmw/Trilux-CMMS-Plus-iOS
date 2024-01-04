//
//  BaseEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import Foundation

struct BaseEntity {
    let id = UUID()
    let title: String?
}

struct ServiceTest: Codable {
    let createdAt, name, avatar, id, requestID: String
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case createdAt, name, avatar, id, count
        case requestID = "requestId"
    }
}
