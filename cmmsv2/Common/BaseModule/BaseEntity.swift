//
//  BaseEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import Foundation

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

enum PreparationStatus: String, Codable {
    case no = "Tidak"
    case yes = "Ya"
    case damaged = "Rusak"
    case good = "Baik"
    case none = ""
    
    init?(rawValue: String) {
        switch rawValue {
        case "Tidak": self = .no
        case "Ya": self = .yes
        case "Rusak": self = .damaged
        case "Baik": self = .good
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

enum MessageType: String, Codable {
    case success = "Success"
    case errors = "Unauthorized"
    case none = ""
    
    init?(rawValue: String) {
        switch rawValue {
        case "Success": self = .success
        case "Unauthorized": self = .errors
        case "": self = .none
        default: self = .none
        }
    }
    
    func getStringValue() -> String {
        return rawValue
    }
}

enum AssetCategory: String, Codable {
    case medic = "Medic"
    case nonMedic = "Non-Medic"
    case none = ""
    
    init?(rawValue: String) {
        switch rawValue {
        case "Medic": self = .medic
        case "Non-Medic": self = .nonMedic
        case "": self = .none
        default: self = .none
        }
    }
    
    func getStringValue() -> String {
        return rawValue
    }
}
