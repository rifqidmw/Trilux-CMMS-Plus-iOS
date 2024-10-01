//
//  RatingListEntity.swift
//  cmmsv2
//
//  Created by macbook  on 01/10/24.
//

import Foundation

struct RatingListEntity: Codable {
    let count: Int?
    let data: RatingListData?
    let message: String?
    let status: Int?
    let reff: ReffData?
}

struct RatingListData: Codable {
    let wo: [RatingData]?
}

struct RatingData: Codable {
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
    let sttQr: String?
    let txtRuangan: String?
    let txtLokasiName: String?
    let namaPerating: String?
    
    enum CodingKeys: String, CodingKey {
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
        case infoLk = "infoLk"
        case sttQr = "stt_qr"
        case txtRuangan
        case txtLokasiName
        case namaPerating = "nama_perating"
    }
}
