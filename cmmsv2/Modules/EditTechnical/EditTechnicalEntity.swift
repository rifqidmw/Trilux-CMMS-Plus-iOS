//
//  EditTechnicalEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 02/08/24.
//

import Foundation

struct TechnicalEntity: Codable {
    let data: TechnicalData?
    let reff: TechnicalReference?
    let message: String?
    let status: Int?
}

struct TechnicalData: Codable {
    let idAsset: String?
    let urutMedik: String?
    let tech: String?
    let power: String?
    let priority: String?
    let klsresiko: String?
    let fungsi: String?
    let resiko: String?
    let pemeliharaan: String?
    let insiden: String?
    let frekuensi: String?
    let year: String?
    let usia: String?
    let melopsi: String?
    let pengganti: String?
    let recpengganti: String?
    let tglUji: String?
    
    enum CodingKeys: String, CodingKey {
        case idAsset = "id_asset"
        case urutMedik = "urut_medik"
        case tech
        case power
        case priority
        case klsresiko
        case fungsi
        case resiko
        case pemeliharaan
        case insiden
        case frekuensi
        case year
        case usia
        case melopsi
        case pengganti
        case recpengganti
        case tglUji = "tgl_uji"
    }
}

struct TechnicalReference: Codable {
    let tech: [ReferenceItem]?
    let priority: [ReferenceItem]?
    let kelasResiko: [ReferenceItem]?
    let fungsi: [ReferenceItem]?
    let resiko: [ReferenceItem]?
    let pemeliharaan: [ReferenceItem]?
    let frekuensi: [ReferenceItem]?
    let insiden: [ReferenceItem]?
    let melopsi: [ReferenceItem]?
    
    enum CodingKeys: String, CodingKey {
        case tech
        case priority
        case kelasResiko = "kelas_resiko"
        case fungsi
        case resiko
        case pemeliharaan
        case frekuensi
        case insiden
        case melopsi
    }
}

struct ReferenceItem: Codable {
    let key: String?
    let value: String?
}

struct EditTechnicalRequestEntity: Codable {
    let frekuensi: String
    let fungsi: String
    let idAsset: String
    let insiden: String
    let klsresiko: String
    let melopsi: String
    let pemeliharaan: String
    let pengganti: String
    let power: String
    let priority: String
    let recpengganti: String
    let resiko: String
    let tech: String
    let urutMedik: String
    let usia: String
    let year: String
    
    enum CodingKeys: String, CodingKey {
        case frekuensi
        case fungsi
        case idAsset = "id_asset"
        case insiden
        case klsresiko
        case melopsi
        case pemeliharaan
        case pengganti
        case power
        case priority
        case recpengganti
        case resiko
        case tech
        case urutMedik = "urut_medik"
        case usia
        case year
    }
    
    init(frekuensi: String? = nil, fungsi: String? = nil, idAsset: String? = nil, insiden: String? = nil, klsresiko: String? = nil, melopsi: String? = nil, pemeliharaan: String? = nil, pengganti: String? = nil, power: String? = nil, priority: String? = nil, recpengganti: String? = nil, resiko: String? = nil, tech: String? = nil, urutMedik: String? = nil, usia: String? = nil, year: String? = nil) {
        self.frekuensi = frekuensi ?? ""
        self.fungsi = fungsi ?? ""
        self.idAsset = idAsset ?? ""
        self.insiden = insiden ?? ""
        self.klsresiko = klsresiko ?? ""
        self.melopsi = melopsi ?? ""
        self.pemeliharaan = pemeliharaan ?? ""
        self.pengganti = pengganti ?? ""
        self.power = power ?? ""
        self.priority = priority ?? ""
        self.recpengganti = recpengganti ?? ""
        self.resiko = resiko ?? ""
        self.tech = tech ?? ""
        self.urutMedik = urutMedik ?? ""
        self.usia = usia ?? ""
        self.year = year ?? ""
    }
}

struct SaveTechnicalEntity: Codable {
    let data: SaveTechnicalData?
    let message: String?
    let status: Int?
}

struct SaveTechnicalData: Codable {
    let id: String?
}
