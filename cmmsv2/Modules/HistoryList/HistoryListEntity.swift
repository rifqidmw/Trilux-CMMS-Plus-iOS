//
//  HistoryListEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/03/24.
//

import Foundation

struct HistorySortEntity: Codable {
    var id: Int?
    var sortType: HistorySortType?
    var hasObstacle: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case sortType = "sort_type"
        case hasObstacle = "has_obstacle"
    }
}

enum HistorySortType: String, Codable {
    case all = "Semua"
    case hold = "Riwayat Korektif Terkendala"
    case done = "Riwayat Korektif Terselesaikan"
    case none = ""
    
    init?(rawValue: String) {
        switch rawValue {
        case "Semua": self = .all
        case "Riwayat Korektif Terkendala": self = .hold
        case "Riwayat Korektif Terselesaikan": self = .done
        case "Tunda Perbaikan": self = .hold
        case "": self = .none
        default: self = .none
        }
    }
    
    func getStringValue() -> String {
        return rawValue
    }
}

struct HistoryListEntity {
    let id = UUID()
    let date: String
    let title: String
    let description: String
    let isApproved: Bool
    let room: String
    let status: HistoryStatusType
}

let historyDataList: [HistoryListEntity] = [
    HistoryListEntity(
        date: "2023-11-27 11.38",
        title: "ECG/EKG/Electrocardiograph 6",
        description: "No#123932423/BL TL Cardiopoint Ergo E600",
        isApproved: true,
        room: "Pelayanan Gawat Darurat",
        status: .done),
    HistoryListEntity(
        date: "2023-11-27 11.38",
        title: "ECG/EKG/Electrocardiograph 6",
        description: "No#123932423/BL TL Cardiopoint Ergo E600",
        isApproved: true,
        room: "Pelayanan Gawat Darurat",
        status: .done),
    HistoryListEntity(
        date: "2023-11-27 11.38",
        title: "ECG/EKG/Electrocardiograph 6",
        description: "No#123932423/BL TL Cardiopoint Ergo E600",
        isApproved: false,
        room: "Pelayanan Gawat Darurat",
        status: .removed),
    HistoryListEntity(
        date: "2023-11-27 11.38",
        title: "ECG/EKG/Electrocardiograph 6",
        description: "No#123932423/BL TL Cardiopoint Ergo E600",
        isApproved: false,
        room: "Pelayanan Gawat Darurat",
        status: .hold),
    HistoryListEntity(
        date: "2023-11-27 11.38",
        title: "ECG/EKG/Electrocardiograph 6",
        description: "No#123932423/BL TL Cardiopoint Ergo E600",
        isApproved: true,
        room: "Pelayanan Gawat Darurat",
        status: .done)
]
