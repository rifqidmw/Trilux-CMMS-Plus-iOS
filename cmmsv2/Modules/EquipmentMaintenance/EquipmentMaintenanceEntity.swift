//
//  EquipmentMaintenanceEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/08/24.
//

import Foundation

// MARK: - EQUIPMENT STATUS
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

// MARK: - INSPECTION
struct InspectionEntity: Codable {
    let data: [InspectionData]?
    let reff: ReffData?
    let message: String?
    let status: Int?
}

struct InspectionData: Codable {
    let idLK: String?
    let lkNumber: String?
    let txtTanggal: String?
    let txtTeknisi: String?
    let txtPekerjaan: String?
    let valStatus: StatusValue?
    let txtStatus: String?
    let valFinish: Int?
    let txtFinish: String?
    let lkInfo: String?
    
    enum CodingKeys: String, CodingKey {
        case idLK = "id_lk"
        case lkNumber = "lk_number"
        case txtTanggal
        case txtTeknisi = "txtteknisi"
        case txtPekerjaan
        case valStatus
        case txtStatus
        case valFinish
        case txtFinish
        case lkInfo = "lk_info"
    }
}

// MARK: - EQUIPMENT COMPLAINT
struct EquipmentComplaintEntity: Codable {
    let data: [EquipmentComplaintData]?
    let reff: ReffData?
    let message: String?
    let status: Int?
}

struct EquipmentComplaintData: Codable {
    let idComplain: String?
    let txtTanggal: String?
    let txtContributor: String?
    let txtStatus: String?
    let valStatus: StatusValue?
    let txtTitle: String?
    let txtPengaduan: String?
    let txtPerbaikan: String?
    let photos: [EquipmentComplaintPhoto]?
    let detailLK: [EquipmentComplaintDetail]?
    
    enum CodingKeys: String, CodingKey {
        case idComplain
        case txtTanggal
        case txtContributor
        case txtStatus
        case valStatus
        case txtTitle
        case txtPengaduan
        case txtPerbaikan
        case photos
        case detailLK = "detail_lk"
    }
}

struct EquipmentComplaintDetail: Codable {
    let lkStatus: String?
    let lkStatusText: String?
    let lkFinishstt: String?
    let lkFinishText: String?
    let idLK: String?
    let lkNumber: String?
    let lkDate: String?
    let engineername: String?
    let lkInfo: String?
    
    enum CodingKeys: String, CodingKey {
        case lkStatus = "lk_status"
        case lkStatusText = "lk_status_text"
        case lkFinishstt = "lk_finishstt"
        case lkFinishText = "lk_finish_text"
        case idLK = "id_lk"
        case lkNumber = "lk_number"
        case lkDate = "lk_date"
        case engineername
        case lkInfo = "lk_info"
    }
}

struct EquipmentComplaintPhoto: Codable {
    let id: String?
    let url: String?
    let thumb: String?
}

enum StatusValue: Codable {
    case string(String)
    case integer(Int)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            self = .integer(intValue)
        } else if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else {
            throw DecodingError.typeMismatch(StatusValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected String or Int value"))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let value):
            try container.encode(value)
        case .integer(let value):
            try container.encode(value)
        }
    }
}
