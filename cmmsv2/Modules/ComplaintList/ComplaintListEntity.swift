//
//  ComplaintListEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/03/24.
//

import Foundation

struct ComplaintListEntity: Identifiable {
    let id = UUID()
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
        case "Delay": self = .delay
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
