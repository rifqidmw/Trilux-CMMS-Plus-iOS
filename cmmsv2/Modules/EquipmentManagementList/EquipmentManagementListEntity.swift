//
//  EquipmentManagementEntity.swift
//  cmmsv2
//
//  Created by macbook  on 10/09/24.
//

import Foundation

enum EquipmentManagementType {
    case loan
    case returning
    case mutation
    case amprah
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
    case submission = "Pengajuan"
    case none = ""
    
    init?(rawValue: String) {
        switch rawValue {
        case "Diambil": self = .taken
        case "Siap Diambil": self = .readyTaken
        case "Pengajuan": self = .submission
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

struct MutationRequestEntity: Codable {
    let status: Int?
    let data: [MutationRequestData]?
    let reff: ReffData?
    let message: String?
}

struct MutationRequestData: Codable {
    let locationPenyedia: String?
    let toInstalasi: String?
    let status: String?
    let idUser: String?
    let instalasiName: String?
    let alatName: String?
    let approveAt: String?
    let locationPemohon: String?
    let toRoom: String?
    let idRoom: String?
    let qtyApprove: String?
    let idAlat: String?
    let qty: String?
    let idInstalasi: String?
    let tujuanName: String?
    let note: String?
    let detail: [MutationRequestDetail]?
    let createdAt: String?
    let statusText: String?
    let idMT: String?
    let idApprove: String?
    
    enum CodingKeys: String, CodingKey {
        case locationPenyedia = "location_penyedia"
        case toInstalasi = "to_instalasi"
        case status
        case idUser = "id_user"
        case instalasiName = "instalasi_name"
        case alatName = "alatname"
        case approveAt = "approve_at"
        case locationPemohon = "location_pemohon"
        case toRoom = "to_room"
        case idRoom = "id_room"
        case qtyApprove = "qty_approve"
        case idAlat = "id_alat"
        case qty
        case idInstalasi = "id_instalasi"
        case tujuanName = "tujuan_name"
        case note
        case detail
        case createdAt = "created_at"
        case statusText = "status_text"
        case idMT = "id_mt"
        case idApprove = "id_approve"
    }
}

struct MutationRequestDetail: Codable {
    let serial: String?
    let fromInstalasi: String?
    let toInstalasi: String?
    let idAsset: String?
    let assetName: String?
    let typeName: String?
    let idAmbil: String?
    let fromKategori: String?
    let toRoom: String?
    let toKategori: String?
    let fromRoomText: String?
    let toRoomText: String?
    let fromRoom: String?
    let id: String?
    let sttQR: String?
    let imgURL: String?
    let fromInstalasiText: String?
    let toInstalasiText: String?
    let brandName: String?
    let idMT: String?
    let dateAmbil: String?
    
    enum CodingKeys: String, CodingKey {
        case serial
        case fromInstalasi = "from_instalasi"
        case toInstalasi = "to_instalasi"
        case idAsset = "id_asset"
        case assetName = "assetname"
        case typeName = "typename"
        case idAmbil = "id_ambil"
        case fromKategori = "from_kategori"
        case toRoom = "to_room"
        case toKategori = "to_kategori"
        case fromRoomText = "from_room_text"
        case toRoomText = "to_room_text"
        case fromRoom = "from_room"
        case id
        case sttQR = "stt_qr"
        case imgURL = "imgUrl"
        case fromInstalasiText = "from_instalasi_text"
        case toInstalasiText = "to_instalasi_text"
        case brandName = "brandname"
        case idMT = "id_mt"
        case dateAmbil = "date_ambil"
    }
}

struct AmprahListEntity: Codable {
    let data: [AmprahListData]?
    let reff: ReffData?
    let message: String?
    let status: Int?
}

struct AmprahListData: Codable {
    let id: String?
    let valName: String?
    let valImage: String?
    let valQR: String?
    let valSerial: String?
    let valBrand: String?
    let valType: String?
    let valRuangan: String?
    let txtSubRuangan: String?
    let txtLokasiName: String?
    let valRoomId: String?
    let txtRoomId: String?
    let badgeAsset: String?
    let badgeTeknis: String?
    let sttQR: String?
    let idAlat: String?
    let isNonMedik: String?
    let lkStatic: String?
    let klpNonMedik: String?
    let klpNonMedikName: String?
    
    enum CodingKeys: String, CodingKey {
        case id, valName, valImage, valQR, valSerial, valBrand, valType, valRuangan, txtSubRuangan, txtLokasiName, valRoomId, txtRoomId, badgeAsset, badgeTeknis, idAlat, isNonMedik = "is_nonmedik", sttQR = "stt_qr", lkStatic = "lk_static", klpNonMedik = "klp_nonmedik", klpNonMedikName = "klp_nonmedik_name"
    }
}

struct AmprahRoomEntity: Codable {
    let data: [AmprahRoomData]?
    let message: String?
    let status: Int?
}

struct AmprahRoomData: Codable {
    let id: String?
    let text: String?
}

struct AmprahMutationRequest: Codable {
    let id: String?
    let idRoom :String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case idRoom = "id_room"
    }
}

struct AmprahMutationResponse: Codable {
    let data: AmprahMutationData?
    let message: String?
    let status: Int?
}

struct AmprahMutationData: Codable {
    let id: String?
    let valName: String?
    let valImage: String?
    let valQR: String?
    let valSerial: String?
    let valBrand: String?
    let valType: String?
    let valRuangan: String?
    let txtSubRuangan: String?
    let txtLokasiName: String?
    let valRoomId: String?
    let txtRoomId: String?
    let badgeAsset: String?
    let badgeTeknis: String?
    let sttQR: String?
    let idAlat: String?
    let isNonmedik: String?
    let lkStatic: String?
    let klpNonmedik: String?
    let klpNonmedikName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case valName
        case valImage
        case valQR
        case valSerial
        case valBrand
        case valType
        case valRuangan
        case txtSubRuangan
        case txtLokasiName
        case valRoomId
        case txtRoomId
        case badgeAsset
        case badgeTeknis
        case sttQR = "stt_qr"
        case idAlat = "id_alat"
        case isNonmedik = "is_nonmedik"
        case lkStatic = "lk_static"
        case klpNonmedik = "klp_nonmedik"
        case klpNonmedikName = "klp_nonmedik_name"
    }
}
