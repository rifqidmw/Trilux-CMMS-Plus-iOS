//
//  RoomRequirementListEntity.swift
//  cmmsv2
//
//  Created by macbook  on 03/10/24.
//

import Foundation

struct RoomRequirementListEntity: Codable {
    let data: [RoomRequirementListData]?
    let reff: ReffData?
    let message: String?
    let status: Int?
    
    enum CodingKeys: String, CodingKey {
        case data
        case reff
        case message
        case status
    }
}

struct RoomRequirementListData: Codable {
    let idKebutuhan: String?
    let tglKebutuhan: String?
    let idInstalasi: String?
    let idRoom: String?
    let sifat: String?
    let userId: String?
    let gantiUsia: String?
    let gantiKondisi: String?
    let baruInfo: String?
    let tambahKasus: String?
    let tambahPasien: String?
    let tambahProduk: String?
    let tambahRujuk: String?
    let tambahUtil: String?
    let tambahCost: String?
    let idAlat: String?
    let jumlah: String?
    let satuan: String?
    let keterangan: String?
    let photoId: String?
    let idUsulan: String?
    let namaAlat: String?
    let namaSifat: String?
    let namaInstalasi: String?
    let namaRoom: String?
    let namaKondisi: String?
    let listStatus: [ListStatus]?
    let statusAktif: String?
    let namaStatus: String?
    let namaSatuan: String?
    let namaUser: String?
    let photoUrl: String?
    let fotoAlat: String?
    let jmlRealisasi: String?
    let sttKebutuhan: String?
    let sttUsulan: String?
    let sttNominasi: String?
    let noUsulan: String?
    let myProgress: [Progress]?
    
    enum CodingKeys: String, CodingKey {
        case idKebutuhan = "id_kebutuhan"
        case tglKebutuhan = "tgl_kebutuhan"
        case idInstalasi = "id_instalasi"
        case idRoom = "id_room"
        case sifat
        case userId = "user_id"
        case gantiUsia = "ganti_usia"
        case gantiKondisi = "ganti_kondisi"
        case baruInfo = "baru_info"
        case tambahKasus = "tambah_kasus"
        case tambahPasien = "tambah_pasien"
        case tambahProduk = "tambah_produk"
        case tambahRujuk = "tambah_rujuk"
        case tambahUtil = "tambah_util"
        case tambahCost = "tambah_cost"
        case idAlat = "id_alat"
        case jumlah
        case satuan
        case keterangan
        case photoId = "photo_id"
        case idUsulan = "id_usulan"
        case namaAlat = "nama_alat"
        case namaSifat = "nama_sifat"
        case namaInstalasi = "nama_instalasi"
        case namaRoom = "nama_room"
        case namaKondisi = "nama_kondisi"
        case listStatus = "list_status"
        case statusAktif = "status_aktif"
        case namaStatus = "nama_status"
        case namaSatuan = "nama_satuan"
        case namaUser = "nama_user"
        case photoUrl = "photo_url"
        case fotoAlat = "foto_alat"
        case jmlRealisasi = "jml_realisasi"
        case sttKebutuhan = "stt_kebutuhan"
        case sttUsulan = "stt_usulan"
        case sttNominasi = "stt_nominasi"
        case noUsulan = "no_usulan"
        case myProgress = "my_progress"
    }
}

struct ListStatus: Codable {
    let key: String
    let value: String
    
    enum CodingKeys: String, CodingKey {
        case key
        case value
    }
}

struct Progress: Codable {
    let id: String
    let text: String
    let info: String
    let stt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case info
        case stt
    }
}
