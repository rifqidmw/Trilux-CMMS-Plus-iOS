//
//  ScanEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/02/24.
//

import Foundation

enum ScanType {
    case asset
    case preventive
}

struct QRProperties: Codable {
    let id: String?
    let coders: String?
    let codenom: String?
    
    enum CodingKeys: CodingKey {
        case id
        case coders
        case codenom
    }
}

struct ScanEquipmentEntity: Codable {
    let count: Int?
    let data: ScanEquipmentData?
    let message: String?
    let status: Int?
    let reff: [String: String]?
    
    enum CodingKeys: CodingKey {
        case count
        case data
        case message
        case status
        case reff
    }
}

struct ScanEquipmentData: Codable {
    let equipment: ScanEquipment?
    
    enum CodingKeys: CodingKey {
        case equipment
    }
}

struct ScanEquipment: Codable {
    let id: Int?
    let txtName: String?
    let valImage: String?
    let valQR: String?
    let valQRProperties: QRProperties?
    let txtRuangan: String?
    let valRoomId: Int?
    let txtRoomId: String?
    let txtSubRuangan: String?
    let txtLokasiName: String?
    let txtSerial: String?
    let txtBrand: String?
    let txtType: String?
    let txtInventaris: String?
    let txtTahun: String?
    let txtDescriptions: String?
    let txtLastWoStatus: String?
    let badgeAsset: String?
    let badgeTeknis: String?
    let txtUsiaTeknis: String?
    let txtDistributor: String?
    let syncSimak: String?
    let codeSimak: String?
    let nameSimak: String?
    let syncSimbada: String?
    let codeSimbada: String?
    let nameSimbada: String?
    let syncAspak: String?
    let statusKalibrasi: KalibrasiStatus?
    let stt_qr: String?
    let txtLokasiInstalasi: String?
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
        case valQRProperties
        case txtRuangan
        case valRoomId
        case txtRoomId
        case txtSubRuangan
        case txtLokasiName
        case txtSerial
        case txtBrand
        case txtType
        case txtInventaris
        case txtTahun
        case txtDescriptions
        case txtLastWoStatus
        case badgeAsset
        case badgeTeknis
        case txtUsiaTeknis
        case txtDistributor
        case syncSimak
        case codeSimak
        case nameSimak
        case syncSimbada
        case codeSimbada
        case nameSimbada
        case syncAspak
        case statusKalibrasi
        case stt_qr
        case txtLokasiInstalasi
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

struct KalibrasiStatus: Codable {
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
