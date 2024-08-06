//
//  Endpoint.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import Foundation
import Alamofire

enum Endpoint {
    case registerHospital(code: String)
    case loginUser(username: String, password: String)
    case getProfile
    case updateProfile(
        name: String,
        position: String,
        workUnit: String,
        imageId: Int,
        phoneNumber: String)
    case changePassword(
        oldPassword: String,
        passwordConfirm: String,
        password: String)
    case assetList(
        search: String? = nil,
        condition: String? = nil,
        limit: Int? = nil,
        type: String? = nil,
        sttKalibrasi: String? = nil,
        category: String? = nil,
        sort: String? = nil,
        sttQr: String? = nil,
        idInstallation: String? = nil,
        idRoom: String? = nil,
        page: Int? = nil)
    case infoExpired
    case detailAssetEquipment(id: String)
    case getNotification(page: Int? = nil, limit: Int? = nil)
    case getComplaintList(
        page: Int? = nil,
        limit: Int? = nil,
        equipmentId: String? = nil,
        status: String? = nil,
        dateFilter: String? = nil,
        keyword: String? = nil)
    case workSheetMonitoringFunction(
        limit: Int? = nil,
        page: Int? = nil,
        tipe: Int? = nil,
        keyword: String? = nil,
        status: Int? = nil
    )
    case workSheetCorrective(
        woType: Int? = nil,
        woStatus: String? = nil,
        limit: Int? = nil,
        sort: String? = nil,
        hasObstacle: Int? = nil,
        keyword: String? = nil,
        page: Int? = nil
    )
    case workSheetPreventive(
        limit: Int? = nil,
        sort: String? = nil,
        keyword: String? = nil,
        idInstallation: String? = nil,
        status: String? = nil,
        page: Int? = nil)
    case calibrationList(
        keyword: String? = nil,
        limit: Int? = nil,
        page: Int? = nil)
    case logBookList(
        limit: Int? = nil,
        page: Int? = nil,
        date: String? = nil)
    case calendarPreventiveList(idEngineer: String? = nil, month: String? = nil)
    case schedulePreventiveList(
        date: String? = nil,
        page: Int? = nil,
        limit: Int? = nil)
    case assetDetail(id: String?)
    case assetMainCost(id: String?)
    case assetTechnical(id: String?)
    case assetAcceptance(id: String?)
    case assetFiles(id: String?)
    case complaintDetail(id: Int?)
    case workSheetDetail(id: String, action: String)
    case detailHistory(id: String?)
    case loadPreventive(id: String?)
    case delayCorrectiveDetail(id: String?)
    case calibrator
    case userFilter(job: String?)
    case createLanjutan(
        engineerId: String,
        complainId: String,
        dueDate: String,
        engineerPendamping: [String])
    case createCorrective(
        engineerId: String,
        complainId: String,
        dueDate: String,
        engineerPendamping: [String])
    case createPreventive(data: CreatePreventiveRequest)
    case searchSparePart(key: String? = nil)
    case saveWorkSheet(data: LKStartRequest)
    case getInstallation
    case approvalList(
        woType: String?,
        woStatus: String?,
        limit: Int?,
        page: Int?)
    case approveWorkSheet(data: ApproveWorkSheetRequest)
    case trackComplaint(id: String?)
    case loadTechnical(id: String?)
    case saveTechnical(data: EditTechnicalRequestEntity)
    case reminderPreventive(date: String?)
    case equipmentMainStatus(id: String?)
    case inspection(
        limit: Int,
        id: String?,
        page: Int)
    case equipmentComplaint(
        limit: Int,
        id: String?,
        page: Int
    )
}

// MARK: - PATH URL
extension Endpoint {
    
    func path() -> String {
        switch self {
        case .registerHospital:
            return "auth/rs"
        case .loginUser:
            return "auth/user"
        case .getProfile:
            return "profile"
        case .updateProfile:
            return "profile/update"
        case .changePassword:
            return "profile/change_password"
        case .assetList(
            search: let search,
            condition: let condition,
            limit: let limit,
            type: let type,
            sttKalibrasi: let sttKalibrasi,
            category: let category,
            sort: let sort,
            sttQr: let sttQr,
            idInstallation: let idIntallation,
            idRoom: let idRoom,
            page: let page):
            return generateEquipmentListURL(
                search: search,
                condition: condition,
                limit: limit,
                type: type,
                sttKalibrasi: sttKalibrasi,
                category: category,
                sort: sort,
                sttQr: sttQr,
                idInstallation: idIntallation,
                idRoom: idRoom,
                page: page)
        case .infoExpired:
            return "info/expired"
        case .detailAssetEquipment(let id):
            return "equipments/view/\(id)"
        case .getNotification(let page, let limit):
            return generateNotificationListURL(page: page, limit: limit)
        case .getComplaintList(
            let page,
            let limit,
            let equipmentId,
            let status,
            let dateFilter,
            let keyword):
            return generateComplaintListURL(
                page: page,
                limit: limit,
                equipmentId: equipmentId,
                status: status,
                dateFilter: dateFilter,
                keyword: keyword)
        case .workSheetMonitoringFunction(
            limit: let limit,
            page: let page,
            tipe: let tipe,
            keyword: let keyword,
            status: let status):
            return generateWorkSheetMonitoringFunctionURL(limit: limit, page: page, tipe: tipe, keyword: keyword, status: status)
        case .workSheetCorrective(
            woType: let woType,
            woStatus: let woStatus,
            limit: let limit,
            sort: let sort,
            hasObstacle: let hasObstacle,
            keyword: let keyword,
            page: let page):
            return generateWorkSheetCorrectiveURL(woType: woType, woStatus: woStatus, limit: limit, sort: sort, hasObstacle: hasObstacle, keyword: keyword, page: page)
        case .workSheetPreventive(
            limit: let limit,
            sort: let sort,
            keyword: let keyword,
            idInstallation: let idInstallation,
            status: let status,
            page: let page):
            return generateWorkSheetPreventiveURL(
                limit: limit,
                sort: sort,
                keyword: keyword,
                idInstallation: idInstallation,
                status: status,
                page: page)
        case .calibrationList(keyword: let keyword, limit: let limit, page: let page):
            return generateCalibrationURL(keyword: keyword, limit: limit, page: page)
        case .logBookList(limit: let limit, page: let page, date: let date):
            return generateLogBookURL(limit: limit, page: page, date: date)
        case .calendarPreventiveList(idEngineer: let idEngineer, month: let month):
            return "lk/kalender_preventif?id_engineer=\(idEngineer ?? "")&bulan=\(month ?? "")"
        case .schedulePreventiveList(date: let date, let page, let limit):
            return generateSchedulePreventiveURL(date: date ?? "", page: page ?? 0, limit: limit ?? 0)
        case .assetDetail(id: let id):
            return "equipments/view?id=\(id ?? "")"
        case .assetMainCost(id: let id):
            return "equipments/maincost?id=\(id ?? "")"
        case .assetTechnical(id: let id):
            return "equipments/technical?id=\(id ?? "")"
        case .assetAcceptance(id: let id):
            return "equipments/penerimaan?id=\(id ?? "")"
        case .assetFiles(id: let id):
            return "equipments/files?id=\(id ?? "")"
        case .complaintDetail(id: let id):
            return "complains/detail?id=\(id ?? 0)"
        case .workSheetDetail:
            return "lk/start"
        case .detailHistory(id: let id):
            return "lk/detail?id=\(id ?? "")"
        case .loadPreventive(id: let id):
            return "lk/load_preventif?id=\(id ?? "")"
        case .delayCorrectiveDetail(id: let id):
            return "complains/detail?id=\(id ?? "")"
        case .calibrator:
            return "lk/kalibrator"
        case .userFilter(job: let job):
            return "user/search?job=\(job ?? "")"
        case .createLanjutan:
            return "lk/create_lanjutan"
        case .createCorrective:
            return "lk/create_korektif"
        case .createPreventive:
            return "lk/create_preventif"
        case .searchSparePart(key: let key):
            return "lk/search_sparepart?q=\(key ?? "")"
        case .saveWorkSheet:
            return "lk/save_lk"
        case .getInstallation:
            return "penerimaan/get_installasi"
        case .approvalList(
            woType: let woType,
            woStatus: let woStatus,
            limit: let limit,
            page: let page):
            return generateApprovalURL(
                woType: woType,
                woStatus: woStatus,
                limit: limit,
                page: page)
        case .approveWorkSheet:
            return "lk/approve"
        case .trackComplaint(id: let id):
            return "equipments/track_complain?id=\(id ?? "")"
        case .loadTechnical(id: let id):
            return "equipments/load_teknis?id=\(id ?? "")"
        case .saveTechnical:
            return "equipments/save_teknis"
        case .reminderPreventive(date: let date):
            return "lk/reminder_preventif?tanggal=\(date ?? "")"
        case .equipmentMainStatus(id: let id):
            return "equipments/mainstatus?id=\(id ?? "")"
        case .inspection(limit: let limit, id: let id, page: let page):
            return generateInspectionURL(limit: limit, id: id, page: page)
        case .equipmentComplaint(limit: let limit, id: let id, page: let page):
            return generateEquipmentComplaintURL(limit: limit, id: id ?? "", page: page)
        }
    }
    
}

// MARK: - METHOD
extension Endpoint {
    
    func method() -> HTTPMethod {
        switch self {
        case .registerHospital,
                .loginUser,
                .updateProfile,
                .changePassword,
                .workSheetDetail,
                .createLanjutan,
                .createCorrective,
                .createPreventive,
                .saveWorkSheet,
                .approveWorkSheet,
                .saveTechnical:
            return .post
        default:
            return .get
        }
    }
    
}

// MARK: - PARAMETER
extension Endpoint {
    
    var parameter: [String: Any]? {
        switch self {
        case .registerHospital(let code):
            let params: [String: Any] = [
                "code": code
            ]
            return params
        case .loginUser(let username, let password):
            let params: [String: Any] = [
                "username": username,
                "password": password
            ]
            return params
        case .updateProfile(let name, let position, let workUnit, let imageId, let phoneNumber):
            let params: [String: Any] = [
                "name": name,
                "jabatan": position,
                "unit_kerja": workUnit,
                "image_id": imageId,
                "telepon": phoneNumber
            ]
            return params
        case .changePassword(let oldPassword, let passwordConfirm, let password):
            let params: [String: Any] = [
                "old_password": oldPassword,
                "password_confirmation": passwordConfirm,
                "password": password
            ]
            return params
        case .workSheetDetail(let id, let action):
            let params: [String: Any] = [
                "id_lk": id,
                "aksi": action
            ]
            return params
        case .createLanjutan(engineerId: let engineerId, complainId: let complainId, dueDate: let dueDate, engineerPendamping: let engineerPendamping):
            let params: [String: Any] = [
                "engineer_id": engineerId,
                "complain_id": complainId,
                "due_date": dueDate,
                "engineer_pendamping": engineerPendamping
            ]
            return params
        case .createCorrective(engineerId: let engineerId, complainId: let complainId, dueDate: let dueDate, engineerPendamping: let engineerPendamping):
            let params: [String: Any] = [
                "engineer_id": engineerId,
                "complain_id": complainId,
                "due_date": dueDate,
                "engineer_pendamping": engineerPendamping
            ]
            return params
        case .createPreventive(data: let data):
            let params: [String: Any] = [
                "id_asset": data.idAsset ?? "",
                "varian": data.varian ?? "",
                "date": data.date ?? ""
            ]
            return params
        case .saveWorkSheet(data: let data):
            let params: [String: Any?] = [
                "abai_listrik": data.abaiListrik,
                "abai_pemantauan": data.abaiPemantauan,
                "abai_persiapan": data.abaiPersiapan,
                "abai_preventif": data.abaiPreventif,
                "alat_kalibrasi": data.alatKalibrasi,
                "analisa": data.analisa,
                "approve_by": data.approveBy,
                "asset": [
                    "assetname": data.asset?.assetname,
                    "brandname": data.asset?.brandname,
                    "id_asset": data.asset?.idAsset,
                    "imgurl": data.asset?.imgurl,
                    "roomname": data.asset?.roomname,
                    "sarananame": data.asset?.sarananame,
                    "serial": data.asset?.serial,
                    "thumburl": data.asset?.thumburl,
                    "typename": data.asset?.typename
                ],
                "com_respon": data.comRespon,
                "com_time": data.comTime,
                "create_at": data.createAt,
                "create_by": data.createBy,
                "dipindahkan": data.dipindahkan,
                "downtime": data.downtime,
                "engineername": data.engineername,
                "id_asset": data.idAsset,
                "id_complain": data.idComplain,
                "id_kalibrator": data.idKalibrator,
                "id_lk": data.idLk,
                "id_relokasi": data.idRelokasi,
                "jenis_relokasi": data.jenisRelokasi,
                "keluhan": data.keluhan,
                "listrik": data.listrik?.map { listrik in
                    [
                        "ambang_batas": listrik.ambangBatas,
                        "desc": listrik.desc,
                        "key": listrik.key,
                        "label": listrik.label,
                        "val_ukur": listrik.valUkur
                    ]
                } ?? [],
                "lk_assign": data.lkAssign,
                "lk_continue": data.lkContinue,
                "lk_date": data.lkDate,
                "lk_durasireal": data.lkDurasireal,
                "lk_engineer": data.lkEngineer,
                "lk_finish": data.lkFinish,
                "lk_finishstt": data.lkFinishstt,
                "lk_info": data.lkInfo,
                "lk_jenis": data.lkJenis,
                "lk_kegiatan": data.lkKegiatan,
                "lk_label": data.lkLabel,
                "lk_number": data.lkNumber,
                "lk_pelapor": data.lkPelapor,
                "lk_rating": data.lkRating,
                "lk_start": data.lkStart,
                "lk_status": data.lkStatus,
                "lk_varian": data.lkVarian,
                "lk_webenable": data.lkWebenable,
                "lkphoto": data.lkphoto?.map { lkphoto in
                    [
                        "filename": lkphoto.filename,
                        "id_lkphoto": lkphoto.idLkphoto,
                        "note": lkphoto.note,
                        "photoUrl": lkphoto.photoUrl,
                        "photo_id": lkphoto.photoID
                    ]
                } ?? [],
                "metode": data.metode,
                "newpart": data.newpart?.map { newpart in
                    [
                        "id_lknewpart": newpart.idLknewpart,
                        "id_part": newpart.idPart,
                        "jumlah": newpart.jumlah,
                        "partname": newpart.partname
                    ]
                } ?? [],
                "pemantauan": data.pemantauan?.map { pemantauan in
                    [
                        "fisik": pemantauan.fisik,
                        "fisik_text": pemantauan.fisikText,
                        "fungsi": pemantauan.fungsi,
                        "fungsi_text": pemantauan.fungsiText,
                        "key": pemantauan.key,
                        "label": pemantauan.label
                    ]
                } ?? [],
                "persiapan": data.persiapan?.map { persiapan in
                    [
                        "key": persiapan.key,
                        "label": persiapan.label,
                        "value": persiapan.value,
                        "value_text": persiapan.valueText
                    ]
                } ?? [],
                "preventif": data.preventif?.map { preventif in
                    [
                        "key": preventif.key,
                        "label": preventif.label,
                        "value": preventif.value,
                        "value_text": preventif.valueText
                    ]
                } ?? [],
                "rate_by": data.rateBy,
                "sparepart": data.sparepart?.map { sparepart in
                    [
                        "harga": sparepart.harga,
                        "id_lksparepart": sparepart.idLksparepart,
                        "id_part": sparepart.idPart,
                        "jumlah": sparepart.jumlah,
                        "jumlah_total": sparepart.jumlahTotal,
                        "partname": sparepart.partname
                    ]
                } ?? [],
                "stt_laik": data.sttLaik,
                "task": data.task?.map { task in
                    [
                        "id_lktask": task.idLktask,
                        "lk_task": task.lkTask
                    ]
                } ?? []
            ]
            
            let filteredParams = params.compactMapValues { $0 }
            
            return filteredParams
        case .approveWorkSheet(let data):
            let params: [String: Any] = [
                "wo_id": data.woId ?? "",
                "status": data.status ?? ""
            ]
            return params
        case .saveTechnical(let data):
            let params: [String: Any] = [
                "frekuensi": data.frekuensi,
                "fungsi": data.fungsi,
                "id_asset": data.idAsset,
                "insiden": data.insiden,
                "klsresiko": data.klsresiko,
                "melopsi": data.melopsi,
                "pemeliharaan": data.pemeliharaan,
                "pengganti": data.pengganti,
                "power": data.power,
                "priority": data.priority,
                "recpengganti": data.recpengganti,
                "resiko": data.resiko,
                "tech": data.tech,
                "urut_medik": data.urutMedik,
                "usia": data.usia,
                "year": data.year
            ]
            return params
        default:
            return nil
        }
    }
    
}

// MARK: - HEADER
extension Endpoint {
    
    var header: HTTPHeaders {
        switch self {
        case .registerHospital:
            let params: HTTPHeaders = [
                "Authorizations": "TokenTriluxCMMS+",
                "Content-Type": "application/json",
                "Accept": "*/*"
            ]
            return params
        default:
            let params: HTTPHeaders = [
                "Authorizations": Constants.token,
                "Content-Type": "application/json",
                "Accept": "*/*"
            ]
            return params
        }
    }
    
}

// MARK: - GENERATE URL
extension Endpoint {
    
    func urlString() -> String {
        switch self {
        case .registerHospital:
            return Constants.rsURL + path()
        default:
            return Constants.baseURL + path()
        }
    }
    
}

// MARK: - GENERATE ENDPOINT
extension Endpoint {
    
    private func generateEquipmentListURL(
        search: String? = nil,
        condition: String? = nil,
        limit: Int? = nil,
        type: String? = nil,
        sttKalibrasi: String? = nil,
        category: String? = nil,
        sort: String? = nil,
        sttQr: String? = nil,
        idInstallation: String? = nil,
        idRoom: String? = nil,
        page: Int? = nil
    ) -> String {
        let queryString = [
            search.map { "search=\($0)" },
            condition.map { "kondisi=\($0)" },
            limit.map { "limit=\($0)" },
            type.map { "jenis=\($0)" },
            sttKalibrasi.map { "stt_kalibrasi=\($0)" },
            category.map { "kategori=\($0)" },
            sort.map { "sort=\($0)" },
            sttQr.map { "stt_qr=\($0)" },
            idInstallation.map { "id_instalasi=\($0)" },
            idRoom.map { "id_room=\($0)" },
            page.map { "page=\($0)" },
        ].compactMap { $0 }.joined(separator: "&")
        
        let url = "equipments/list" + (queryString.isEmpty ? "" : "?\(queryString)")
        
        return url.replacingOccurrences(of: " ", with: "%20")
    }
    
    private func generateNotificationListURL(page: Int? = nil, limit: Int? = nil) -> String {
        let queryString = [
            page.map { "page=\($0)" },
            limit.map { "limit=\($0)" }
        ].compactMap { $0 }.joined(separator: "&")
        
        let url = "notifications" + (queryString.isEmpty ? "" : "?\(queryString)")
        
        return url.replacingOccurrences(of: " ", with: "%20")
    }
    
    private func generateComplaintListURL(
        page: Int? = nil,
        limit: Int? = nil,
        equipmentId: String? = nil,
        status: String? = nil,
        dateFilter: String? = nil,
        keyword: String? = nil
    ) -> String {
        let queryString = [
            limit.map { "limit=\($0)" },
            page.map { "page=\($0)" },
            status.map { "status=\($0)" },
            keyword.map { "keyword=\($0)" },
            dateFilter.map { "date_filter=\($0)" },
            equipmentId.map { "equipment_id=\($0)" }
        ].compactMap { $0 }.joined(separator: "&")
        
        let url = "complains/list" + (queryString.isEmpty ? "" : "?\(queryString)")
        
        return url.replacingOccurrences(of: " ", with: "%20")
    }
    
    private func generateWorkSheetMonitoringFunctionURL(
        limit: Int? = nil,
        page: Int? = nil,
        tipe: Int? = nil,
        keyword: String? = nil,
        status: Int? = nil
    ) -> String {
        let queryString = [
            limit.map { "limit=\($0)" },
            page.map { "page=\($0)" },
            tipe.map { "tipe=\($0)" },
            keyword.map { "keyword=\($0)" },
            status.map { "status=\($0)" }
        ].compactMap { $0 }.joined(separator: "&")
        
        let url = "lk/index" + (queryString.isEmpty ? "" : "?\(queryString)")
        
        return url.replacingOccurrences(of: "", with: "%20")
    }
    
    private func generateWorkSheetCorrectiveURL(
        woType: Int? = nil,
        woStatus: String? = nil,
        limit: Int? = nil,
        sort: String? = nil,
        hasObstacle: Int? = nil,
        keyword: String? = nil,
        page: Int? = nil
    ) -> String {
        let queryString = [
            woType.map { "wo_type=\($0)" },
            woStatus.map { "wo_status=\($0)" },
            limit.map { "limit=\($0)" },
            sort.map { "sort=\($0)" },
            hasObstacle.map { "has_obstacle=\($0)" },
            keyword.map { "keyword=\($0)" },
            page.map { "page=\($0)" }
        ].compactMap { $0 }.joined(separator: "&")
        
        let url = "lk/list" + (queryString.isEmpty ? "" : "?\(queryString)")
        
        return url.replacingOccurrences(of: "", with: "%20")
    }
    
    private func generateWorkSheetPreventiveURL(
        limit: Int? = nil,
        sort: String? = nil,
        keyword: String? = nil,
        idInstallation: String? = nil,
        status: String? = nil,
        page: Int? = nil
    ) -> String {
        let queryString = [
            limit.map { "limit=\($0)" },
            sort.map { "sort=\($0)" },
            keyword.map { "keyword=\($0)" },
            idInstallation.map { "id_instalasi=\($0)" },
            status.map { "status=\($0)" },
            page.map { "page=\($0)" }
        ].compactMap { $0 }.joined(separator: "&")
        
        let url = "lk/listpreventif" + (queryString.isEmpty ? "" : "?\(queryString)")
        
        return url.replacingOccurrences(of: "", with: "%20")
    }
    
    private func generateLogBookURL(
        limit: Int? = nil,
        page: Int? = nil,
        date: String? = nil
    ) -> String {
        let queryString = [
            limit.map { "limit=\($0)" },
            page.map { "page=\($0)" },
            date.map { "tanggal=\($0)" }
        ].compactMap { $0 }.joined(separator: "&")
        
        let url = "profile/logbook" + (queryString.isEmpty ? "" : "?\(queryString)")
        
        return url.replacingOccurrences(of: "", with: "%20")
    }
    
    private func generateSchedulePreventiveURL(
        date: String? = nil,
        page: Int? = nil,
        limit: Int? = nil
    ) -> String {
        let queryString = [
            date.map { "tanggal=\($0)" },
            page.map { "page=\($0)" },
            limit.map { "limit=\($0)" }
        ].compactMap { $0 }.joined(separator: "&")
        
        let url = "lk/jadwal_preventif" + (queryString.isEmpty ? "" : "?\(queryString)")
        
        return url.replacingOccurrences(of: "", with: "%20")
    }
    
    private func generateCalibrationURL(
        keyword: String? = nil,
        limit: Int? = nil,
        page: Int? = nil
    ) -> String {
        let queryString = [
            keyword.map { "keyword=\($0)" },
            limit.map { "limit=\($0)" },
            page.map { "page=\($0)" }
        ].compactMap { $0 }.joined(separator: "&")
        
        let url = "lk/listkalibrasi" + (queryString.isEmpty ? "" : "?\(queryString)")
        
        return url.replacingOccurrences(of: "", with: "%20")
    }
    
    private func generateInspectionURL(
        limit: Int? = nil,
        id: String? = nil,
        page: Int? = nil
    ) -> String {
        let queryString = [
            limit.map { "limit=\($0)" },
            id.map { "id=\($0)" },
            page.map { "page=\($0)" }
        ].compactMap { $0 }.joined(separator: "&")
        
        let url = "equipments/inspeksi" + (queryString.isEmpty ? "" : "?\(queryString)")
        
        return url.replacingOccurrences(of: "", with: "%20")
    }
    
    private func generateEquipmentComplaintURL(
        limit: Int? = nil,
        id: String? = nil,
        page: Int? = nil
    ) -> String {
        let queryString = [
            limit.map { "limit=\($0)" },
            id.map { "id=\($0)" },
            page.map { "page=\($0)" }
        ].compactMap { $0 }.joined(separator: "&")
        
        let url = "equipments/pengaduan" + (queryString.isEmpty ? "" : "?\(queryString)")
        
        return url.replacingOccurrences(of: "", with: "%20")
    }
    
    private func generateApprovalURL(
        woType: String? = nil,
        woStatus: String? = nil,
        limit: Int? = nil,
        page: Int? = nil
    ) -> String {
        let queryString = [
            woType.map { "wo_type=\($0)" },
            woStatus.map { "wo_status=\($0)" },
            limit.map { "limit=\($0)" },
            page.map { "page=\($0)" }
        ].compactMap { $0 }.joined(separator: "&")
        
        let url = "lk/listapprove" + (queryString.isEmpty ? "" : "?\(queryString)")
        
        return url.replacingOccurrences(of: "", with: "%20")
    }
    
}
