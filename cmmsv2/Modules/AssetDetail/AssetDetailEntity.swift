//
//  AssetDetailEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 01/05/24.
//

import Foundation

struct AdditionalDocument {
    let id: Int
    let title: String
}

let documentData: [AdditionalDocument] = [
    AdditionalDocument(id: 1, title: "S. Garansi"),
    AdditionalDocument(id: 2, title: "Sertifikat Kalibrasi"),
    AdditionalDocument(id: 3, title: "Standard Operating Procedure"),
    AdditionalDocument(id: 4, title: "User Manual"),
    AdditionalDocument(id: 5, title: "Service Manual"),
    AdditionalDocument(id: 6, title: "SP Pemeliharaan"),
    AdditionalDocument(id: 7, title: "SP Perbaikan"),
    AdditionalDocument(id: 8, title: "Kontrak"),
    AdditionalDocument(id: 9, title: "BA. Penerimaan"),
    AdditionalDocument(id: 10, title: "Doc AKD / AKL"),
    AdditionalDocument(id: 11, title: "BA Uji Fungsi"),
    AdditionalDocument(id: 12, title: "BA Uji Coba"),
]

struct AssetDetailEntity: Codable {
    let count: Int?
    let data: AssetDetailData?
    let message: String?
    let status: Int?
    let reff: ReffData?
    
    enum CodingKeys: CodingKey {
        case count
        case data
        case message
        case status
        case reff
    }
}

struct AssetDetailData: Codable {
    let equipment: EquipmentDetail?
    
    enum CodingKeys: CodingKey {
        case equipment
    }
}

struct EquipmentDetail: Codable {
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
    let statusKalibrasi: KalibrasiStatus?
    let stt_qr: String?
    let txtLokasiInstalasi: String?
    let id_alat: String?
    let is_nonmedik: String?
    let lk_static: String?
    let klp_nonmedik: String?
    let klp_nonmedik_name: String?
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
    
    enum CodingKeys: CodingKey {
        case id
        case txtName
        case valImage
        case valQR
        case valQRProperties
        case txtRuangan
        case valRoomId
        case txtRoomId
        case txtSubRuangan
        case txtLokasiName
        case txtSerial
        case txtBrand
        case txtType
        case txtInventaris
        case txtTahun
        case txtDescriptions
        case txtLastWoStatus
        case badgeAsset
        case badgeTeknis
        case txtUsiaTeknis
        case txtDistributor
        case syncSimak
        case codeSimak
        case nameSimak
        case syncSimbada
        case codeSimbada
        case nameSimbada
        case syncAspak
        case statusKalibrasi
        case stt_qr
        case txtLokasiInstalasi
        case id_alat
        case is_nonmedik
        case lk_static
        case klp_nonmedik
        case klp_nonmedik_name
        case valRusak
        case txtRusak
        case valKalibrasi
        case txtKalibrasi
        case valKorektif
        case txtKorektif
        case valPreventif
        case txtPreventif
        case valIsComplainable
        case txtCantComplainReason
        case txtInfoUpdate
    }
}

struct EquipmentFilesEntity: Codable {
    let count: Int?
    let data: EquipmentFilesData?
    let message: String?
    let status: Int?
    let reff: ReffData?
    
    enum CodingKeys: CodingKey {
        case count
        case data
        case message
        case status
        case reff
    }
}

struct EquipmentFilesData: Codable {
    let equipmentFiles: EquipmentFiles?
    
    enum CodingKeys: CodingKey {
        case equipmentFiles
    }
}

struct EquipmentFiles: Codable {
    let filePenerimaan: [File]?
    
    enum CodingKeys: String, CodingKey {
        case filePenerimaan = "file_penerimaan"
    }
}

struct File: Codable {
    let id: Int?
    let title: String?
    let url: String?
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case url
    }
}

struct EquipmentMainCoastEntity: Codable {
    let count: Int?
    let data: EquipmentMainCoastData?
    let message: String?
    let status: Int?
    let reff: ReffData?
    
    enum CodingKeys: CodingKey {
        case count
        case data
        case message
        case status
        case reff
    }
}

struct EquipmentMainCoastData: Codable {
    let equipment: EquipmentMainCoast?
    
    enum CodingKeys: CodingKey {
        case equipment
    }
}

struct EquipmentMainCoast: Codable {
    let id: String?
    let txtIIC: String?
    let txtAIC: Int?
    let txtMaintenance: String?
    let txtPengganti: String?
    let txtUsiaTeknis: String?
    let txtFaktorMEL: String?
    let txtNilaiMMEL: String?
    
    enum CodingKeys: CodingKey {
        case id
        case txtIIC
        case txtAIC
        case txtMaintenance
        case txtPengganti
        case txtUsiaTeknis
        case txtFaktorMEL
        case txtNilaiMMEL
    }
}

struct EquipmentTechnicalEntity: Codable {
    let count: Int?
    let data: EquipmentTechnicalData?
    let message: String?
    let status: Int?
    let reff: ReffData?
    
    enum CodingKeys: CodingKey {
        case count
        case data
        case message
        case status
        case reff
    }
}

struct EquipmentTechnicalData: Codable {
    let equipment: EquipmentTechnical?
    
    enum CodingKeys: CodingKey {
        case equipment
    }
}

struct EquipmentTechnical: Codable {
    let id: String?
    let noInventaris: String?
    let txtSumber: String?
    let txtBiaya: String?
    let txtThnPembelian: String?
    let txtLife: String?
    let txtThnOperate: String?
    let txtThnProduct: String?
    let txtRasioSisaUsia: String?
    let txtKondisi: String?
    let txtKerusakan: String?
    let txtPrioritas: String?
    let txtTeknologi: String?
    let txtResiko: String?
    let txtPower: String?
    
    enum CodingKeys: CodingKey {
        case id
        case noInventaris
        case txtSumber
        case txtBiaya
        case txtThnPembelian
        case txtLife
        case txtThnOperate
        case txtThnProduct
        case txtRasioSisaUsia
        case txtKondisi
        case txtKerusakan
        case txtPrioritas
        case txtTeknologi
        case txtResiko
        case txtPower
    }
}

struct DeliveryAcceptanceEntity: Codable {
    let data: DeliveryAcceptanceData?
    let message: String?
    let status: Int?
    
    enum CodingKeys: CodingKey {
        case data
        case message
        case status
    }
}

struct DeliveryAcceptanceData: Codable {
    let idPenerimaan: String?
    let noKontrak: String?
    let tanggal: String?
    let noBap: String?
    let idRekanan: String?
    let desc: String?
    let tipe: String?
    let jenis: String?
    let tanpaInfo: String?
    let typeText: String?
    let rekananText: String?
    let countAsset: String?
    let files: [DeliveryDocument]?
    
    enum CodingKeys: CodingKey {
        case idPenerimaan
        case noKontrak
        case tanggal
        case noBap
        case idRekanan
        case desc
        case tipe
        case jenis
        case tanpaInfo
        case typeText
        case rekananText
        case countAsset
        case files
    }
}

struct DeliveryDocument: Codable {
    let documentType: String?
    let text: String?
    let data: [String: String]?
    
    enum CodingKeys: CodingKey {
        case documentType
        case text
        case data
    }
}
