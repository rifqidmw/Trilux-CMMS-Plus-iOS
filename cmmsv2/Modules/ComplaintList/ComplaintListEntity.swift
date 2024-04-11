//
//  ComplaintListEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/03/24.
//

import Foundation

struct ComplaintEntity: Codable {
    let count: Int?
    let data: ComplaintData?
    let message: String?
    let status: Int?
    let reff: ReffData?
    
    enum CodingKeys: CodingKey {
        case count
        case data
        case message
        case status
        case reff
    }
}

struct ComplaintData: Codable {
    let complains: [Complaint]?
    
    enum CodingKeys: CodingKey {
        case complains
    }
}

struct Complaint: Codable {
    let id: Int?
    let valEquipmentId: Int?
    let valEquipmentName: String?
    let valEquipmentImg: String?
    let txtEquipmentSerial: String?
    let txtRuangan: String?
    let txtTitle: String?
    let txtDescriptions: String?
    let txtStatus: String?
    let valStatus: String?
    let txtSenderName: String?
    let valSenderImg: String?
    let txtComplainTime: String?
    let valIsManagable: Int?
    let valObservation: Int?
    let valCorrective: Int?
    let txtDownTime: String?
    let txtResponseTime: String?
    let valDelegatedTime: String?
    let valDelegatable: Bool?
    let txtEngineerName: String?
    let userIDfinish: String?
    let isDelay: String?
    let canPendamping: String?
    let infoLk: InfoLk?
    let canDeleteLk: Bool?
    let idLkActive: String?
    
    enum CodingKeys: CodingKey {
        case id
        case valEquipmentId
        case valEquipmentName
        case valEquipmentImg
        case txtEquipmentSerial
        case txtRuangan
        case txtTitle
        case txtDescriptions
        case txtStatus
        case valStatus
        case txtSenderName
        case valSenderImg
        case txtComplainTime
        case valIsManagable
        case valObservation
        case valCorrective
        case txtDownTime
        case txtResponseTime
        case valDelegatedTime
        case valDelegatable
        case txtEngineerName
        case userIDfinish
        case isDelay
        case canPendamping
        case infoLk
        case canDeleteLk
        case idLkActive
    }
}

struct InfoLk: Codable {
    let lkNumber: String?
    let engineerName: String?
    let pendampingName: String?
    let idPendamping: [String]?
    
    enum CodingKeys: CodingKey {
        case lkNumber
        case engineerName
        case pendampingName
        case idPendamping
    }
}

struct ComplaintReffData: Codable {
    let page: String?
    let pageSize: String?
    let totalPage: String?
    let totalItem: String?
    
    enum CodingKeys: CodingKey {
        case page
        case pageSize
        case totalPage
        case totalItem
    }
}


struct ComplaintListEntity: Identifiable {
    let id: Int
    let image: String
    let date: String
    let type: String
    let title: String
    let description: String
    let technician: String
    let damage: String
    let status: CorrectiveStatusType
    var isActionActive = false
}

enum CorrectiveStatusType: String {
    case open
    case closed
    case progress
    case delay
    case none
    
    init?(rawValue: String) {
        switch rawValue {
        case "Open": self = .open
        case "Closed": self = .closed
        case "Progress": self = .progress
        case "Progress(Delay)": self = .delay
        case "": self = .none
        default: self = .none
        }
    }
    
    func getStringValue() -> String {
        return rawValue
    }
}

let dummyComplaintData: [ComplaintListEntity] = [
    ComplaintListEntity(
        id: 1,
        image: "unsplash_cEzMOp5FtV4",
        date: "23-Juni-2022",
        type: "Cendana",
        title: "Pulse Oxymeter / Oximeter",
        description: "Pulse Oxymeter / Oximeter",
        technician: "Alex Bill",
        damage: "Alat tidak hidup sama sekali",
        status: .progress,
        isActionActive: false),
    ComplaintListEntity(
        id: 2,
        image: "unsplash_cEzMOp5FtV4",
        date: "26-Juni-2022",
        type: "Cendana",
        title: "Electrode Cable / Kabel Elektrik",
        description: "Poliklinik Executive Cendana",
        technician: "Alex Bill",
        damage: "Putus",
        status: .delay,
        isActionActive: true),
    ComplaintListEntity(
        id: 3,
        image: "unsplash_gKUC4TMhOiY",
        date: "24-Juni-2022",
        type: "Inap",
        title: "Bed-side Monitor/Bed-patien",
        description: "Pelayanan Rawat Inap",
        technician: "Alex Bill",
        damage: "Mati total",
        status: .closed,
        isActionActive: false),
    ComplaintListEntity(
        id: 4,
        image: "unsplash_m_HRfLhgABo",
        date: "25-Juni-2022",
        type: "Paridani",
        title: "Ventilator",
        description: "Pelayanan Perawatan Intensif Bayi",
        technician: "Maruf",
        damage: "Alat rusak total",
        status: .open,
        isActionActive: true),
    ComplaintListEntity(
        id: 5,
        image: "unsplash_cEzMOp5FtV4",
        date: "23-Juni-2022",
        type: "Cendana",
        title: "Pulse Oxymeter / Oximeter",
        description: "Pulse Oxymeter / Oximeter",
        technician: "Alex Bill",
        damage: "Alat tidak hidup sama sekali",
        status: .progress,
        isActionActive: false),
    ComplaintListEntity(
        id: 6,
        image: "unsplash_cEzMOp5FtV4",
        date: "26-Juni-2022",
        type: "Cendana",
        title: "Electrode Cable / Kabel Elektrik",
        description: "Poliklinik Executive Cendana",
        technician: "Alex Bill",
        damage: "Putus",
        status: .delay,
        isActionActive: true),
    ComplaintListEntity(
        id: 7,
        image: "unsplash_gKUC4TMhOiY",
        date: "24-Juni-2022",
        type: "Inap",
        title: "Bed-side Monitor/Bed-patien",
        description: "Pelayanan Rawat Inap",
        technician: "Alex Bill",
        damage: "Mati total",
        status: .closed,
        isActionActive: false),
    ComplaintListEntity(
        id: 8,
        image: "unsplash_m_HRfLhgABo",
        date: "25-Juni-2022",
        type: "Paridani",
        title: "Ventilator",
        description: "Pelayanan Perawatan Intensif Bayi",
        technician: "Maruf",
        damage: "Alat rusak total",
        status: .open,
        isActionActive: true)
]
