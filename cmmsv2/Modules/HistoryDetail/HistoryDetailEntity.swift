//
//  HistoryDetailEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 18/05/24.
//

import Foundation

struct HistoryDetailEntity: Codable {
    let count: Int?
    let data: HistoryDetailData?
    let message: String?
    let status: Int?
    let reff: ReffData?
    
    struct HistoryDetailData: Codable {
        let woDetail: HistoryDetailWorkOrder?
        
        struct HistoryDetailWorkOrder: Codable {
            let id, valWoNumber, valDate, txtEngineerName: String?
            let valEngineerId, valEngineerAvatar, txtType, valType: String?
            let complain: Complain?
            let txtHeader, txtTitle, txtSubTitle: String?
            let valIcon: ValIcon?
            let valEquipmentId, valStartTime, valEndTime, valDuration: String?
            let valStatus, txtStatus, valIsDoable: String?
            let valIsManagable: Bool?
            let valRating: String?
            let medias: [Media]?
            let valCanRating, valDelegatedTime, txtFinishStatus, isPendamping: String?
            let equipment: Equipment?
            let valDescriptions, txtDescriptions, valLaik, txtLaik: String?
            let approveBy, canPendamping: String?
            let infoLk: InfoLk?
            let stt_qr, nama_perating: String?
            let taskList: [HistoryTask]?
            
            struct Complain: Codable {
                let id: Int?
                let txtTitle, txtDescriptions, txtStatus, valStatus: String?
                let txtSenderName, valSenderImg: String?
                let equipment: Equipment?
                let txtFinishedDate, txtComplainTime, txtDownTime, txtResponseTime: String?
                let valIsManagable, valObservation, valCorrective: Int?
                let valWoList: [ValWoList]?
                let valDelegatedTime: String?
                let valDelegatable: Bool?
                let medias: [Media]?
                let txtEngineerName, userIDfinish, isDelay, canPendamping: String?
                let infoLk: InfoLk?
                let canDeleteLk: Bool?
                let idLkActive, nama_pelapor: String?
                
                struct Equipment: Codable {
                    let id: Int?
                    let txtName, valImage, valQR: String?
                    let valQRProperties: ValQRProperties?
                    let txtRuangan, txtRoomId, txtSubRuangan: String?
                    let valRoomId: Int?
                    let txtLokasiName, txtSerial, txtBrand, txtType: String?
                    let txtInventaris, txtTahun, txtDescriptions, txtLastWoStatus: String?
                    let badgeAsset, badgeTeknis, txtUsiaTeknis, txtDistributor: String?
                    let syncSimak, codeSimak, nameSimak, syncSimbada: String?
                    let codeSimbada, nameSimbada, syncAspak: String?
                    let statusKalibrasi: StatusKalibrasi?
                    let stt_qr, txtLokasiInstalasi, id_alat, is_nonmedik: String?
                    let lk_static, klp_nonmedik, klp_nonmedik_name: String?
                    let txtRusak, txtKalibrasi: String?
                    let valKalibrasi: Int?
                    let valRusak: Int?
                    let txtKorektif, txtPreventif: String?
                    let valPreventif: Int?
                    let valKorektif: Int?
                    let txtCantComplainReason, txtInfoUpdate: String?
                    let valIsComplainable: Int
                    
                    struct ValQRProperties: Codable {
                        let id, coders, codenom: String?
                    }
                    
                    struct StatusKalibrasi: Codable {
                        let last, next, exp, color: String?
                    }
                }
                
                struct ValWoList: Codable {
                    let id, lkNumber, lkDate, engineerName: String?
                    let valStatus, statusText: String?
                }
                
                struct Media: Codable {
                    let id: String?
                    let valUrl, valThumburl: String?
                }
                
                struct InfoLk: Codable {
                    let lkNumber, engineerName, pendampingName: String?
                    let idPendamping: [String]?
                }
            }
            
            struct ValIcon: Codable {
                let bg, fo, lbl: String?
            }
            
            struct Media: Codable {
                let id: String?
                let valUrl, valThumburl: String?
            }
            
            struct Equipment: Codable {
                let id: Int?
                let txtName, valImage, valQR: String?
                let valQRProperties: ValQRProperties?
                let txtRuangan, txtRoomId, txtSubRuangan: String?
                let valRoomId: Int?
                let txtLokasiName, txtSerial, txtBrand, txtType: String?
                let txtInventaris, txtTahun, txtDescriptions, txtLastWoStatus: String?
                let badgeAsset, badgeTeknis, txtUsiaTeknis, txtDistributor: String?
                let syncSimak, codeSimak, nameSimak, syncSimbada: String?
                let codeSimbada, nameSimbada, syncAspak: String?
                let statusKalibrasi: StatusKalibrasi?
                let stt_qr, txtLokasiInstalasi, id_alat, is_nonmedik: String?
                let lk_static, klp_nonmedik, klp_nonmedik_name: String?
                let txtRusak, txtKalibrasi: String?
                let valKalibrasi: Int?
                let valRusak: Int?
                let txtKorektif, txtPreventif: String?
                let valPreventif: Int?
                let valKorektif: Int?
                let txtCantComplainReason, txtInfoUpdate: String?
                let valIsComplainable: Int
                
                struct ValQRProperties: Codable {
                    let id, coders, codenom: String?
                }
                
                struct StatusKalibrasi: Codable {
                    let last, next, exp, color: String?
                }
            }
            
            struct HistoryTask: Codable {
                let valId, txtName, txtDesc, valDurasi: String?
                let txtJenis, txtAdditionalNotes: String?
                let valStatus: Int?
            }
            
            struct InfoLk: Codable {
                let lkNumber, engineerName, pendampingName: String?
                let idPendamping: [String]?
            }
        }
    }
}
