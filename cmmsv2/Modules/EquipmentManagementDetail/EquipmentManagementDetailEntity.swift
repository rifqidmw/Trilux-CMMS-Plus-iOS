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
