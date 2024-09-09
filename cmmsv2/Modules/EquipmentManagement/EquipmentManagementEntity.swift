//
//  EquipmentManagementEntity.swift
//  cmmsv2
//
//  Created by macbook  on 10/09/24.
//

import Foundation

enum EquipmentManagementType {
    case returning
    case loan
}

enum EquipmentManagementSegmentedType: String, CaseIterable {
    case borrowed = "Dipinjam"
    case loan = "Pinjaman"
    case submission = "Pengajuan"
    case request = "Permintaan"
    case none = ""
    
    init?(rawValue: String) {
        switch rawValue {
        case "Dipinjam": self = .borrowed
        case "Pinjaman": self = .loan
        case "Pengajuan": self = .submission
        case "Permintaan": self = .request
        case "": self = .none
        default: self = .none
        }
    }
    
    func getStringValue() -> String {
        return rawValue
    }
}
