//
//  ComplaintListEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/03/24.
//

import Foundation

enum ComplaintType {
    case engineer
    case room
}

struct ComplaintEntity: Codable {
    let count: Int?
    let data: ComplaintData?
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

struct ComplaintData: Codable {
    let complains: [Complaint]?
    
    enum CodingKeys: CodingKey {
        case complains
    }
}

struct Complaint: Codable {
    let id: Int?
    let valEquipmentId: Int?
    let valEquipmentName: String?
    let valEquipmentImg: String?
    let txtEquipmentSerial: String?
    let txtRuangan: String?
    let txtTitle: String?
    let txtDescriptions: String?
    let txtStatus: String?
    let valStatus: String?
    let txtSenderName: String?
    let valSenderImg: String?
    let txtComplainTime: String?
    let valIsManagable: Int?
    let valObservation: Int?
    let valCorrective: Int?
    let txtDownTime: String?
    let txtResponseTime: String?
    let valDelegatedTime: String?
    let valDelegatable: Bool?
    let txtEngineerName: String?
    let userIDfinish: String?
    let isDelay: String?
    let canPendamping: String?
    let infoLk: InfoLk?
    let canDeleteLk: Bool?
    let idLkActive: String?
    
    enum CodingKeys: CodingKey {
        case id
        case valEquipmentId
        case valEquipmentName
        case valEquipmentImg
        case txtEquipmentSerial
        case txtRuangan
        case txtTitle
        case txtDescriptions
        case txtStatus
        case valStatus
        case txtSenderName
        case valSenderImg
        case txtComplainTime
        case valIsManagable
        case valObservation
        case valCorrective
        case txtDownTime
        case txtResponseTime
        case valDelegatedTime
        case valDelegatable
        case txtEngineerName
        case userIDfinish
        case isDelay
        case canPendamping
        case infoLk
        case canDeleteLk
        case idLkActive
    }
}

struct InfoLk: Codable {
    let lkNumber: String?
    let engineerName: String?
    let pendampingName: String?
    let idPendamping: [String]?
    
    enum CodingKeys: CodingKey {
        case lkNumber
        case engineerName
        case pendampingName
        case idPendamping
    }
}

struct ComplaintReffData: Codable {
    let page: String?
    let pageSize: String?
    let totalPage: String?
    let totalItem: String?
    
    enum CodingKeys: CodingKey {
        case page
        case pageSize
        case totalPage
        case totalItem
    }
}

struct ComplaintListEntity: Codable {
    let id: Int?
    let image: String?
    let date: String?
    let type: String?
    let title: String?
    let description: String?
    let technician: String?
    let damage: String?
    let status: CorrectiveStatusType?
    var isActionActive = false
}

enum CorrectiveStatusType: String, Codable {
    case open
    case closed
    case progress
    case delay
    case none
    
    init?(rawValue: String) {
        switch rawValue {
        case "Open": self = .open
        case "Closed": self = .closed
        case "Progress": self = .progress
        case "Progress(Delay)": self = .delay
        case "": self = .none
        default: self = .none
        }
    }
    
    func getStringValue() -> String {
        return rawValue
    }
}

enum CorrectiveTitleType: String {
    case advanced
    case accept
    case partner
    case none
    
    init?(rawValue: String) {
        switch rawValue {
        case "Korektif Lanjutan": self = .advanced
        case "Terima": self = .accept
        case "Pendamping": self = .partner
        case "": self = .none
        default: self = .none
        }
    }
    
    func getStringValue() -> String {
        return rawValue
    }
}

// MARK: - SELECT TECHNICIAN ENTITY
struct SelectTechnicianEntity: Codable {
    let count: Int?
    let data: Technician?
    let message: String?
    let status: Int?
    let reff: ReffData?
}

struct Technician: Codable {
    let users: [TechnicianData]?
}

struct TechnicianData: Codable {
    let valId: String?
    let txtName: String?
    let txtUsername: String?
    let valImage: String? = nil
    let valImageId: String? = nil
    let txtPosition: String?
    let txtUnitKerja: String?
    let valDeviceToken: String?
    let isPolisi: String?
    
    enum CodingKeys: CodingKey {
        case valId
        case txtName
        case txtUsername
        case valImage
        case valImageId
        case txtPosition
        case txtUnitKerja
        case valDeviceToken
        case isPolisi
    }
}

enum SelectTechnicianBottomSheetType {
    case selectOne
    case selectMultiple
}

struct TechnicianEntity: Codable, Hashable {
    let id: String?
    let name: String?
    var isSelected = false
    
    static func == (lhs: TechnicianEntity, rhs: TechnicianEntity) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

protocol SelectTechnicianBottomSheetDelegate: AnyObject {
    func didSelectTechnician(_ name: TechnicianEntity)
    func selectMultipleTechnician(_ names: [TechnicianEntity])
}

protocol CorrectiveCellDelegate: AnyObject {
    func didTapContinueCorrective(data: Complaint, title: CorrectiveTitleType)
    func didTapDeleteLk(data: Complaint)
}

// MARK: - ADVANCED CORRECTIVE RESPONSE
struct CreateLanjutanEntity: Codable {
    let data: LanjutanID?
    let message: String?
    let status: Int?
}

struct LanjutanID: Codable {
    let id: String?
}

// MARK: - ACCEPT CORRECTIVE RESPONSE
struct AcceptCorrectiveEntity: Codable {
    let count: Int?
    let data: AcceptCorrectiveData?
    let message: String?
    let status: Int?
    let reff: ReffData?
}

struct AcceptCorrectiveData: Codable {
    let woDetail: AcceptCorrectiveDetail?
}

struct AcceptCorrectiveDetail: Codable {
    let id: String?
    let valWoNumber: String?
    let valDate: String?
    let txtEngineerName: String?
    let valEngineerId: String?
    let valEngineerAvatar: String?
    let txtType: String?
    let valType: String?
    let complain: AcceptComplain?
    let txtHeader: String?
    let txtTitle: String?
    let txtSubTitle: String?
    let valIcon: AcceptValIcon?
    let valEquipmentId: String?
    let valStartTime: String?
    let valEndTime: String?
    let valDuration: String?
    let valStatus: String?
    let txtStatus: String?
    let valIsManagable: Bool?
    let valIsDoable: String?
    let valRating: String?
    let medias: [Media]?
    let valCanRating: String?
    let valDelegatedTime: String?
    let txtFinishStatus: String?
    let isPendamping: String?
    let equipment: AcceptEquipment?
    let valDescriptions: String?
    let txtDescriptions: String?
    let taskList: [String]?
    let valLaik: String?
    let txtLaik: String?
    let approveBy: String?
    let canPendamping: String?
    let infoLk: InfoLk?
    let sttQr: String?
    let namaPerating: String?
    
    enum CodingKeys: String, CodingKey {
        case id, valWoNumber, valDate, txtEngineerName, valEngineerId, valEngineerAvatar, txtType, valType, complain, txtHeader, txtTitle, txtSubTitle, valIcon, valEquipmentId, valStartTime, valEndTime, valDuration, valStatus, txtStatus, valIsManagable, valIsDoable, valRating, medias, valCanRating, valDelegatedTime, txtFinishStatus, isPendamping, equipment, valDescriptions, txtDescriptions, taskList, valLaik, txtLaik, approveBy, canPendamping, infoLk = "infoLk", sttQr = "stt_qr", namaPerating
    }
}

struct AcceptComplain: Codable {
    let id: Int?
    let txtTitle: String?
    let txtDescriptions: String?
    let txtStatus: String?
    let valStatus: String?
    let txtSenderName: String?
    let valSenderImg: String?
    let equipment: AcceptEquipment?
    let txtFinishedDate: String?
    let txtComplainTime: String?
    let txtDownTime: String?
    let txtResponseTime: String?
    let valIsManagable: Int?
    let valObservation: Int?
    let valCorrective: Int?
    let valWoList: [AcceptValWoList]?
    let valDelegatedTime: String?
    let valDelegatable: Bool?
    let medias: [Media]?
    let txtEngineerName: String?
    let userIDfinish: String?
    let isDelay: String?
    let canPendamping: String?
    let infoLk: InfoLk?
    let canDeleteLk: Bool
    let idLkActive: String?
    let namaPelapor: String?
    
    enum CodingKeys: String, CodingKey {
        case id, txtTitle, txtDescriptions, txtStatus, valStatus, txtSenderName, valSenderImg, equipment, txtFinishedDate, txtComplainTime, txtDownTime, txtResponseTime, valIsManagable, valObservation, valCorrective, valWoList, valDelegatedTime, valDelegatable, medias, txtEngineerName, userIDfinish, isDelay, canPendamping, infoLk, canDeleteLk, idLkActive, namaPelapor
    }
}

struct AcceptEquipment: Codable {
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
    let statusKalibrasi: StatusKalibrasi?
    let sttQr: String?
    let txtLokasiInstalasi: String?
    let idAlat: String?
    let isNonmedik: String?
    let lkStatic: String?
    let klpNonmedik: String?
    let klpNonmedikName: String?
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
    
    enum CodingKeys: String, CodingKey {
        case id, txtName, valImage, valQR, valQRProperties, txtRuangan, valRoomId, txtRoomId, txtSubRuangan, txtLokasiName, txtSerial, txtBrand, txtType, txtInventaris, txtTahun, txtDescriptions, txtLastWoStatus, badgeAsset, badgeTeknis, txtUsiaTeknis, txtDistributor, syncSimak, codeSimak, nameSimak, syncSimbada, codeSimbada, nameSimbada, syncAspak, statusKalibrasi, sttQr = "stt_qr", txtLokasiInstalasi, idAlat, isNonmedik, lkStatic, klpNonmedik, klpNonmedikName, valRusak, txtRusak, valKalibrasi, txtKalibrasi, valKorektif, txtKorektif, valPreventif, txtPreventif, valIsComplainable, txtCantComplainReason, txtInfoUpdate
    }
}

struct AcceptValWoList: Codable {
    let id: String?
    let lkNumber: String?
    let lkDate: String?
    let engineerName: String?
    let valStatus: String?
    let statusText: String?
}

struct AcceptValIcon: Codable {
    let bg: String?
    let fo: String?
    let lbl: String?
}

struct DeleteComplaintEntity: Codable {
    let data: DeleteComplaintData?
    let message: String?
    let status: Int?
}

struct DeleteComplaintData: Codable {
    let complainId: String?
    
    enum CodingKeys: String, CodingKey {
        case complainId = "complain_id"
    }
}

struct DeleteComplaintResponseEntity: Codable {
    let count: Int?
    let data: DeleteComplaintResponseData?
    let message: String?
    let status: Int?
    let reff: ReffData?
}

struct DeleteComplaintResponseData: Codable {
    let message: String?
    
    enum CodingKeys: CodingKey {
        case message
    }
}

