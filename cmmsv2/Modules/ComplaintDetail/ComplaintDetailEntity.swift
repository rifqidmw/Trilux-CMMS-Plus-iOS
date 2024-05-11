//
//  ComplaintDetailEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/05/24.
//

import Foundation

struct ComplaintDetailEntity: Codable {
    let count: Int?
    let data: ComplaintDetailData?
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

struct ComplaintDetailData: Codable {
    let complain: ComplaintDetail?
    
    enum CodingKeys: CodingKey {
        case complain
    }
}

struct ComplaintDetail: Codable {
    let id: Int?
    let txtTitle: String?
    let txtDescriptions: String?
    let txtStatus: String?
    let valStatus: String?
    let txtSenderName: String?
    let valSenderImg: String?
    let equipment: ComplaintDetailEquipment?
    let txtFinishedDate: String?
    let txtComplainTime: String?
    let txtDownTime: String?
    let txtResponseTime: String?
    let valIsManagable: Int?
    let valObservation: Int?
    let valCorrective: Int?
    let valWoList: [WoList]?
    let valDelegatedTime: String?
    let valDelegatable: Bool?
    let medias: [Media]?
    let txtEngineerName: String?
    let userIDfinish: String?
    let isDelay: String?
    let canPendamping: String?
    let infoLk: InfoLK?
    let canDeleteLk: Bool?
    let idLkActive: String?
    let nama_pelapor: String?
    
    enum CodingKeys: CodingKey {
        case id
        case txtTitle
        case txtDescriptions
        case txtStatus
        case valStatus
        case txtSenderName
        case valSenderImg
        case equipment
        case txtFinishedDate
        case txtComplainTime
        case txtDownTime
        case txtResponseTime
        case valIsManagable
        case valObservation
        case valCorrective
        case valWoList
        case valDelegatedTime
        case valDelegatable
        case medias
        case txtEngineerName
        case userIDfinish
        case isDelay
        case canPendamping
        case infoLk
        case canDeleteLk
        case idLkActive
        case nama_pelapor
    }
}

struct ComplaintDetailEquipment: Codable {
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
    let statusKalibrasi: StatusKalibrasi?
    let stt_qr: String?
    let txtLokasiInstalasi: String?
    let id_alat: String?
    let is_nonmedik: String?
    let lk_static: String?
    let klp_nonmedik: String?
    let klp_nonmedik_name: String?
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
        case id_alat
        case is_nonmedik
        case lk_static
        case klp_nonmedik
        case klp_nonmedik_name
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
