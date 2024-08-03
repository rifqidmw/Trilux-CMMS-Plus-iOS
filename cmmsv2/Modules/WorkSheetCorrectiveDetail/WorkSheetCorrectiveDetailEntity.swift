//
//  WorkSheetCorrectiveDetailEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/05/24.
//

import Foundation

struct WorkSheetCorrectiveDetailEntity: Codable {
    let count: Int?
    let data: WorkSheetCorrectiveDetailData?
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

struct WorkSheetCorrectiveDetailData: Codable {
    let complain: WorkSheetCorrectiveComplaint?
    
    enum CodingKeys: CodingKey {
        case complain
    }
}

struct WorkSheetCorrectiveComplaint: Codable {
    let id: Int?
    let txtTitle: String?
    let txtDescriptions: String?
    let txtStatus: String?
    let valStatus: String?
    let txtSenderName: String?
    let valSenderImg: String?
    let equipment: CorrectiveEquipment?
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
    let infoLk: InfoLk?
    let canDeleteLk: Bool?
    let idLkActive: String?
    let namaPelapor: String?
    
    enum CodingKeys: String, CodingKey {
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
        case namaPelapor
    }
}

struct CorrectiveEquipment: Codable {
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
    let sttQR: String?
    let txtLokasiInstalasi: String?
    let idAlat: String?
    let isNonmedik: String?
    let lkStatic: String?
    let klpNonmedik: String?
    let klpNonmedikName: String?
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
    
    enum CodingKeys: String, CodingKey {
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
        case sttQR = "stt_qr"
        case txtLokasiInstalasi
        case idAlat = "id_alat"
        case isNonmedik
        case lkStatic = "lk_static"
        case klpNonmedik = "klp_nonmedik"
        case klpNonmedikName = "klp_nonmedik_name"
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

// MARK: - EQUIPMENT ENTITY EXTENSION FOR NAVIGATE TO DETAIL
extension Equipment {
    init(from workOrder: CorrectiveEquipment) {
        self.id = String(workOrder.id ?? 0)
        self.txtName = workOrder.txtName ?? ""
        self.valImage = workOrder.valImage ?? ""
        self.valQR = workOrder.valQR ?? ""
        self.txtRuangan = workOrder.txtRuangan ?? ""
        self.valRoomId = String(workOrder.valRoomId ?? 0)
        self.txtRoomId = workOrder.txtRoomId ?? ""
        self.txtSubRuangan = workOrder.txtSubRuangan ?? ""
        self.txtLokasiName = workOrder.txtLokasiName ?? ""
        self.txtSerial = workOrder.txtSerial ?? ""
        self.txtBrand = workOrder.txtBrand ?? ""
        self.txtType = workOrder.txtType ?? ""
        self.txtInventaris = workOrder.txtInventaris ?? ""
        self.badgeAsset = workOrder.badgeAsset ?? ""
        self.badgeTeknis = workOrder.badgeTeknis ?? ""
        self.statusKalibrasi = workOrder.statusKalibrasi
        self.stt_qr = workOrder.sttQR ?? ""
        self.valRusak = workOrder.valRusak ?? 0
        self.txtRusak = workOrder.txtRusak ?? ""
        self.valKalibrasi = workOrder.valKalibrasi ?? 0
        self.txtKalibrasi = workOrder.txtKalibrasi ?? ""
        self.valKorektif = workOrder.valKorektif ?? 0
        self.txtKorektif = workOrder.txtKorektif ?? ""
        self.valPreventif = workOrder.valPreventif ?? 0
        self.txtPreventif = workOrder.txtPreventif ?? ""
        self.valIsComplainable = workOrder.valIsComplainable ?? 0
        self.txtCantComplainReason = workOrder.txtCantComplainReason ?? ""
        self.txtInfoUpdate = workOrder.txtInfoUpdate ?? ""
    }
}
