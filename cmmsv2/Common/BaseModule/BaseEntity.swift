//
//  BaseEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import Foundation

enum PreparationStatusType: String, Codable {
    case yes = "Ya"
    case no = "Tidak"
    case pass = "Pass"
    case none = ""
    
    init?(rawValue: String) {
        switch rawValue {
        case "Ya": self = .yes
        case "Tidak": self = .no
        case "Pass": self = .pass
        case "": self = .none
        default: self = .none
        }
    }
    
    func getStringValue() -> String {
        return rawValue
    }
}

enum WorkSheetFinishStatus: String, Codable {
    case done = "Selesai"
    case needSparePart = "Membutuhkan Suku Cadang"
    case none = ""
    
    init?(rawValue: String) {
        switch rawValue {
        case "Selesai": self = .done
        case "Membutuhkan Suku Cadang": self = .needSparePart
        case "": self = .none
        default: self = .none
        }
    }
    
    func getStringValue() -> String {
        return rawValue
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
    case draft = "Draft"
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
        case "Draft": self = .draft
        case "": self = .none
        default: self = .none
        }
    }
    
    func getStringValue() -> String {
        return rawValue
    }
}

enum MessageStatusType: String, Codable {
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

enum MonitoringStatusType: String, Codable {
    case good = "Baik"
    case cross = "X"
    case strips = "-"
    case none = ""
    
    init?(rawValue: String) {
        switch rawValue {
        case "Baik": self = .good
        case "X": self = .cross
        case "-": self = .strips
        case "": self = .none
        default: self = .none
        }
    }
    
    func getStringValue() -> String {
        return rawValue
    }
}

enum LoadPreventiveStatus: String, Codable {
    case scheduling = "Penjadwalan"
    case planning = "Perencanaan"
    case none = ""
    
    init?(rawValue: String) {
        switch rawValue {
        case "Penjadwalan": self = .scheduling
        case "Perencanaan": self = .planning
        case "": self = .none
        default: self = .none
        }
    }
    
    func getStringValue() -> String {
        return rawValue
    }
}

enum FilterStatusType: String, Codable {
    case all = "Semua"
    case open = "Open"
    case closed = "Closed"
    case progress = "Progress"
    case finish = "Finish"
    case rated = "Rated"
    case approved = "Approved"
    case delay = "Delay"
    case failed = "Failed"
    case none = ""
    
    init?(rawValue: String) {
        switch rawValue {
        case "Semua": self = .all
        case "Open": self = .open
        case "Closed": self = .closed
        case "Progress": self = .progress
        case "Finish": self = .finish
        case "Rated": self = .rated
        case "Approved": self = .approved
        case "Delay": self = .delay
        case "Failed": self = .failed
        case "": self = .none
        default: self = .none
        }
    }
    
    func getStringValue() -> String {
        return rawValue
    }
}

struct StatusFilterEntity: Codable {
    let id: String?
    let status: FilterStatusType?
}

struct SortingEntity: Codable {
    var id: String?
    var sortType: SortingType?
    var hasObstacle: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case sortType = "sort_type"
        case hasObstacle = "has_obstacle"
    }
    
    init(id: String? = nil, sortType: SortingType? = nil, hasObstacle: Int? = nil) {
        self.id = id
        self.sortType = sortType
        self.hasObstacle = hasObstacle
    }
}

enum SortingType: String, Codable {
    case all = "Semua"
    case delay = "Riwayat Korektif Terkendala"
    case done = "Riwayat Korektif Terselesaikan"
    case hold = "Tunda Perbaikan"
    case latest = "Terbaru"
    case longest = "Terlama"
    case open = "Open"
    case progress = "Progress"
    case rated = "Selesai/Rating"
    case approve = "Approve"
    case finish = "Finish"
    case medic = "Medic"
    case equipment = "Perlengkapan"
    case none = ""
    
    init?(rawValue: String) {
        switch rawValue {
        case "Semua": self = .all
        case "Riwayat Korektif Terkendala": self = .delay
        case "Riwayat Korektif Terselesaikan": self = .done
        case "Tunda Perbaikan": self = .hold
        case "Terbaru": self = .latest
        case "Terlama": self = .longest
        case "Open": self = .open
        case "Progress": self = .progress
        case "Selesai/Rating": self = .rated
        case "Approve": self = .approve
        case "Finish": self = .finish
        case "Medic": self = .medic
        case "Perlengkapan": self = .equipment
        case "": self = .none
        default: self = .none
        }
    }
    
    func getStringValue() -> String {
        return rawValue
    }
}

struct AssetConditionEntity: Codable {
    var id: String?
    var assetCondition: AssetConditionType?
}

struct CalibrationConditionEntity: Codable {
    var id: String?
    var calibrationCondition: StatusCalibrationConditionType?
}

enum AssetConditionType: String, Codable {
    case all = "Semua Kondisi"
    case good = "Baik"
    case notOperated = "Tidak Beroprasi"
    case damaged = "Rusak"
    case badlyDamaged = "Rusak Berat"
    case none = ""
    
    init?(rawValue: String) {
        switch rawValue {
        case "Semua Kondisi": self = .all
        case "Baik": self = .good
        case "Rusak": self = .damaged
        case "Rusak Berat": self = .badlyDamaged
        case "Terbaru": self = .badlyDamaged
        case "": self = .none
        default: self = .none
        }
    }
    
    func getStringValue() -> String {
        return rawValue
    }
}

enum StatusCalibrationConditionType: String, Codable {
    case all = "Semua Status Kalibrasi"
    case laik = "Laik"
    case unlaik = "Tidak Laik"
    case none = ""
    
    init?(rawValue: String) {
        switch rawValue {
        case "Semua Status Kalibrasi": self = .all
        case "Laik": self = .laik
        case "Tidak Laik": self = .unlaik
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
    var idLK: String? = nil
    var idAsset: String? = nil
    let serialNumber: String?
    let title: String?
    let description: String?
    let room: String?
    let installation: String?
    let dateTime: String?
    let brandName: String?
    let lkNumber: String?
    let lkStatus: String?
    let category: WorkSheetCategory?
    let status: WorkSheetStatus?
    
    init(idLK: String? = nil, idAsset: String? = nil, serialNumber: String? = nil, title: String? = nil, description: String? = nil, room: String? = nil, installation: String? = nil, dateTime: String? = nil, brandName: String? = nil, lkNumber: String? = nil, lkStatus: String? = nil, category: WorkSheetCategory? = WorkSheetCategory.none, status: WorkSheetStatus? = WorkSheetStatus.none) {
        self.idLK = idLK
        self.idAsset = idAsset
        self.serialNumber = serialNumber
        self.title = title
        self.description = description
        self.room = room
        self.installation = installation
        self.dateTime = dateTime
        self.brandName = brandName
        self.lkNumber = lkNumber
        self.lkStatus = lkStatus
        self.category = category
        self.status = status
    }
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
