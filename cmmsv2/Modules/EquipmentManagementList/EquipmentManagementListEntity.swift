//
//  EquipmentManagementEntity.swift
//  cmmsv2
//
//  Created by macbook  on 10/09/24.
//

import Foundation

enum EquipmentManagementType {
    case returning
    case loan
}

enum EquipmentManagementSegmentedType: String, CaseIterable {
    case borrowed = "Dipinjam"
    case loan = "Pinjaman"
    case submission = "Pengajuan"
    case request = "Permintaan"
    case none = ""
    
    init?(rawValue: String) {
        switch rawValue {
        case "Dipinjam": self = .borrowed
        case "Pinjaman": self = .loan
        case "Pengajuan": self = .submission
        case "Permintaan": self = .request
        case "": self = .none
        default: self = .none
        }
    }
    
    func getStringValue() -> String {
        return rawValue
    }
}

enum EquipmentStatusTextType: String, Codable {
    case taken = "Diambil"
    case readyTaken = "Siap Diambil"
    case none = ""
    
    init?(rawValue: String) {
        switch rawValue {
        case "Diambil": self = .taken
        case "Siap Diambil": self = .readyTaken
        case "": self = .none
        default: self = .none
        }
    }
    
    func getStringValue() -> String {
        return rawValue
    }
}

struct EquipmentManagementSubmissionEntity: Codable {
    let data: [EquipmentManagementSubmissionData]?
    let reff: ReffData?
    let message: String?
    let status: Int?
}

struct EquipmentManagementSubmissionData: Codable {
    let idRl: String?
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
    let detail: [EquipmentManagementSubmissionDetail]?
    
    enum CodingKeys: String, CodingKey {
        case idRl = "id_rl"
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
    }
}

struct EquipmentManagementSubmissionDetail: Codable {
    let id: String?
    let idRl: String?
    let idAsset: String?
    let fromInstalasi: String?
    let fromRoom: String?
    let toInstalasi: String?
    let toRoom: String?
    let idAmbil: String?
    let dateAmbil: String?
    let fromKategori: String?
    let toKategori: String?
    let dateKembali: String?
    let idKembali: String?
    let idPrev: String?
    let assetName: String?
    let serial: String?
    let imgUrl: String?
    let fromInstalasiText: String?
    let toInstalasiText: String?
    let fromRoomText: String?
    let toRoomText: String?
    let locationPeminjam: String?
    let locationOwner: String?
    let statusText: String?
    let sttQr: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case idRl = "id_rl"
        case idAsset = "id_asset"
        case fromInstalasi = "from_instalasi"
        case fromRoom = "from_room"
        case toInstalasi = "to_instalasi"
        case toRoom = "to_room"
        case idAmbil = "id_ambil"
        case dateAmbil = "date_ambil"
        case fromKategori = "from_kategori"
        case toKategori = "to_kategori"
        case dateKembali = "date_kembali"
        case idKembali = "id_kembali"
        case idPrev = "id_prev"
        case assetName = "assetname"
        case serial
        case imgUrl = "imgUrl"
        case fromInstalasiText = "from_instalasi_text"
        case toInstalasiText = "to_instalasi_text"
        case fromRoomText = "from_room_text"
        case toRoomText = "to_room_text"
        case locationPeminjam = "location_peminjam"
        case locationOwner = "location_owner"
        case statusText = "status_text"
        case sttQr = "stt_qr"
    }
}

struct EquipmentManagementRequestEntity: Codable {
    let data: [EquipmentManagementRequestData]?
    let reff: ReffData?
    let message: String?
    let status: Int?
}

struct EquipmentManagementRequestData: Codable {
    let id: String?
    let idRl: String?
    let idAsset: String?
    let fromInstalasi: String?
    let fromRoom: String?
    let toInstalasi: String?
    let toRoom: String?
    let idAmbil: String?
    let dateAmbil: String?
    let fromKategori: String?
    let toKategori: String?
    let dateKembali: String?
    let idKembali: String?
    let idPrev: String?
    let assetName: String?
    let serial: String?
    let imgUrl: String?
    let fromInstalasiText: String?
    let toInstalasiText: String?
    let fromRoomText: String?
    let toRoomText: String?
    let locationPeminjam: String?
    let locationOwner: String?
    let statusText: String?
    let sttQr: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case idRl = "id_rl"
        case idAsset = "id_asset"
        case fromInstalasi = "from_instalasi"
        case fromRoom = "from_room"
        case toInstalasi = "to_instalasi"
        case toRoom = "to_room"
        case idAmbil = "id_ambil"
        case dateAmbil = "date_ambil"
        case fromKategori = "from_kategori"
        case toKategori = "to_kategori"
        case dateKembali = "date_kembali"
        case idKembali = "id_kembali"
        case idPrev = "id_prev"
        case assetName = "assetname"
        case serial
        case imgUrl
        case fromInstalasiText = "from_instalasi_text"
        case toInstalasiText = "to_instalasi_text"
        case fromRoomText = "from_room_text"
        case toRoomText = "to_room_text"
        case locationPeminjam = "location_peminjam"
        case locationOwner = "location_owner"
        case statusText = "status_text"
        case sttQr = "stt_qr"
    }
}
