//
//  WorkSheetOnsitePreventiveDetailEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/02/24.
//

import Foundation

enum WorkSheetActionType {
    case seeing
    case working
}

enum WorkSheetDetailType {
    case monitoring
    case calibration
    case preventive
}

enum WorkSheetActivityType {
    case correction
    case working
    case view
}

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
    let newpart: [LKNewPart]?
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
        case idLK = "id_lk"
        case lkNumber = "lk_number"
        case lkJenis = "lk_jenis"
        case lkVarian = "lk_varian"
        case lkDate = "lk_date"
        case lkEngineer = "lk_engineer"
        case lkAssign = "lk_assign"
        case idAsset = "id_asset"
        case lkLabel = "lk_label"
        case lkInfo = "lk_info"
        case lkStatus = "lk_status"
        case lkFinishstt = "lk_finishstt"
        case lkWebenable = "lk_webenable"
        case lkStart = "lk_start"
        case lkFinish = "lk_finish"
        case lkContinue = "lk_continue"
        case lkDurasireal = "lk_durasireal"
        case lkRating = "lk_rating"
        case createBy = "create_by"
        case approveBy = "approve_by"
        case rateBy = "rate_by"
        case createAt = "create_at"
        case idComplain = "id_complain"
        case comTime = "com_time"
        case comRespon = "com_respon"
        case downtime = "downtime"
        case lkPelapor = "lk_pelapor"
        case analisa = "analisa"
        case keluhan = "keluhan"
        case dipindahkan = "dipindahkan"
        case persiapan = "persiapan"
        case preventif = "preventif"
        case pemantauan = "pemantauan"
        case listrik = "listrik"
        case abaiPersiapan = "abai_persiapan"
        case abaiPreventif = "abai_preventif"
        case abaiPemantauan = "abai_pemantauan"
        case abaiListrik = "abai_listrik"
        case task = "task"
        case sparepart = "sparepart"
        case newpart = "newpart"
        case lkphoto = "lkphoto"
        case idKalibrator = "id_kalibrator"
        case metode = "metode"
        case sttLaik = "stt_laik"
        case idRelokasi = "id_relokasi"
        case jenisRelokasi = "jenis_relokasi"
        case lkKegiatan = "lk_kegiatan"
        case asset = "asset"
        case alatKalibrasi = "alat_kalibrasi"
        case engineername = "engineer_name"
        case namaPelapor = "nama_pelapor"
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

struct SparePartEntity: Codable {
    let data: [SparePartData]?
    let message: String?
    let status: Int?
}

struct SparePartData: Codable {
    let idPart: String?
    let name: String?
    let partname: String?
    let harga: Int?
    let desc: String?
    let pn: String?
    let tipe: String?
    
    enum CodingKeys: String, CodingKey {
        case idPart = "id_part"
        case name
        case partname
        case harga
        case desc
        case pn
        case tipe
    }
}

// MARK: - REQUEST ENTITY
struct LKStartRequest: Codable {
    let abaiListrik, abaiPemantauan, abaiPersiapan, abaiPreventif: String?
    let alatKalibrasi: [LKData.AlatKalibrasi]?
    let analisa: [String]?
    let approveBy: String?
    let asset: LKData.Asset?
    let comRespon, comTime, createAt, createBy: String?
    let dipindahkan, downtime, engineername, idAsset: String?
    let idComplain, idKalibrator, idLk, idRelokasi: String?
    let jenisRelokasi, keluhan: String?
    let listrik: [ListrikLK]?
    let lkAssign, lkContinue, lkDate, lkDurasireal: String?
    let lkEngineer, lkFinish, lkFinishstt, lkInfo: String?
    let lkJenis, lkKegiatan, lkLabel, lkNumber: String?
    let lkPelapor, lkRating, lkStart, lkStatus: String?
    let lkVarian, lkWebenable: String?
    let lkphoto: [PhotoLK]?
    let metode: String?
    let newpart: [LKNewPart]?
    let persiapan, preventif: [LKPreventif]?
    let pemantauan: [LKPemantauan]?
    let rateBy, sttLaik: String?
    let sparepart: [LKSparePart]?
    let task: [TaskLK]?
    
    enum CodingKeys: String, CodingKey {
        case abaiListrik = "abai_listrik"
        case abaiPemantauan = "abai_pemantauan"
        case abaiPersiapan = "abai_persiapan"
        case abaiPreventif = "abai_preventif"
        case alatKalibrasi = "alat_kalibrasi"
        case analisa
        case approveBy = "approve_by"
        case asset
        case comRespon = "com_respon"
        case comTime = "com_time"
        case createAt = "create_at"
        case createBy = "create_by"
        case dipindahkan
        case downtime
        case engineername
        case idAsset = "id_asset"
        case idComplain = "id_complain"
        case idKalibrator = "id_kalibrator"
        case idLk = "id_lk"
        case idRelokasi = "id_relokasi"
        case jenisRelokasi = "jenis_relokasi"
        case keluhan
        case listrik
        case lkAssign = "lk_assign"
        case lkContinue = "lk_continue"
        case lkDate = "lk_date"
        case lkDurasireal = "lk_durasireal"
        case lkEngineer = "lk_engineer"
        case lkFinish = "lk_finish"
        case lkFinishstt = "lk_finishstt"
        case lkInfo = "lk_info"
        case lkJenis = "lk_jenis"
        case lkKegiatan = "lk_kegiatan"
        case lkLabel = "lk_label"
        case lkNumber = "lk_number"
        case lkPelapor = "lk_pelapor"
        case lkRating = "lk_rating"
        case lkStart = "lk_start"
        case lkStatus = "lk_status"
        case lkVarian = "lk_varian"
        case lkWebenable = "lk_webenable"
        case lkphoto
        case metode
        case newpart
        case pemantauan
        case persiapan
        case preventif
        case rateBy = "rate_by"
        case sparepart
        case sttLaik = "stt_laik"
        case task
    }
    
    init(abaiListrik: String? = nil, abaiPemantauan: String? = nil, abaiPersiapan: String? = nil, abaiPreventif: String? = nil, alatKalibrasi: [LKData.AlatKalibrasi]? = nil, analisa: [String]? = nil, approveBy: String? = nil, asset: LKData.Asset? = nil, comRespon: String? = nil, comTime: String? = nil, createAt: String? = nil, createBy: String? = nil, dipindahkan: String? = nil, downtime: String? = nil, engineername: String? = nil, idAsset: String? = nil, idComplain: String? = nil, idKalibrator: String? = nil, idLk: String? = nil, idRelokasi: String? = nil, jenisRelokasi: String? = nil, keluhan: String? = nil, listrik: [ListrikLK]? = nil, lkAssign: String? = nil, lkContinue: String? = nil, lkDate: String? = nil, lkDurasireal: String? = nil, lkEngineer: String? = nil, lkFinish: String? = nil, lkFinishstt: String? = nil, lkInfo: String? = nil, lkJenis: String? = nil, lkKegiatan: String? = nil, lkLabel: String? = nil, lkNumber: String? = nil, lkPelapor: String? = nil, lkRating: String? = nil, lkStart: String? = nil, lkStatus: String? = nil, lkVarian: String? = nil, lkWebenable: String? = nil, lkphoto: [PhotoLK]? = nil, metode: String? = nil, newpart: [LKNewPart]? = nil, pemantauan: [LKPemantauan]? = nil, persiapan: [LKPreventif]? = nil, preventif: [LKPreventif]? = nil, rateBy: String? = nil, sttLaik: String? = nil, sparepart: [LKSparePart]? = nil, task: [TaskLK]? = nil) {
        self.abaiListrik = abaiListrik
        self.abaiPemantauan = abaiPemantauan
        self.abaiPersiapan = abaiPersiapan
        self.abaiPreventif = abaiPreventif
        self.alatKalibrasi = alatKalibrasi
        self.analisa = analisa
        self.approveBy = approveBy
        self.asset = asset
        self.comRespon = comRespon
        self.comTime = comTime
        self.createAt = createAt
        self.createBy = createBy
        self.dipindahkan = dipindahkan
        self.downtime = downtime
        self.engineername = engineername
        self.idAsset = idAsset
        self.idComplain = idComplain
        self.idKalibrator = idKalibrator
        self.idLk = idLk
        self.idRelokasi = idRelokasi
        self.jenisRelokasi = jenisRelokasi
        self.keluhan = keluhan
        self.listrik = listrik
        self.lkAssign = lkAssign
        self.lkContinue = lkContinue
        self.lkDate = lkDate
        self.lkDurasireal = lkDurasireal
        self.lkEngineer = lkEngineer
        self.lkFinish = lkFinish
        self.lkFinishstt = lkFinishstt
        self.lkInfo = lkInfo
        self.lkJenis = lkJenis
        self.lkKegiatan = lkKegiatan
        self.lkLabel = lkLabel
        self.lkNumber = lkNumber
        self.lkPelapor = lkPelapor
        self.lkRating = lkRating
        self.lkStart = lkStart
        self.lkStatus = lkStatus
        self.lkVarian = lkVarian
        self.lkWebenable = lkWebenable
        self.lkphoto = lkphoto
        self.metode = metode
        self.newpart = newpart
        self.pemantauan = pemantauan
        self.persiapan = persiapan
        self.preventif = preventif
        self.rateBy = rateBy
        self.sttLaik = sttLaik
        self.sparepart = sparepart
        self.task = task
    }
}

// MARK: - Asset
struct AssetLK: Codable {
    let assetname, brandname, idAsset: String?
    let imgurl: String?
    let roomname, sarananame, serial: String?
    let thumburl: String?
    let typename: String?
    
    enum CodingKeys: String, CodingKey {
        case assetname
        case brandname
        case idAsset = "id_asset"
        case imgurl
        case roomname
        case sarananame
        case serial
        case thumburl
        case typename
    }
}

// MARK: - Listrik
struct ListrikLK: Codable {
    let ambangBatas, desc, key, label: String?
    let valUkur: String?
    
    enum CodingKeys: String, CodingKey {
        case ambangBatas = "ambang_batas"
        case desc
        case key
        case label
        case valUkur = "val_ukur"
    }
}

// MARK: - Lkphoto
struct PhotoLK: Codable {
    let filename, idLkphoto, note: String?
    let photoUrl: String?
    let photoID: String?
    
    enum CodingKeys: String, CodingKey {
        case filename
        case idLkphoto = "id_lkphoto"
        case note
        case photoUrl
        case photoID = "photo_id"
    }
}

// MARK: - Newpart
struct LKNewPart: Codable {
    let idLknewpart, idPart, jumlah, partname: String?
    
    enum CodingKeys: String, CodingKey {
        case idLknewpart = "id_lknewpart"
        case idPart = "id_part"
        case jumlah
        case partname
    }
}

// MARK: - Preventif
struct LKPreventif: Codable {
    let key, label, value, valueText: String?
    
    enum CodingKeys: String, CodingKey {
        case key
        case label
        case value
        case valueText = "value_text"
    }
}

// MARK: - Pemantauan
struct LKPemantauan: Codable {
    let fisik, fisikText, fungsi, fungsiText, key, label: String?
    
    enum CodingKeys: String, CodingKey {
        case fisik
        case fisikText = "fisik_text"
        case fungsi
        case fungsiText = "fungsi_text"
        case key
        case label
    }
}

// MARK: - Sparepart
struct LKSparePart: Codable {
    let harga, idLksparepart, idPart, jumlah: String?
    let jumlahTotal, partname: String?
    
    enum CodingKeys: String, CodingKey {
        case harga
        case idLksparepart = "id_lksparepart"
        case idPart = "id_part"
        case jumlah
        case jumlahTotal = "jumlah_total"
        case partname
    }
}

// MARK: - Task
struct TaskLK: Codable {
    let idLktask, lkTask: String?
    
    enum CodingKeys: String, CodingKey {
        case idLktask = "id_lktask"
        case lkTask = "lk_task"
    }
}

// MARK: - SAVE WORK SHEET RESPONSE
struct SaveWorkSheetResponseEntity: Codable {
    let data: WorkSheetResponseData?
    let message: String?
    let status: Int?
}

struct WorkSheetResponseData: Codable {
    let idLK: String?
    
    enum CodingKeys: String, CodingKey {
        case idLK = "id_lk"
    }
}

// MARK: - SEARCH SPARE PART
struct SearchSparePartEntity: Codable {
    let data: [SearchSparePartData]?
    let message: String?
    let status: Int?
}

struct SearchSparePartData: Codable {
    let idPart: String?
    let name: String?
    let partname: String?
    let harga: Int?
    let desc: String?
    let pn: String?
    let tipe: String?
    
    enum CodingKeys: String, CodingKey {
        case idPart = "id_part"
        case name
        case partname
        case harga
        case desc
        case pn
        case tipe
    }
}

// MARK: - MEDIA RESPONSE
struct MediaEntity: Codable {
    let count: Int?
    let data: MediaData?
    let message: String?
    let status: Int?
    let reff: ReffData?
}

struct MediaData: Codable {
    let medias: [Media]?
}
