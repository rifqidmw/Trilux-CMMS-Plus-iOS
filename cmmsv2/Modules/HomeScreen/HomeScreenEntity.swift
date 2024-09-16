//
//  HomeScreenEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/01/24.
//

import Foundation
import UIKit

enum ListingType: Int {
    case asset = 0
    case complaint
    case workSheet
    case history
    case delayCorrective
    case logBook
    case preventiveCalendar
}

protocol HomeScreenCategoryDelegate: AnyObject {
    func didTapAllCategory()
    func didTapAssetCategory()
    func didTapComplaintCategory()
    func didTapWorkSheetCategory()
    func didTapHistoryCategory()
    func didTapDelayCorrectiveCategory()
    func didTapLogBookCategory()
    func didTapPreventiveCalendarCategory()
    func didTapMaintenanceCategory()
    func didTapWorkSheetApprovalCategory()
    func didTapComplaintHistoryCategory()
    func didTapMonitoringFunctionCategory()
    func didTapPreventiveCategory()
    func didTapAssetInfoCategory()
    func didTapPrintRoomCategory()
    func didTapMaintenanceInfoCategory()
    func didTapMutationInfoCategory()
    func didTapCalibrationCategory()
    func didTapMutatingCategory()
    func didTapHistoryComplaintListCategory()
    func didTapRoomRequirementCategory()
    func didTapAssetSuggestCategory()
    func didTapRatingCategory()
}

protocol AllCategoriesBottomSheetDelegate: AnyObject {
    func didTapAssetCategory()
    func didTapComplaintCategory()
    func didTapWorkSheetCategory()
    func didTapHistoryCategory()
    func didTapDelayCorrectiveCategory()
    func didTapLogBookCategory()
    func didTapPreventiveCalendarCategory()
    func didTapMaintenanceCategory()
    func didTapWorkSheetApprovalCategory()
    func didTapComplaintHistoryCategory()
    func didTapMonitoringFunctionCategory()
    func didTapPreventiveCategory()
    func didTapAssetInfoCategory()
    func didTapPrintRoomCategory()
    func didTapMaintenanceInfoCategory()
    func didTapMutationInfoCategory()
    func didTapCalibrationCategory()
    func didTapMutatingCategory()
    func didTapComplaintHistoryList()
    func didTapRoomRequirementCategory()
    func didTapAssetSuggestCategory()
    func didTapRatingCategory()
}

protocol WorkSheetBottomSheetDelegate: AnyObject {
    func didTapWorkSheetFunctionMonitoring()
    func didTapWorkSheetCorrective()
    func didTapMaintenancePreventive()
    func didTapCalibration()
}

protocol AssetBottomSheetDelegate: AnyObject {
    func didTapAssetMedic()
    func didTapAssetNonMedic()
}

protocol MutationBottomSheetDelegate: AnyObject {
    func didTapAssetLoan()
    func didTapAssetReturning()
    func didTapMutation()
    func didTapAmprah()
}

struct HomeTheme: Codable {
    let image: String?
    let name: String?
    let hospitalName: String?
    
    enum CodingKeys: CodingKey {
        case image
        case name
        case hospitalName
    }
}

struct ExpiredEntity: Codable {
    let data: ExpiredData
    let message: String
    let status: Int
    
    enum CodingKeys: CodingKey {
        case data
        case message
        case status
    }
}

struct ExpiredData: Codable {
    let isExpired: Int
    let expiredDate: String
    
    enum CodingKeys: String, CodingKey {
        case isExpired = "is_expired"
        case expiredDate = "expired_date"
    }
}

struct CategoryModel: Identifiable {
    let id = UUID()
    let image: String
    let title: CategoryTitle
    var isUpdated: Bool = false
}

struct MenuModel: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let subTitle: String
}

enum CategoryTitle: String {
    case all = "Lihat Semua Kategori"
    case asset = "Aset"
    case complaint = "Pengaduan"
    case workSheet = "Lembar Kerja"
    case history = "Riwayat"
    case delayCorrective = "Korektif Tertunda"
    case logBook = "Log Book"
    case preventiveCalendar = "Kalender Preventif"
    case maintenance = "Pemeliharaan"
    case workSheetApproval = "Persetujuan Lembar Kerja"
    case complaintHistory = "Riwayat Pengaduan"
    case monitoringFunction = "Pemantauan Fungsi"
    case preventive = "Preventif"
    case assetInfo = "Info Aset"
    case printRoom = "Print Label Ruangan"
    case maintenanceInfo = "Info Pemeliharaan"
    case mutationInfo = "Info Mutasi"
    case calibration = "Kalibrasi"
    case mutating = "Perpindahan"
    case historyComplaintList = "Daftar & Riwayat Pengaduan"
    case roomRequirement = "Kebutuhan Ruangan"
    case assetSuggest = "Usulan Alat"
    case rating = "Rating"
    case none = ""
    
    init?(rawValue: String) {
        switch rawValue {
        case "Lihat Semua Kategori": self = .all
        case "Aset": self = .asset
        case "Pengaduan": self = .complaint
        case "Lembar Kerja": self = .workSheet
        case "Riwayat": self = .history
        case "Korektif Tertunda": self = .delayCorrective
        case "Log Book": self = .logBook
        case "Kalender Preventif": self = .preventiveCalendar
        case "Pemeliharaan": self = .maintenance
        case "Persetujuan Lembar Kerja": self = .workSheetApproval
        case "Riwayat Pengaduan": self = .complaintHistory
        case "Pemantauan Fungsi": self = .monitoringFunction
        case "Preventif": self = .preventive
        case "Info Aset": self = .assetInfo
        case "Print Label Ruangan": self = .printRoom
        case "Info Pemeliharaan": self = .maintenanceInfo
        case "Info Mutasi": self = .mutationInfo
        case "Kalibrasi": self = .calibration
        case "Perpindahan": self = .mutating
        case "Daftar & Riwayat Pengaduan": self = .historyComplaintList
        case "Kebutuhan Ruangan": self = .roomRequirement
        case "Usulan Alat": self = .assetSuggest
        case "Rating": self = .rating
        case "": self = .none
        default: self = .none
        }
    }
    
    func getStringValue() -> String {
        return rawValue
    }
}

let categoryDataEngineer: [CategoryModel] = [
    CategoryModel(image: "ic_sitemap", title: .all),
    CategoryModel(image: "ic_hospital", title: .asset),
    CategoryModel(image: "ic_notes_with_pencil", title: .complaint),
    CategoryModel(image: "ic_bill", title: .workSheet),
    CategoryModel(image: "ic_calendar_with_stopwatch", title: .history),
    CategoryModel(image: "ic_gear_clock", title: .delayCorrective),
    CategoryModel(image: "ic_log_book", title: .logBook),
    CategoryModel(image: "ic_calendar_with_wrench", title: .preventiveCalendar)
]

let categoryDataIPSRS: [CategoryModel] = [
    CategoryModel(image: "ic_sitemap", title: .all),
    CategoryModel(image: "ic_hospital", title: .asset),
    CategoryModel(image: "ic_bubble_chat_with_gear", title: .maintenance),
    CategoryModel(image: "ic_document_list_ellipse", title: .workSheetApproval),
    CategoryModel(image: "ic_calendar_with_wrench", title: .preventiveCalendar),
    CategoryModel(image: "ic_calendar_with_stopwatch", title: .complaintHistory),
]

let categoryDataRoom: [CategoryModel] = [
    CategoryModel(image: "ic_sitemap", title: .all),
    CategoryModel(image: "ic_hospital", title: .asset),
    CategoryModel(image: "ic_mutation", title: .mutating),
    CategoryModel(image: "ic_notes_with_pencil", title: .historyComplaintList),
    CategoryModel(image: "ic_calendar_with_wrench", title: .preventiveCalendar),
    CategoryModel(image: "ic_bubble_chat", title: .roomRequirement),
    CategoryModel(image: "ic_bubble_chat", title: .assetSuggest),
    CategoryModel(image: "ic_rating_circle", title: .rating)
]

let categoryBottomSheetEngineerData: [CategoryModel] = [
    CategoryModel(image: "ic_hospital", title: .asset),
    CategoryModel(image: "ic_notes_with_pencil", title: .complaint),
    CategoryModel(image: "ic_bill", title: .workSheet),
    CategoryModel(image: "ic_calendar_with_stopwatch", title: .history),
    CategoryModel(image: "ic_gear_clock", title: .delayCorrective),
    CategoryModel(image: "ic_log_book", title: .logBook),
    CategoryModel(image: "ic_calendar_with_wrench", title: .preventiveCalendar)
]

let categoryBottomSheetIPSRSData: [CategoryModel] = [
    CategoryModel(image: "ic_hospital", title: .asset),
    CategoryModel(image: "ic_bubble_chat_with_gear", title: .maintenance),
    CategoryModel(image: "ic_document_list_ellipse", title: .workSheetApproval),
    CategoryModel(image: "ic_calendar_with_wrench", title: .preventiveCalendar),
    CategoryModel(image: "ic_calendar_with_stopwatch", title: .complaintHistory)
]

let categoryBottomSheetRoomData: [CategoryModel] = [
    CategoryModel(image: "ic_hospital", title: .asset),
    CategoryModel(image: "ic_mutation", title: .mutating),
    CategoryModel(image: "ic_notes_with_pencil", title: .historyComplaintList),
    CategoryModel(image: "ic_calendar_with_wrench", title: .preventiveCalendar),
    CategoryModel(image: "ic_bubble_chat", title: .roomRequirement),
    CategoryModel(image: "ic_bubble_chat", title: .assetSuggest),
    CategoryModel(image: "ic_rating_circle", title: .rating)
]

let assetData: [MenuModel] = [
    MenuModel(image: "ic_wheel_chair_fill", title: "Medik", subTitle: "Tambah data aset medik"),
    MenuModel(image: "ic_stethoscope_fill", title: "Non-Medik", subTitle: "Tambah data aset non medik")
]

let mutationData: [MenuModel] = [
    MenuModel(image: "ic_arrow_direction", title: "Peminjaman Alat", subTitle: "Lihat data peminjaman alat"),
    MenuModel(image: "ic_arrow_rotation", title: "Pengembalian Alat", subTitle: "Lihat data pengembalian alat"),
    MenuModel(image: "ic_arrow_turn_right", title: "Mutasi", subTitle: "Lihat data mutasi"),
    MenuModel(image: "ic_document_download", title: "Amprah", subTitle: "Lihat data amprah")
]

let worksheetData: [MenuModel] = [
    MenuModel(image: "ic_notes_with_pencil_fill", title: "Lembar Kerja Pemantauan Fungsi", subTitle: "Lihat data lembar kerja pemantauan fungsi"),
    MenuModel(image: "ic_notes_with_gear", title: "Lembar Kerja Korektif", subTitle: "Lihat data lembar kerja korektif"),
    MenuModel(image: "ic_notes_with_pencil_outline", title: "Pemeliharaan Preventif", subTitle: "Lihat data pemeliharaan preventif"),
    MenuModel(image: "ic_work_sheet_arrow", title: "Kalibrasi", subTitle: "Lihat data kalibrasi")
]

let detailInformationData: [CategoryModel] = [
    CategoryModel(image: "ic_bill", title: .monitoringFunction),
    CategoryModel(image: "ic_bubble_chat_with_gear", title: .preventive),
    CategoryModel(image: "ic_hospital", title: .assetInfo),
    CategoryModel(image: "ic_printer", title: .printRoom),
    CategoryModel(image: "ic_bubble_chat_with_gear", title: .maintenanceInfo),
    CategoryModel(image: "ic_mutation", title: .mutationInfo),
    CategoryModel(image: "ic_speedometer", title: .calibration)
]

// MARK: - REMINDER PREVENTIVE
struct ReminderPreventiveEntity: Codable {
    let data: [ReminderPreventiveData]?
    let message: String?
    let status: Int?
}

// MARK: - LkData
struct ReminderPreventiveData: Codable {
    let idLk: String?
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
    let assetimage: String?
    let assetname: String?
    let brandname: String?
    let typename: String?
    let serial: String?
    let instalasi: String?
    let ruangan: String?
    let isPendamping: String?
    let canPendamping: String?
    let infoLk: InfoLk?
    let namaPerating: String?
    
    enum CodingKeys: String, CodingKey {
        case idLk = "id_lk"
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
        case assetimage
        case assetname
        case brandname
        case typename
        case serial
        case instalasi
        case ruangan
        case isPendamping
        case canPendamping
        case infoLk
        case namaPerating = "nama_perating"
    }
}

struct DashboardStatisticEntity: Codable {
    let count: Int?
    let data: DashboardStatisticData?
    let message: String?
    let status: Int?
    let reff: [String: String]?
}

struct DashboardStatisticData: Codable {
    let woStatistics: [WOStatistic]?
    
    enum CodingKeys: String, CodingKey {
        case woStatistics = "wo_statistics"
    }
}

struct WOStatistic: Codable {
    let name: String?
    let count: String?
    let action: String?
    let filter: String?
}

let assetStatisticColors: [UIColor] = [
    UIColor.customRedColor,
    UIColor.customDarkYellowColor,
    UIColor.customPrimaryColor,
    UIColor.customDarkGrayColor,
    UIColor.customIndicatorColor13
]
