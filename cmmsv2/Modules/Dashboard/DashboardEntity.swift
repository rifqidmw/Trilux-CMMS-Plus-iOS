//
//  DashboardEntity.swift
//  cmmsv2
//
//  Created by macbook  on 28/08/24.
//

import Foundation

struct DashboardEngineerEntity: Codable {
    let data: DashboardEngineerContent?
    let reff: Reference?
    let message: String?
    let status: Int?
}

struct DashboardEngineerContent: Codable {
    let engineer: DashboardEngineer?
    let kwartal: Quarter?
    let bulanIni: MonthlyData?
    let graph: Graph?
    let beban: Load?
}

struct DashboardEngineer: Codable {
    let id: String?
    let username: String?
    let avatar: String?
    let kontak: String?
    let unitKerja: String?
    let jabatan: String?
    
    enum CodingKeys: String, CodingKey {
        case id, username, avatar, kontak
        case unitKerja = "unit_kerja"
        case jabatan
    }
}

struct Quarter: Codable {
    let data: QuarterData?
    let textKwartal: String?
    let total, open, progress, selesai, kendala: Int?
    let sukuCadang, pihak3, lain: Int?
    let targetInspeksi, realisasiInspeksi: Int?
    let persenInspeksi: Double?
    let targetPreventif, realisasiPreventif: Int?
    let persenPreventif: Double?
    
    enum CodingKeys: String, CodingKey {
        case data
        case textKwartal = "text_kwartal"
        case total, open, progress, selesai, kendala
        case sukuCadang = "suku_cadang"
        case pihak3 = "pihak3"
        case lain
        case targetInspeksi = "target_inspeksi"
        case realisasiInspeksi = "realisasi_inspeksi"
        case persenInspeksi = "persen_inspeksi"
        case targetPreventif = "target_preventif"
        case realisasiPreventif = "realisasi_preventif"
        case persenPreventif = "persen_preventif"
    }
}

struct QuarterData: Codable {
    let romawi: String?
    let textBulan: String?
    let start: String?
    let end: String?
    
    enum CodingKeys: String, CodingKey {
        case romawi
        case textBulan = "text_bulan"
        case start, end
    }
}

struct MonthlyData: Codable {
    let total, open, progress, selesai, kendala: Int?
    let sukuCadang, pihak3, lain: Int?
    let targetInspeksi: String?
    let realisasiInspeksi, persenInspeksi: Int?
    let targetPreventif: String?
    let realisasiPreventif, persenPreventif: Int?
    let targetKalibrasi, realisasiKalibrasi, persenKalibrasi: Int?
    let laikKalibrasi, tidakLaikKalibrasi: Int?
    let jadwalPreventifBulan, jadwalPreventifNext: Int?
    
    enum CodingKeys: String, CodingKey {
        case total, open, progress, selesai, kendala
        case sukuCadang = "suku_cadang"
        case pihak3 = "pihak3"
        case lain
        case targetInspeksi = "target_inspeksi"
        case realisasiInspeksi = "realisasi_inspeksi"
        case persenInspeksi = "persen_inspeksi"
        case targetPreventif = "target_preventif"
        case realisasiPreventif = "realisasi_preventif"
        case persenPreventif = "persen_preventif"
        case targetKalibrasi = "target_kalibrasi"
        case realisasiKalibrasi = "realisasi_kalibrasi"
        case persenKalibrasi = "persen_kalibrasi"
        case laikKalibrasi = "laik_kalibrasi"
        case tidakLaikKalibrasi = "tidak_laik_kalibrasi"
        case jadwalPreventifBulan = "jadwal_preventif_bulan"
        case jadwalPreventifNext = "jadwal_preventif_next"
    }
}

struct Graph: Codable {
    let inspeksi: [GraphData]?
    let preventif: [GraphData]?
}

struct GraphData: Codable {
    let bulan: String?
    let bulanText: String?
    let bulanTextMin: String?
    let tahunText: String?
    let jumlah: String?
    
    enum CodingKeys: String, CodingKey {
        case bulan
        case bulanText = "bulan_text"
        case bulanTextMin = "bulan_text_min"
        case tahunText = "tahun_text"
        case jumlah
    }
}

struct Load: Codable {
    let alat: [LoadData]?
    let beban: [LoadData]?
}

struct LoadData: Codable {
    let id: String?
    let name: String?
    let value: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case value
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let intId = try? container.decode(Int.self, forKey: .id) {
            self.id = String(intId)
        } else if let stringId = try? container.decode(String.self, forKey: .id) {
            self.id = stringId
        } else {
            self.id = nil
        }
        
        self.name = try? container.decode(String.self, forKey: .name)
        self.value = try? container.decode(Int.self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(value, forKey: .value)
        
        if let id = id, let intValue = Int(id) {
            try container.encode(intValue, forKey: .id)
        } else {
            try container.encode(id, forKey: .id)
        }
    }
}

struct Reference: Codable {
    let listEngineer: [KeyValue]?
    let id: String?
    let bulan: Int?
    let tahun: String?
    let tahunBulan: String?
    let listBulan: [KeyValue]?
    let listTahun: [KeyValue]?
    
    enum CodingKeys: String, CodingKey {
        case listEngineer = "list_engineer"
        case id, bulan, tahun
        case tahunBulan = "tahun_bulan"
        case listBulan = "list_bulan"
        case listTahun = "list_tahun"
    }
}

struct KeyValue: Codable {
    let key: String?
    let value: String?
}
