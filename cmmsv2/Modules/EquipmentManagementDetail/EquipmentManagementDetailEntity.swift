//
//  EquipmentManagementDetailEntity.swift
//  cmmsv2
//
//  Created by macbook  on 16/09/24.
//

import Foundation

struct SubmissionDetailEntity: Codable {
    let data: SubmissionDetailData?
    let message: String?
    let status: Int?
}

struct SubmissionDetailData: Codable {
    let id_rl: String?
    let id_alat: String?
    let qty: String?
    let id_user: String?
    let id_room: String?
    let id_instalasi: String?
    let to_instalasi: String?
    let created_at: String?
    let status: String?
    let id_approve: String?
    let approve_at: String?
    let qty_approve: String?
    let note: String?
    let to_room: String?
    let status_text: String?
    let alatname: String?
    let instalasi_name: String?
    let location_pemohon: String?
    let location_penyedia: String?
    let detail: [SubmissionDetail]?
}

struct SubmissionDetail: Codable {
    let id: String?
    let id_rl: String?
    let id_asset: String?
    let from_instalasi: String?
    let from_room: String?
    let to_instalasi: String?
    let to_room: String?
    let id_ambil: String?
    let date_ambil: String?
    let from_kategori: String?
    let to_kategori: String?
    let date_kembali: String?
    let id_kembali: String?
    let id_prev: String?
    let assetname: String?
    let serial: String?
    let imgUrl: String?
    let from_instalasi_text: String?
    let to_instalasi_text: String?
    let from_room_text: String?
    let to_room_text: String?
    let location_peminjam: String?
    let location_owner: String?
    let status_text: String?
    let stt_qr: String?
}

struct ReturningEntity: Codable {
    let data: ReturningDetail?
    let message: String?
    let status: Int?
}

struct ReturningDetail: Codable {
    let id: String?
}


struct MutationDetailEntity: Codable {
    let data: MutationDetailData?
    let message: String?
    let status: Int?
}

struct MutationDetailData: Codable {
    let idMt: String?
    let idAlat: String?
    let qty: String?
    let idUser: String?
    let idRoom: String?
    let idInstalasi: String?
    let toInstalasi: String?
    let createdAt: String?
    let status: String?
    let idApprove: String?
    let approveAt: String?
    let qtyApprove: String?
    let note: String?
    let toRoom: String?
    let statusText: String?
    let alatName: String?
    let instalasiName: String?
    let tujuanName: String?
    let locationPemohon: String?
    let locationPenyedia: String?
    let detail: [MutationDetailDetail]?
    let tipe: String?
    
    enum CodingKeys: String, CodingKey {
        case idMt = "id_mt"
        case idAlat = "id_alat"
        case qty
        case idUser = "id_user"
        case idRoom = "id_room"
        case idInstalasi = "id_instalasi"
        case toInstalasi = "to_instalasi"
        case createdAt = "created_at"
        case status
        case idApprove = "id_approve"
        case approveAt = "approve_at"
        case qtyApprove = "qty_approve"
        case note
        case toRoom = "to_room"
        case statusText = "status_text"
        case alatName = "alatname"
        case instalasiName = "instalasi_name"
        case tujuanName = "tujuan_name"
        case locationPemohon = "location_pemohon"
        case locationPenyedia = "location_penyedia"
        case detail
        case tipe
    }
}

struct MutationDetailDetail: Codable {
    let id: String?
    let idMt: String?
    let idAsset: String?
    let fromInstalasi: String?
    let fromRoom: String?
    let toInstalasi: String?
    let toRoom: String?
    let idAmbil: String?
    let dateAmbil: String?
    let fromKategori: String?
    let toKategori: String?
    let assetName: String?
    let serial: String?
    let imgUrl: String?
    let brandName: String?
    let typeName: String?
    let fromInstalasiText: String?
    let toInstalasiText: String?
    let fromRoomText: String?
    let toRoomText: String?
    let sttQr: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case idMt = "id_mt"
        case idAsset = "id_asset"
        case fromInstalasi = "from_instalasi"
        case fromRoom = "from_room"
        case toInstalasi = "to_instalasi"
        case toRoom = "to_room"
        case idAmbil = "id_ambil"
        case dateAmbil = "date_ambil"
        case fromKategori = "from_kategori"
        case toKategori = "to_kategori"
        case assetName = "assetname"
        case serial
        case imgUrl = "imgUrl"
        case brandName = "brandname"
        case typeName = "typename"
        case fromInstalasiText = "from_instalasi_text"
        case toInstalasiText = "to_instalasi_text"
        case fromRoomText = "from_room_text"
        case toRoomText = "to_room_text"
        case sttQr = "stt_qr"
    }
}
