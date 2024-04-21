//
//  WorkSheetCorrectiveEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/03/24.
//

import Foundation

struct WorkSheetCorrectiveListEntity: Codable {
    let count: Int?
    let data: WorkOrderData?
    let message: String?
    let status: Int?
    let reff: WorkOrderReff?
    
    enum CodingKeys: CodingKey {
        case count
        case data
        case message
        case status
        case reff
    }
}

struct WorkOrderData: Codable {
    let wo: [WorkOrder]?
    
    enum CodingKeys: CodingKey {
        case wo
    }
}

struct WorkOrder: Codable {
    let id: Int?
    let valWoNumber: String?
    let valDate: String?
    let txtEngineerName: String?
    let valEngineerId: Int?
    let valEngineerAvatar: String?
    let txtType: String?
    let valType: String?
    let complain: WorkOrderComplaint?
    let txtHeader: String?
    let txtTitle: String?
    let txtSubTitle: String?
    let valIcon: Icon?
    let valEquipmentId: String?
    let valStartTime: String?
    let valEndTime: String?
    let valDuration: String?
    let valStatus: Int?
    let txtStatus: String?
    let valIsManagable: Bool?
    let valIsDoable: Int?
    let valRating: Int?
    let medias: [Media]?
    let valCanRating: Int?
    let valDelegatedTime: String?
    let txtFinishStatus: String?
    let isPendamping: String?
    let approveBy: String?
    let canPendamping: String?
    let infoLk: InfoLK?
    let stt_qr: String?
    let txtRuangan: String?
    let txtLokasiName: String?
    let nama_perating: String?
    
    enum CodingKeys: CodingKey {
        case id
        case valWoNumber
        case valDate
        case txtEngineerName
        case valEngineerId
        case valEngineerAvatar
        case txtType
        case valType
        case complain
        case txtHeader
        case txtTitle
        case txtSubTitle
        case valIcon
        case valEquipmentId
        case valStartTime
        case valEndTime
        case valDuration
        case valStatus
        case txtStatus
        case valIsManagable
        case valIsDoable
        case valRating
        case medias
        case valCanRating
        case valDelegatedTime
        case txtFinishStatus
        case isPendamping
        case approveBy
        case canPendamping
        case infoLk
        case stt_qr
        case txtRuangan
        case txtLokasiName
        case nama_perating
    }
}

struct WorkOrderComplaint: Codable {
    let id: Int?
    let txtTitle: String?
    let txtDescriptions: String?
    let txtStatus: String?
    let valStatus: String?
    let txtSenderName: String?
    let valSenderImg: String?
    let equipment: WorkOrderEquipment?
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

struct WorkOrderEquipment: Codable {
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

struct WoList: Codable {
    let id: String?
    let lkNumber: String?
    let lkDate: String?
    let engineerName: String?
    let valStatus: String?
    let statusText: String?
    
    enum CodingKeys: CodingKey {
        case id
        case lkNumber
        case lkDate
        case engineerName
        case valStatus
        case statusText
    }
}

struct Media: Codable {
    let id: String?
    let valUrl: String?
    let valThumburl: String?
    
    enum CodingKeys: CodingKey {
        case id
        case valUrl
        case valThumburl
    }
}

struct Icon: Codable {
    let bg: String?
    let fo: String?
    let lbl: String?
    
    enum CodingKeys: CodingKey {
        case bg
        case fo
        case lbl
    }
}

struct WorkOrderReff: Codable {
    let page: String?
    let pageSize: String?
    let totalPage: String?
    let totalItem: String?
}
