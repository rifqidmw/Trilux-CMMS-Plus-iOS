// 
//  HomeScreenEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/01/24.
//

import Foundation

protocol HomeScreenCategoryDelegate: AnyObject {
    func didTapAllCategory()
    func didTapAsset()
    func didTapComplaint()
    func didTapWorkSheet()
    func didTapPreventiveMaintenance()
    func didTapCalibration()
    func didTapHistory()
    func didTapLogBook()
    func didTapToolSuggestions()
    func didTapPreventiveCalendar()
}

protocol WorkSheetBottomSheetDelegate: AnyObject {
    func didTapWorkSheetList()
    func didTapWorkSheetOnsitePreventive()
    func didTapWorkSheetCorrective()
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
    CategoryModel(image: "ic_bubble_chat_with_gear", title: "Pemeliharaan Preventif"),
    CategoryModel(image: "ic_speedometer", title: "Kalibrasi"),
    CategoryModel(image: "ic_calendar_with_stopwatch", title: "Riwayat")
]

let allCategoryData: [CategoryModel] = [
    CategoryModel(image: "ic_hospital", title: "Aset"),
    CategoryModel(image: "ic_notes_with_pencil", title: "Pengaduan"),
    CategoryModel(image: "ic_bill", title: "Lembar Kerja"),
    CategoryModel(image: "ic_bubble_chat_with_gear", title: "Pemeliharaan Preventif"),
    CategoryModel(image: "ic_speedometer", title: "Kalibrasi"),
    CategoryModel(image: "ic_calendar_with_stopwatch", title: "Riwayat"),
    CategoryModel(image: "ic_gear_clock", title: "Korektif Tertunda"),
    CategoryModel(image: "ic_log_book", title: "Log Book"),
    CategoryModel(image: "ic_bubble_chat", title: "Usulan Alat"),
    CategoryModel(image: "ic_calendar_with_wrench", title: "Kalender Preventif")
    
]

let assetData: [MenuModel] = [
    MenuModel(image: "ic_wheel_chair_fill", title: "Medik", subTitle: "Tambah data aset medik"),
    MenuModel(image: "ic_stethoscope_fill", title: "Non-Medik", subTitle: "Tambah data aset non medik")
]

let worksheetData: [MenuModel] = [
    MenuModel(image: "ic_bill_fill", title: "Lembar Kerja", subTitle: "Lihat daftar lembar kerja"),
    MenuModel(image: "ic_notes_with_pencil_fill", title: "Lembar Kerja Onsite Preventive", subTitle: "Lihat daftar lembar kerja onsite preventive"),
    MenuModel(image: "ic_notes_with_gear", title: "Lembar Kerja Korektif", subTitle: "Lihat daftar lembar kerja korektif")
]

let detailInformationData: [CategoryModel] = [
    CategoryModel(image: "ic_hospital", title: "Update Data Aset", isUpdated: true),
    CategoryModel(image: "ic_hospital", title: "Detail Aset"),
    CategoryModel(image: "ic_calendar", title: "Informasi Penerimaan"),
    CategoryModel(image: "ic_printer", title: "Print Label Ruangan")
]
