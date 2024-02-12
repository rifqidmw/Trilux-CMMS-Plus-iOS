//
//  MedicAssetListEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/02/24.
//

import Foundation

struct MedicAssetListEntity: Codable {
    let id: String?
    let date: String?
    let assetImage: String?
    let assetName: String?
    let category: WorkSheetCategory?
    let assetCategory: StatusKalibrasi?
    let isAsset: Bool?
    let price: String?
}

struct EquipmentEntity: Codable {
    let count: Int?
    let data: EquipmentData?
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

struct EquipmentData: Codable {
    let equipments: [Equipment]?
    
    enum CodingKeys: CodingKey {
        case equipments
    }
}

struct ReffData: Codable {
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

struct Equipment: Codable {
    let id: String?
    let txtName: String?
    let valImage: String?
    let valQR: String?
    let txtRuangan: String?
    let valRoomId: String?
    let txtRoomId: String?
    let txtSubRuangan: String?
    let txtLokasiName: String?
    let txtSerial: String?
    let txtBrand: String?
    let txtType: String?
    let txtInventaris: String?
    let badgeAsset: String?
    let badgeTeknis: String?
    let statusKalibrasi: StatusKalibrasi?
    let stt_qr: String?
    let valRusak: Int?
    let txtRusak: String?
    let valKalibrasi: Int?
    let txtKalibrasi: String?
    let valKorektif: Int?
    let txtKorektif: String?
    let valPreventif: Int?
    let txtPreventif: String?
    let valIsComplainable: Int?
    let txtCantComplainReason: String?
    let txtInfoUpdate: String?
    
    enum CodingKeys: CodingKey {
        case id
        case txtName
        case valImage
        case valQR
        case txtRuangan
        case valRoomId
        case txtRoomId
        case txtSubRuangan
        case txtLokasiName
        case txtSerial
        case txtBrand
        case txtType
        case txtInventaris
        case badgeAsset
        case badgeTeknis
        case statusKalibrasi
        case stt_qr
        case valRusak
        case txtRusak
        case valKalibrasi
        case txtKalibrasi
        case valKorektif
        case txtKorektif
        case valPreventif
        case txtPreventif
        case valIsComplainable
        case txtCantComplainReason
        case txtInfoUpdate
    }
}

struct StatusKalibrasi: Codable {
    let last: String?
    let next: String?
    let exp: String?
    let color: String?
    
    enum CodingKeys: CodingKey {
        case last
        case next
        case exp
        case color
    }
}
