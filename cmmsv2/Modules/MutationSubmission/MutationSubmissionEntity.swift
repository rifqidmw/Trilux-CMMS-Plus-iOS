//
//  MutationSubmissionEntity.swift
//  cmmsv2
//
//  Created by macbook  on 10/10/24.
//

import Foundation

struct InstallationListEntity: Codable {
    let data: [InstallationListData]?
    let message: String?
    let status: Int?
}

struct InstallationListData: Codable {
    let id: String?
    let name: String?
}

struct EquipmentListEntity: Codable {
    let data: [EquipmentListData]?
    let message: String?
    let status: Int?
}

struct EquipmentListData: Codable {
    let id: String?
    let text: String?
}

struct MutationSubmissionRequest {
    let toInstallasi: String?
    let equipmentId: String?
    let qty: String?
    
    enum CodingKeys: String, CodingKey {
        case toInstallasi = "to_instalasi"
        case equipmentId = "id_alat"
        case qty = "qty"
    }
}

struct MutationSubmissionResponse: Codable {
    let data: MutationSubmissionData?
    let message: String?
    let status: Int?
}

struct MutationSubmissionData: Codable {
    let status: String?
    let toInstalasi: String?
    let idAlat: String?
    let qty: String?
    let createdAt: String?
    let idUser: String?
    let idInstalasi: String?
    let idRoom: String?
    let idMt: String?
    let idApprove: String?
    let approveAt: String?
    let qtyApprove: String?
    let note: String?
    let toRoom: String?
    let statusText: String?
    let alatname: String?
    let instalasiName: String?
    let tujuanName: String?
    let locationPemohon: String?
    let locationPenyedia: String?
    let detail: [Detail]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case toInstalasi = "to_instalasi"
        case idAlat = "id_alat"
        case qty
        case createdAt = "created_at"
        case idUser = "id_user"
        case idInstalasi = "id_instalasi"
        case idRoom = "id_room"
        case idMt = "id_mt"
        case idApprove = "id_approve"
        case approveAt = "approve_at"
        case qtyApprove = "qty_approve"
        case note
        case toRoom = "to_room"
        case statusText = "status_text"
        case alatname
        case instalasiName = "instalasi_name"
        case tujuanName = "tujuan_name"
        case locationPemohon = "location_pemohon"
        case locationPenyedia = "location_penyedia"
        case detail
    }
}

struct Detail: Codable {}
