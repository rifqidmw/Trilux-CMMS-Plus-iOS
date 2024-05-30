//
//  WorkSheetOnsitePreventiveDetailEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/02/24.
//

import Foundation

// MARK: - Monitoring Function Entity
struct MonitoringFunctionEntity: Codable {
    let data: LKData?
    let reff: References?
    let message: String?
    let status: Int?
}

// MARK: - LKData
struct LKData: Codable {
    let idLK: String?
    let lkNumber: String?
    let lkJenis: String?
    let lkVarian: String?
    let lkDate: String?
    let lkEngineer: String?
    let lkAssign: String?
    let idAsset: String?
    let lkLabel: String?
    let lkInfo: String?
    let lkStatus: String?
    let lkFinishstt: String?
    let lkWebenable: String?
    let lkStart: String?
    let lkFinish: String?
    let lkContinue: String?
    let lkDurasireal: String?
    let lkRating: String?
    let createBy: String?
    let approveBy: String?
    let rateBy: String?
    let createAt: String?
    let idComplain: String?
    let comTime: String?
    let comRespon: String?
    let downtime: String?
    let lkPelapor: String?
    let analisa: [String]?
    let keluhan: String?
    let dipindahkan: String?
    let persiapan: [Persiapan]?
    let preventif: [Preventif]?
    let pemantauan: [Pemantauan]?
    let listrik: [Listrik]?
    let abaiPersiapan: String?
    let abaiPreventif: String?
    let abaiPemantauan: String?
    let abaiListrik: String?
    let task: [Task]?
    let sparepart: [Sparepart]?
    let newpart: [String]?
    let lkphoto: [Lkphoto]?
    let idKalibrator: String?
    let metode: String?
    let sttLaik: String?
    let idRelokasi: String?
    let jenisRelokasi: String?
    let lkKegiatan: String?
    let asset: Asset?
    let alatKalibrasi: [AlatKalibrasi]?
    let engineername: String?
    let namaPelapor: String?
    
    enum CodingKeys: String, CodingKey {
        case idLK
        case lkNumber = "lk_number"
        case lkJenis
        case lkVarian
        case lkDate = "lk_date"
        case lkEngineer
        case lkAssign
        case idAsset
        case lkLabel
        case lkInfo
        case lkStatus = "lk_status"
        case lkFinishstt = "lk_finishstt"
        case lkWebenable
        case lkStart
        case lkFinish
        case lkContinue
        case lkDurasireal
        case lkRating
        case createBy
        case approveBy
        case rateBy
        case createAt
        case idComplain
        case comTime
        case comRespon
        case downtime
        case lkPelapor
        case analisa
        case keluhan
        case dipindahkan
        case persiapan
        case preventif
        case pemantauan
        case listrik
        case abaiPersiapan
        case abaiPreventif
        case abaiPemantauan
        case abaiListrik
        case task
        case sparepart
        case newpart
        case lkphoto
        case idKalibrator
        case metode
        case sttLaik
        case idRelokasi
        case jenisRelokasi
        case lkKegiatan
        case asset
        case alatKalibrasi = "alat_kalibrasi"
        case engineername
        case namaPelapor
    }
    
    // Nested entities specific to LKData
    struct Asset: Codable {
        let idAsset: String?
        let assetname: String?
        let serial: String?
        let brandname: String?
        let typename: String?
        let sarananame: String?
        let roomname: String?
        let imgurl: String?
        let thumburl: String?
    }
    
    struct Lkphoto: Codable {
        let idLkphoto: String?
        let filename: String?
        let note: String?
        let photoID: String?
        let photoUrl: String?
    }
    
    struct Persiapan: Codable {
        let key: String?
        let value: String?
        let label: String?
        let valueText: String?
        
        enum CodingKeys: String, CodingKey {
            case key
            case value
            case label
            case valueText = "value_text"
        }
    }
    
    struct Preventif: Codable {
        let key: String?
        let value: String?
        let label: String?
        let valueText: String?
    }
    
    struct Pemantauan: Codable {
        let key: String?
        let fisik: String?
        let fungsi: String?
        let label: String?
        let fisikText: String?
        let fungsiText: String?
    }
    
    struct Listrik: Codable {
        let key: String?
        let label: String?
        let ambangBatas: String?
        let valUkur: String?
        let desc: String?
    }
    
    struct Task: Codable {
        let idLktask: String?
        let lkTask: String?
    }
    
    struct Sparepart: Codable {
        let idLksparepart: String?
        let idPart: String?
        let jumlah: String?
        let harga: String?
        let partname: String?
        let jumlahTotal: String?
    }
    
    struct AlatKalibrasi: Codable {
        let id: String?
        let idProp: String?
        let nama: String?
        let detail: [Detail]?
        
        struct Detail: Codable {
            let jenis: String?
            let nilai: String?
            let hasil: String?
        }
    }
}

// MARK: - References
struct References: Codable {
    let jenis: [Jenis]?
    let status: [Status]?
    let finishStatus: [FinishStatus]?
    let sttKalibrasi: [SttKalibrasi]?
    let alatUkur: [AlatUkur]?
    
    enum CodingKeys: String, CodingKey {
        case jenis
        case status
        case finishStatus = "finish_status"
        case sttKalibrasi
        case alatUkur
    }
    
    struct Jenis: Codable {
        let key: String?
        let value: String?
    }
    
    struct Status: Codable {
        let key: String?
        let value: String?
    }
    
    struct FinishStatus: Codable {
        let key: String?
        let value: String?
    }
    
    struct SttKalibrasi: Codable {
        let key: String?
        let value: String?
    }
    
    struct AlatUkur: Codable {
        let id: String?
        let name: String?
        let items: [Item]?
        
        struct Item: Codable {
            let name: String?
            let subitems: [String]?
        }
    }
}


struct WorkSheetRequestEntity: Codable {
    let id: String?
    let action: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id_lk"
        case action = "aksi"
    }
}

// MARK: DUMMY ENTITY
enum WorkSheetActionType {
    case seeOnly
    case workContinue
}

enum WorkSheetDetailType {
    case monitoring
    case calibration
    case preventive
}

struct TensimeterModel: Identifiable {
    let id = UUID()
    let uniqueNumber: String
    let user: String
    let date: String
    let firstStatus: String
    let secondStatus: String
    let serialNumber: String
    let brand: String
    let type: String
    let installation: String
    let room: String
}

struct PreparationModel: Identifiable {
    let id = UUID()
    let title: String
    let subTitle: String
    let status: PreparationStatus?
    var isSelected: Bool = false
}

struct MeasurementModel: Identifiable {
    let id = UUID()
    let title: String
    let value: Int
}

struct ElectricalMeasurementModel: Identifiable {
    let id = UUID()
    let value: Int
    let title: String
    let description: String
}

struct ActionModel: Identifiable {
    let id = UUID()
    let title: String
    let desc: String
}

struct SparePartModel: Identifiable {
    let id = UUID()
    let title: String
    let total: Int
}

let labelData: [String] = [
    "Badan/Selungkup",
    "Kabel & Kelenturannya",
    "Tombol & Saklar",
    "Display/Layar",
    "Indikator Bunyi",
    "Alarm & Sistme Interlock",
    "Sistem Pengunci",
    "Lable/Penandaan",
    "Aksesoris"
]

let physicalData: [PreparationStatus] = [
    PreparationStatus.good,
    PreparationStatus.good,
    PreparationStatus.damaged,
    PreparationStatus.damaged,
    PreparationStatus.damaged,
    PreparationStatus.damaged,
    PreparationStatus.damaged,
    PreparationStatus.damaged,
    PreparationStatus.good
]

let functionalData: [PreparationStatus] = [
    PreparationStatus.good,
    PreparationStatus.good,
    PreparationStatus.damaged,
    PreparationStatus.damaged,
    PreparationStatus.damaged,
    PreparationStatus.damaged,
    PreparationStatus.damaged,
    PreparationStatus.damaged,
    PreparationStatus.good
]

let tensimeterData: TensimeterModel = TensimeterModel(
    uniqueNumber: "LK.2021.11.PI010",
    user: "Dr. Rizal",
    date: "15-Nov-2021",
    firstStatus: "Dalam proses pengerjaan",
    secondStatus: "Selesai",
    serialNumber: "112234452537",
    brand: "Fukuda ME",
    type: "Cardisunny C120",
    installation: "Pelayanan Rawat Jalan",
    room: "Ruangan Klinik Spesialisasi Kesehatan Anak (auto-room)")

let multimeterData: [MeasurementModel] = [
    MeasurementModel(title: "Tegangan 12V", value: 71),
    MeasurementModel(title: "Tegangan 24V", value: 61),
    MeasurementModel(title: "Tegangan 220V", value: 62),
    MeasurementModel(title: "Arus 3A", value: 0),
    MeasurementModel(title: "Arus 10A", value: 0)
]

let phantomEGCData: [MeasurementModel] = [
    MeasurementModel(title: "Bpm 60", value: 71),
    MeasurementModel(title: "Bpm 80", value: 61),
    MeasurementModel(title: "Bpm 100", value: 62)
]

let preparationData: [PreparationModel] = [
    PreparationModel(title: "Hand Hygiene", subTitle: "Hand Hygiene telah selesai dilakukan persiapan", status: .yes),
    PreparationModel(title: "Alat Pelindung Diri", subTitle: "Alat pelindung diri telah selesai dilakukan persiapan", status: .yes),
    PreparationModel(title: "KTD", subTitle: "KTD telah selesai dilakukan persiapan", status: .yes),
    PreparationModel(title: "Menyiapkan Alat & Bahan Kerja", subTitle: "Gagal dalam menyiapkan alat dan bahan kerja", status: .no),
    PreparationModel(title: "Mengoperasikan Alat Kalibrasi", subTitle: "Selesai dalam mengoperasikan alat kalibrasi", status: .yes),
    PreparationModel(title: "Mengoperasikan Alat", subTitle: "Gagal dalam mengoperasikan alat", status: .no)
]

let preventiveMaintenanceData: [PreparationModel] = [
    PreparationModel(title: "Pembersihan", subTitle: "Pembersihan dalam kondisi baik", status: .good, isSelected: true),
    PreparationModel(title: "Pelumasan", subTitle: "Pelumasan dalam kondisi baik", status: .good, isSelected: true),
    PreparationModel(title: "Penggantian Bahan Habis Pakai", subTitle: "Penggantian bahan habis pakai dalam kondisi baik", status: .good, isSelected: true),
    PreparationModel(title: "Kalibrasi Berkala", subTitle: "Kalibrasi dalam kondisi baik", status: .good, isSelected: true),
    PreparationModel(title: "Pengencangan Bagian Alat", subTitle: "Pengencangan bagian alat dalam kondisi rusak. Segera lakukan preventif!", status: .damaged, isSelected: false),
]

let electricalMeasurementData: [ElectricalMeasurementModel] = [
    ElectricalMeasurementModel(value: 10, title: "Tegangan jala-jala(-+ 10%)", description: "Tegangan berkisar 10%"),
    ElectricalMeasurementModel(value: 788, title: "Tahanan protektif pembumian(0.5 omega)", description: "Berkisar diangka 700-800"),
    ElectricalMeasurementModel(value: 0, title: "Tahanan isolasi(> 2 mega)", description: "Tidak ada keterangan"),
    ElectricalMeasurementModel(value: 0, title: "Arus bocor pada alat(< 500)", description: "Tidak ada keterangan"),
    ElectricalMeasurementModel(value: 0, title: "Arus bocor pada bagian yang diaplikasikan ke pasien(< 100)", description: "Tidak ada keterangan")
]

let actionData: [ActionModel] = [
    ActionModel(title: "Ganti Sparepart", desc: "Ganti sparepart secara berkala"),
    ActionModel(title: "Perbaiki Ban Dalam", desc: "Perbaiki ban dalam secara berkala"),
    ActionModel(title: "Isi Tabung Oksigen", desc: "Isi tabung oksigen secara berkala"),
    ActionModel(title: "Kencangkan Sekrup Pada Kursi Roda", desc: "Kencangkan sekurp pada setiap kursi roda")
]

let sparePartData: [SparePartModel] = [
    SparePartModel(title: "Kabel Power", total: 18),
    SparePartModel(title: "Sekrup Kursi Roda", total: 124)
]
