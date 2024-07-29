//
//  WorkSheetApprovalListEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 30/07/24.
//

import Foundation

struct WorkSheetApprovalListEntity: Codable {
    let count: Int?
    let data: WorkSheetApprovalData?
    let message: String?
    let status: Int?
    let reff: ReffData?
    
    enum CodingKeys: String, CodingKey {
        case count, data, message, status, reff
    }
}

struct WorkSheetApprovalData: Codable {
    let wo: [WorkSheetApproval]?
    
    enum CodingKeys: String, CodingKey {
        case wo
    }
}

struct WorkSheetApproval: Codable {
    let id: Int?
    let valWoNumber: String?
    let valDate: String?
    let txtEngineerName: String?
    let valEngineerId: Int?
    let valEngineerAvatar: String?
    let txtType: String?
    let valType: String?
    let complain: Complain?
    let txtHeader: String?
    let txtTitle: String?
    let txtSubTitle: String?
    let valIcon: ValIcon?
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
    let infoLk: InfoLk?
    let stt_qr: String?
    let txtRuangan: String?
    let txtLokasiName: String?
    let nama_perating: String?
    
    enum CodingKeys: String, CodingKey {
        case id, valWoNumber, valDate, txtEngineerName, valEngineerId, valEngineerAvatar, txtType, valType, complain, txtHeader, txtTitle, txtSubTitle, valIcon, valEquipmentId, valStartTime, valEndTime, valDuration, valStatus, txtStatus, valIsManagable, valIsDoable, valRating, medias, valCanRating, valDelegatedTime, txtFinishStatus, isPendamping, approveBy, canPendamping, infoLk, stt_qr, txtRuangan, txtLokasiName, nama_perating
    }
}

struct ValIcon: Codable {
    let bg: String?
    let fo: String?
    let lbl: String?
    
    enum CodingKeys: String, CodingKey {
        case bg, fo, lbl
    }
}

struct Complain: Codable {
    let id: Int?
    let txtTitle, txtDescriptions, txtStatus, valStatus: String?
    let txtSenderName, valSenderImg: String?
    let equipment: Equipment?
    let txtFinishedDate, txtComplainTime, txtDownTime, txtResponseTime: String?
    let valIsManagable, valObservation, valCorrective: Int?
    let valWoList: [ValWoList]?
    let valDelegatedTime: String?
    let valDelegatable: Bool?
    let medias: [Media]?
    let txtEngineerName, userIDfinish, isDelay, canPendamping: String?
    let infoLk: InfoLk?
    let canDeleteLk: Bool?
    let idLkActive, nama_pelapor: String?
    
    struct Equipment: Codable {
        let id: Int?
        let txtName, valImage, valQR: String?
        let valQRProperties: ValQRProperties?
        let txtRuangan, txtRoomId, txtSubRuangan: String?
        let valRoomId: Int?
        let txtLokasiName, txtSerial, txtBrand, txtType: String?
        let txtInventaris, txtTahun, txtDescriptions, txtLastWoStatus: String?
        let badgeAsset, badgeTeknis, txtUsiaTeknis, txtDistributor: String?
        let syncSimak, codeSimak, nameSimak, syncSimbada: String?
        let codeSimbada, nameSimbada, syncAspak: String?
        let statusKalibrasi: StatusKalibrasi?
        let stt_qr, txtLokasiInstalasi, id_alat, is_nonmedik: String?
        let lk_static, klp_nonmedik, klp_nonmedik_name: String?
        let txtRusak, txtKalibrasi: String?
        let valKalibrasi: Int?
        let valRusak: Int?
        let txtKorektif, txtPreventif: String?
        let valPreventif: Int?
        let valKorektif: Int?
        let txtCantComplainReason, txtInfoUpdate: String?
        let valIsComplainable: Int
        
        struct ValQRProperties: Codable {
            let id, coders, codenom: String?
        }
        
        struct StatusKalibrasi: Codable {
            let last, next, exp, color: String?
        }
    }
    
    struct ValWoList: Codable {
        let id, lkNumber, lkDate, engineerName: String?
        let valStatus, statusText: String?
    }
    
    struct Media: Codable {
        let id: String?
        let valUrl, valThumburl: String?
    }
    
    struct InfoLk: Codable {
        let lkNumber, engineerName, pendampingName: String?
        let idPendamping: [String]?
    }
}
