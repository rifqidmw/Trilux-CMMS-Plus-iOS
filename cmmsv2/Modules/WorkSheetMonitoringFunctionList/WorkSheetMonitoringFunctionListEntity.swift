//
//  WorkSheetListEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/01/24.
//

import Foundation

protocol WorkSheetListDelegate: AnyObject {
    func didTapDetailWorkSheet()
}

struct MaintenanceDataLK: Codable {
    let data: [MaintenanceLK]?
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

struct MaintenanceLK: Codable {
    let idLK: String?
    let lkNumber: String?
    let lkJenis: String?
    let lkVarian: String?
    let lkDate: String?
    let lkEngineer: String?
    let lkAssign: String?
    let idAsset: String?
    let lkLabel: String?
    let lkInfo: String?
    let lkStatus: String?
    let lkFinishstt: String?
    let lkWebenable: String?
    let lkStart: String?
    let lkFinish: String?
    let lkContinue: String?
    let lkDurasireal: String?
    let lkRating: String?
    let createBy: String?
    let approveBy: String?
    let rateBy: String?
    let createAt: String?
    let expired: String?
    let lkGeneralflag: String?
    let extra: String?
    let txtJenis: String?
    let txtStatus: String?
    let txtFinishStatus: String?
    let txtEngineerName: String?
    let dateText: String?
    let assetImage: String?
    let assetName: String?
    let brandName: String?
    let typeName: String?
    let serial: String?
    let instalasi: String?
    let ruangan: String?
    let isPendamping: String?
    let canPendamping: String?
    let infoLk: InfoLK?
    let namaPerating: String?
    
    enum CodingKeys: String, CodingKey {
        case idLK = "id_lk"
        case lkNumber = "lk_number"
        case lkJenis = "lk_jenis"
        case lkVarian = "lk_varian"
        case lkDate = "lk_date"
        case lkEngineer = "lk_engineer"
        case lkAssign = "lk_assign"
        case idAsset = "id_asset"
        case lkLabel = "lk_label"
        case lkInfo = "lk_info"
        case lkStatus = "lk_status"
        case lkFinishstt = "lk_finishstt"
        case lkWebenable = "lk_webenable"
        case lkStart = "lk_start"
        case lkFinish = "lk_finish"
        case lkContinue = "lk_continue"
        case lkDurasireal = "lk_durasireal"
        case lkRating = "lk_rating"
        case createBy = "create_by"
        case approveBy = "approve_by"
        case rateBy = "rate_by"
        case createAt = "create_at"
        case expired
        case lkGeneralflag = "lk_generalflag"
        case extra
        case txtJenis
        case txtStatus
        case txtFinishStatus
        case txtEngineerName
        case dateText = "date_text"
        case assetImage = "assetimage"
        case assetName = "assetname"
        case brandName = "brandname"
        case typeName = "typename"
        case serial
        case instalasi
        case ruangan
        case isPendamping
        case canPendamping
        case infoLk
        case namaPerating
    }
}

struct InfoLK: Codable {
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

struct ReffLK: Codable {
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

struct WorkSheetListEntity: Codable {
    let id: String?
    let uniqueNumber: String?
    let workName: String?
    let workDesc: String?
    let serial: String?
    let installation: String?
    let room: String?
    let dateTime: String?
    let category: WorkSheetCategory?
    let status: WorkSheetStatus?
}

// MARK: - DUMMY DATA
let workSheetData: [WorkSheetListEntity] = [
    WorkSheetListEntity(
        id: "1",
        uniqueNumber: "LK.2021.11.PI010",
        workName: "Syringe Pump",
        workDesc: "Pelayanan Bedah Sentral (OK) - Ruangan Persia",
        serial: "72385234",
        installation: "Pelayanan Gawat Darurat",
        room: "Ruangan Triase(auto-room)",
        dateTime: "2024-02-06 12:13:06",
        category: .calibration,
        status: .done),
    WorkSheetListEntity(
        id: "2",
        uniqueNumber: "LK.2021.11.PI010",
        workName: "Bed-side Monitor / Bed-patient Monitor / Patient Monit...",
        workDesc: "Pelayanan Bedah Sentral (OK) - Ruangan Persia",
        serial: "72385234",
        installation: "Pelayanan Gawat Darurat",
        room: "Ruangan Triase(auto-room)",
        dateTime: "2024-02-06 12:13:06",
        category: .preventive,
        status: .open),
    WorkSheetListEntity(
        id: "3",
        uniqueNumber: "LK.2021.11.PI010",
        workName: "X-Ray Film Viewer",
        workDesc: "Pelayanan Rawat Inap - Ruangan Persia",
        serial: "72385234",
        installation: "Pelayanan Gawat Darurat",
        room: "Ruangan Triase(auto-room)",
        dateTime: "2024-02-06 12:13:06",
        category: .corrective,
        status: .done),
    WorkSheetListEntity(
        id: "4",
        uniqueNumber: "LK.2021.11.PI010",
        workName: "LK.2021.11.PI010",
        workDesc: "Pelayanan Bedah Sentral (OK) - Ruangan Persia",
        serial: "72385234",
        installation: "Pelayanan Gawat Darurat",
        room: "Ruangan Triase(auto-room)",
        dateTime: "2024-02-06 12:13:06",
        category: .preventive,
        status: .open),
    WorkSheetListEntity(
        id: "5",
        uniqueNumber: "LK.2021.11.PI010",
        workName: "Ventilitator",
        workDesc: "No#666787 - Pelayanan Bedah Sentral (OK) - Ruangan Persia",
        serial: "72385234",
        installation: "Pelayanan Gawat Darurat",
        room: "Ruangan Triase(auto-room)",
        dateTime: "2024-02-06 12:13:06",
        category: .corrective,
        status: .ongoing),
    WorkSheetListEntity(
        id: "6",
        uniqueNumber: "LK.2021.11.PI010",
        workName: "Bronchoscope and Accessories",
        workDesc: "Pelayanan Rawat Inap - Ruangan Persia",
        serial: "72385234",
        installation: "Pelayanan Gawat Darurat",
        room: "Ruangan Triase(auto-room)",
        dateTime: "2024-02-06 12:13:06",
        category: .corrective,
        status: .open),
    WorkSheetListEntity(
        id: "7",
        uniqueNumber: "LK.2021.11.PI010",
        workName: "Tensimeter",
        workDesc: "No#666787 - Pelayanan Bedah Sentral (OK) - Ruangan Persia",
        serial: "72385234",
        installation: "Pelayanan Gawat Darurat",
        room: "Ruangan Triase(auto-room)",
        dateTime: "2024-02-06 12:13:06",
        category: .calibration,
        status: .ongoing)
]
