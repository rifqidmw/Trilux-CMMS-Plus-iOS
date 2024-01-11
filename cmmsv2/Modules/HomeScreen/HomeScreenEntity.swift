// 
//  HomeScreenEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/01/24.
//

import Foundation

protocol HomeScreenCategoryDelegate: AnyObject {
    func didTapAllCategory()
    func didTapContract()
    func didTapAsset()
    func didTapAssetMedic()
    func didTapAssetNonMedic()
}

enum MedicAssetBottomSheetType {
    case asset
    case contract
}

struct CategoryModel: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    var isUpdated: Bool = false
}

struct MedicAssetModel: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let subTitle: String
}

let categoryData: [CategoryModel] = [
    CategoryModel(image: "ic_sitemap", title: "Lihat Semua Kategori"),
    CategoryModel(image: "ic_chest_board", title: "Kontrak"),
    CategoryModel(image: "ic_hospital", title: "Aset"),
    CategoryModel(image: "ic_stethoscope", title: "Data Aset Medik", isUpdated: true),
    CategoryModel(image: "ic_wheel_chair", title: "Data Aset Non Medik", isUpdated: true)
]

let allCategoryData: [CategoryModel] = [
    CategoryModel(image: "ic_sitemap", title: "Lihat Semua Kategori"),
    CategoryModel(image: "ic_chest_board", title: "Kontrak"),
    CategoryModel(image: "ic_hospital", title: "Aset"),
    CategoryModel(image: "ic_stethoscope", title: "Data Aset Medik", isUpdated: true),
    CategoryModel(image: "ic_wheel_chair", title: "Data Aset Non Medik", isUpdated: true),
    CategoryModel(image: "ic_printer", title: "Print Label Ruangan"),
    CategoryModel(image: "ic_bubble_chat", title: "Usulan Alat")
]

let medicAssetData: [MedicAssetModel] = [
    MedicAssetModel(image: "ic_wheel_chair_fill", title: "Medik", subTitle: "Tambah data aset medik"),
    MedicAssetModel(image: "ic_stethoscope_fill", title: "Non-Medik", subTitle: "Tambah data aset non medik")
]

let detailInformationData: [CategoryModel] = [
    CategoryModel(image: "ic_hospital", title: "Update Data Aset", isUpdated: true),
    CategoryModel(image: "ic_hospital", title: "Detail Aset"),
    CategoryModel(image: "ic_calendar", title: "Informasi Penerimaan"),
    CategoryModel(image: "ic_printer", title: "Print Label Ruangan")
]
