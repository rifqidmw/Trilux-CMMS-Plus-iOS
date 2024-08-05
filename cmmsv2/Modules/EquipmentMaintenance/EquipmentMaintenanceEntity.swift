//
//  EquipmentMaintenanceEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/08/24.
//

import Foundation

struct EquipmentMainStatusEntity: Codable {
    let count: Int?
    let data: EquipmentMainStatusData?
    let message: String?
    let status: Int?
    let reff: ReffData?
}

struct EquipmentMainStatusData: Codable {
    let equipment: EquipmentMainStatus?
}

struct EquipmentMainStatus: Codable {
    let id: String?
    let complain: EquipmentStatus?
    let preventif: EquipmentStatus?
    let inspeksi: EquipmentStatus?
    let kalibrasi: EquipmentStatus?
}

struct EquipmentStatus: Codable {
    let status: Int?
}
