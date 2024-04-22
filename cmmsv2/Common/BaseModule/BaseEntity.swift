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
    case done = "Selesai, Bisa digunakan Kembali"
    case open = "Open"
    case ongoing = "Dalam Proses Pengerjaan"
    case hold = "Tunda Perbaikan"
    case close = "Closed"
    case removed = "Tidak Bisa diperbaiki, Usulkan Penghapusan"
    case progressDelay = "Progress(Delay)"
    case progress = "Progress"
    case none = ""
    
    init?(rawValue: String) {
        switch rawValue {
        case "Selesai, Bisa digunakan Kembali": self = .done
        case "Open": self = .open
        case "Dalam Proses Pengerjaan": self = .ongoing
        case "Tunda Perbaikan": self = .hold
        case "Closed": self = .close
        case "Tidak Bisa diperbaiki, Usulkan Penghapusan": self = .removed
        case "Progress(Delay)": self = .progressDelay
        case "Progress": self = .progress
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

enum NotificationType: String, Codable {
    case complaint = "Pengaduan"
    case worksheet = "Lembar Kerja"
    case rating = "Rating"
    case approveWorkSheet = "Approve Lembar Kerja"
    case inbox = "Inbox"
    case reception = "Penerimaan"
    case mutation = "Mutasi Alat"
    case none = ""
    
    init?(rawValue: String) {
        switch rawValue {
        case "Pengaduan": self = .complaint
        case "Lembar Kerja": self = .worksheet
        case "Rating": self = .rating
        case "Approve Lembar Kerja": self = .approveWorkSheet
        case "Inbox": self = .inbox
        case "Penerimaan": self = .rating
        case "Mutasi Alat": self = .mutation
        case "": self = .none
        default: self = .none
        }
    }
    
    func getStringValue() -> String {
        return rawValue
    }
}

enum HistoryStatusType: String, Codable {
    case done = "Selesai, Bisa digunakan kembali"
    case removed = "Tidak Bisa diperbaiki, Usulkan Penghapusan"
    case hold = "Tunda Perbaikan"
    case none = ""
    
    init?(rawValue: String) {
        switch rawValue {
        case "Selesai, Bisa digunakan kembali": self = .done
        case "idak Bisa diperbaiki, Usulkan Penghapusan": self = .removed
        case "Tunda Perbaikan": self = .hold
        case "": self = .none
        default: self = .none
        }
    }
    
    func getStringValue() -> String {
        return rawValue
    }
}

enum CellType {
    case calibration
    case preventiveMaintenance
    case history
    case functionMonitoringWorksheet
    case correctiveWorksheet
    case preventiveMaintenanceWorksheet
    case calibrationWorksheet
    case corrective
    case delayCorrective
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
    let brandName: String?
    let category: WorkSheetCategory?
    let status: WorkSheetStatus?
}

struct WorkSheetEntity: Codable {
    let data: [WorkSheetData]?
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

struct WorkSheetData: Codable {
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

