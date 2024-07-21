//
//  LoadPreventiveEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 29/05/24.
//

import Foundation

struct LoadPreventiveEntity: Codable {
    let data: LoadPreventiveData?
    let message: String?
    let status: Int?
}

struct LoadPreventiveData: Codable {
    let list: [LoadPreventiveList]?
    let action: LoadPreventiveList?
    let asset: LoadPreventiveAsset?
}

struct LoadPreventiveList: Codable {
    let idLK, lkNumber, lkJenis, lkVarian: String?
    let lkDate, lkEngineer, lkAssign, idAsset: String?
    let lkLabel, lkInfo, lkStatus, lkFinishstt: String?
    let lkWebenable: String?
    let lkStart, lkFinish, lkContinue, lkDurasireal: String?
    let lkRating, createBy, approveBy, rateBy: String?
    let createAt, expired, lkGeneralflag, extra: String?
    let dateText, btnText, color, colorText: String?
    
    enum CodingKeys: String, CodingKey {
        case idLK = "id_lk"
        case lkNumber = "lk_number"
        case lkJenis = "lk_jenis"
        case lkVarian = "lk_varian"
        case lkDate = "lk_date"
        case lkEngineer = "lk_engineer"
        case lkAssign = "lk_assign"
        case idAsset = "id_asset"
        case lkLabel = "lk_label"
        case lkInfo = "lk_info"
        case lkStatus = "lk_status"
        case lkFinishstt = "lk_finishstt"
        case lkWebenable = "lk_webenable"
        case lkStart = "lk_start"
        case lkFinish = "lk_finish"
        case lkContinue = "lk_continue"
        case lkDurasireal = "lk_durasireal"
        case lkRating = "lk_rating"
        case createBy = "create_by"
        case approveBy = "approve_by"
        case rateBy = "rate_by"
        case createAt = "create_at"
        case expired = "expired"
        case lkGeneralflag = "lk_generalflag"
        case extra = "extra"
        case dateText = "date_text"
        case btnText = "btn_text"
        case color = "color"
        case colorText = "color_text"
    }
}

struct LoadPreventiveAsset: Codable {
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
        case txtName = "txtName"
        case valImage = "valImage"
        case valQR = "valQR"
        case valQRProperties = "valQRProperties"
        case txtRuangan = "txtRuangan"
        case valRoomId = "valRoomId"
        case txtRoomId = "txtRoomId"
        case txtSubRuangan = "txtSubRuangan"
        case txtLokasiName = "txtLokasiName"
        case txtSerial = "txtSerial"
        case txtBrand = "txtBrand"
        case txtType = "txtType"
        case txtInventaris = "txtInventaris"
        case txtTahun = "txtTahun"
        case txtDescriptions = "txtDescriptions"
        case txtLastWoStatus = "txtLastWoStatus"
        case badgeAsset = "badgeAsset"
        case badgeTeknis = "badgeTeknis"
        case txtUsiaTeknis = "txtUsiaTeknis"
        case txtDistributor = "txtDistributor"
        case syncSimak = "syncSimak"
        case codeSimak = "codeSimak"
        case nameSimak = "nameSimak"
        case syncSimbada = "syncSimbada"
        case codeSimbada = "codeSimbada"
        case nameSimbada = "nameSimbada"
        case syncAspak = "syncAspak"
        case statusKalibrasi = "statusKalibrasi"
        case sttQR = "stt_qr"
        case txtLokasiInstalasi = "txtLokasiInstalasi"
        case idAlat = "id_alat"
        case isNonmedik = "is_nonmedik"
        case lkStatic = "lk_static"
        case klpNonmedik = "klp_nonmedik"
        case klpNonmedikName = "klp_nonmedik_name"
        case valRusak = "valRusak"
        case txtRusak = "txtRusak"
        case valKalibrasi = "valKalibrasi"
        case txtKalibrasi = "txtKalibrasi"
        case valKorektif = "valKorektif"
        case txtKorektif = "txtKorektif"
        case valPreventif = "valPreventif"
        case txtPreventif = "txtPreventif"
        case valIsComplainable = "valIsComplainable"
        case txtCantComplainReason = "txtCantComplainReason"
        case txtInfoUpdate = "txtInfoUpdate"
    }
}

struct CreatePreventiveRequest: Codable {
    let idAsset: String?
    let varian: String?
    let date: String?
    
    enum CodingKeys: String, CodingKey {
        case idAsset = "id_asset"
        case varian = "varian"
        case date = "date"
    }
}

struct CreatePreventiveEntity: Codable {
    let data: CreatePreventiveData?
    let message: String?
    let status: Int?
}

struct CreatePreventiveData: Codable {
    let idLk: String?
    
    enum CodingKeys: String, CodingKey {
        case idLk = "id_lk"
    }
}
