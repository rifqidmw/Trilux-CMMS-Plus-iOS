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

enum WorkSheetCategory: String, Codable {
    case calibration = "Kalibrasi"
    case preventive = "Preventif"
    case corrective = "Korektif"
    case none = ""
    
    init?(rawValue: String) {
        switch rawValue {
        case "Kalibrasi": self = .calibration
        case "Preventif": self = .preventive
        case "Korektif": self = .corrective
        case "": self = .none
        default: self = .none
        }
    }
    
    func getStringValue() -> String {
        return rawValue
    }
}

enum WorkSheetStatus: String, Codable {
    case done = "Selesai, Bisa digunakan kembali"
    case open = "Open"
    case ongoing = "Dalam proses pengerjaan"
    case none = ""
    
    init?(rawValue: String) {
        switch rawValue {
        case "Selesai, Bisa digunakan kembali": self = .done
        case "Open": self = .open
        case "Dalam proses pengerjaan": self = .ongoing
        case "": self = .none
        default: self = .none
        }
    }
    
    func getStringValue() -> String {
        return rawValue
    }
}
