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
        case lkInfo = "lk_info"
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
        case idKalibrator = "id_kalibrator"
        case metode
        case sttLaik = "stt_laik"
        case idRelokasi
        case jenisRelokasi
        case lkKegiatan
        case asset
        case alatKalibrasi = "alat_kalibrasi"
        case engineername
        case namaPelapor
    }
    
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
        
        enum CodingKeys: String, CodingKey {
            case idLkphoto = "id_lkphoto"
            case filename
            case note
            case photoID = "photo_id"
            case photoUrl
        }
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
        
        enum CodingKeys: String, CodingKey {
            case key
            case value
            case label
            case valueText = "value_text"
        }
    }
    
    struct Pemantauan: Codable {
        let key: String?
        let fisik: String?
        let fungsi: String?
        let label: String?
        let fisikText: String?
        let fungsiText: String?
        
        enum CodingKeys: String, CodingKey {
            case key
            case fisik
            case fungsi
            case label
            case fisikText = "fisik_text"
            case fungsiText = "fungsi_text"
        }
    }
    
    struct Listrik: Codable {
        let key: String?
        let label: String?
        let ambangBatas: String?
        let valUkur: String?
        let desc: String?
        
        enum CodingKeys: String, CodingKey {
            case key
            case label
            case ambangBatas = "ambang_batas"
            case valUkur = "val_ukur"
            case desc
        }
    }
    
    struct Task: Codable {
        let idLktask: String?
        let lkTask: String?
        
        enum CodingKeys: String, CodingKey {
            case idLktask = "id_lktask"
            case lkTask = "lk_task"
        }
    }
    
    struct Sparepart: Codable {
        let idLksparepart: String?
        let idPart: String?
        let jumlah: String?
        let harga: String?
        let partname: String?
        let jumlahTotal: String?
        
        enum CodingKeys: String, CodingKey {
            case idLksparepart = "id_lksparepart"
            case idPart = "id_part"
            case jumlah
            case harga
            case partname
            case jumlahTotal = "jumlah_total"
        }
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
        case sttKalibrasi = "stt_kalibrasi"
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

struct KalibratorEntity: Codable {
    let data: [Kalibrator]?
    let message: String?
    let status: Int?
}

struct Kalibrator: Codable {
    let idKalibrator: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case idKalibrator = "id_kalibrator"
        case name
    }
}

enum WorkSheetActionType {
    case seeing
    case working
}

enum WorkSheetDetailType {
    case monitoring
    case calibration
    case preventive
}
