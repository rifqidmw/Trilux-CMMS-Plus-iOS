//
//  HomeScreenEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/01/24.
//

import Foundation

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
    func didTapAsset()
    func didTapComplaint()
    func didTapWorkSheet()
    func didTapHistory()
    func didTapDelayCorrective()
    func didTapLogBook()
    func didTapPreventiveCalendar()
}

protocol AllCategoriesBottomSheetDelegate: AnyObject {
    func didTapAssetCategory()
    func didTapComplaintCategory()
    func didTapWorkSheetCategory()
    func didTapHistoryCategory()
    func didTapDelayCorrectiveCategory()
    func didTapLogBookCategory()
    func didTapPreventiveCalendarCategory()
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
    let title: String
    var isUpdated: Bool = false
}

struct MenuModel: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let subTitle: String
}

let categoryData: [CategoryModel] = [
    CategoryModel(image: "ic_sitemap", title: "Lihat Semua Kategori"),
    CategoryModel(image: "ic_hospital", title: "Aset"),
    CategoryModel(image: "ic_notes_with_pencil", title: "Pengaduan"),
    CategoryModel(image: "ic_bill", title: "Lembar Kerja"),
    CategoryModel(image: "ic_calendar_with_stopwatch", title: "Riwayat"),
    CategoryModel(image: "ic_gear_clock", title: "Korektif Tertunda"),
    CategoryModel(image: "ic_log_book", title: "Log Book"),
    CategoryModel(image: "ic_calendar_with_wrench", title: "Kalender Preventif")
]

let allCategoryData: [CategoryModel] = [
    CategoryModel(image: "ic_hospital", title: "Aset"),
    CategoryModel(image: "ic_notes_with_pencil", title: "Pengaduan"),
    CategoryModel(image: "ic_bill", title: "Lembar Kerja"),
    CategoryModel(image: "ic_calendar_with_stopwatch", title: "Riwayat"),
    CategoryModel(image: "ic_gear_clock", title: "Korektif Tertunda"),
    CategoryModel(image: "ic_log_book", title: "Log Book"),
    CategoryModel(image: "ic_calendar_with_wrench", title: "Kalender Preventif")
    
]

let assetData: [MenuModel] = [
    MenuModel(image: "ic_wheel_chair_fill", title: "Medik", subTitle: "Tambah data aset medik"),
    MenuModel(image: "ic_stethoscope_fill", title: "Non-Medik", subTitle: "Tambah data aset non medik")
]

let worksheetData: [MenuModel] = [
    MenuModel(image: "ic_notes_with_pencil_fill", title: "Lembar Kerja Pemantauan Fungsi", subTitle: "Lihat data lembar kerja pemantauan fungsi"),
    MenuModel(image: "ic_notes_with_gear", title: "Lembar Kerja Korektif", subTitle: "Lihat data lembar kerja korektif"),
    MenuModel(image: "ic_notes_with_pencil_outline", title: "Pemeliharaan Preventif", subTitle: "Lihat data pemeliharaan preventif"),
    MenuModel(image: "ic_work_sheet_arrow", title: "Kalibrasi", subTitle: "Lihat data kalibrasi")
]

let detailInformationData: [CategoryModel] = [
    CategoryModel(image: "ic_bill", title: "Pemantauan Fungsi"),
    CategoryModel(image: "ic_bubble_chat_with_gear", title: "Preventif"),
    CategoryModel(image: "ic_hospital", title: "Info Aset"),
    CategoryModel(image: "ic_printer", title: "Print Label Ruangan"),
    CategoryModel(image: "ic_bubble_chat_with_gear", title: "Info Pemeliharaan"),
    CategoryModel(image: "ic_mutation", title: "Info Mutasi"),
    CategoryModel(image: "ic_speedometer", title: "Kalibrasi")
]
