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
        serial: String? = nil,
        locationId: String? = nil,
        limit: Int? = nil,
        page: Int? = nil,
        search: String? = nil,
        type: String? = nil,
        sstMedic: String? = nil)
    case infoExpired
    case uploadProfile(file: URL)
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
        page: Int? = nil,
        engineer: Int? = nil)
    case calibrationList(keyword: String? = nil, limit: Int? = nil, page: Int? = nil)
    case logBookList(
        limit: Int? = nil,
        page: Int? = nil,
        date: String? = nil)
    case calendarPreventiveList(idEngineer: String? = nil, month: String? = nil)
    case schedulePreventiveList(
        idEngineer: String? = nil,
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
            let serial,
            let locationId,
            let limit,
            let page,
            let search,
            let type,
            let sstMedic):
            return generateEquipmentListURL(
                serial: serial,
                locationID: locationId,
                limit: limit,
                page: page,
                search: search,
                type: type,
                sttMedic: sstMedic)
        case .infoExpired:
            return "info/expired"
        case .uploadProfile:
            return "media/uploadprofile"
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
            keyword: let keyboard,
            status: let status):
            return generateWorkSheetMonitoringFunctionURL(limit: limit, page: page, tipe: tipe, keyboard: keyboard, status: status)
        case .workSheetCorrective(
            woType: let woType,
            woStatus: let woStatus,
            limit: let limit,
            sort: let sort,
            hasObstacle: let hasObstacle,
            keyword: let keyword,
            page: let page):
            return generateWorkSheetCorrectiveURL(woType: woType, woStatus: woStatus, limit: limit, sort: sort, hasObstacle: hasObstacle, keyword: keyword, page: page)
        case .workSheetPreventive(limit: let limit,
                                  page: let page,
                                  engineer: let engineer):
            return generateWorkSheetPreventiveURL(
                limit: limit,
                page: page,
                engineer: engineer)
        case .calibrationList(keyword: let keyword, limit: let limit, page: let page):
            return generateCalibrationURL(keyword: keyword, limit: limit, page: page)
        case .logBookList(limit: let limit, page: let page, date: let date):
            return generateLogBookURL(limit: limit, page: page, date: date)
        case .calendarPreventiveList(idEngineer: let idEngineer, month: let month):
            return "lk/kalender_preventif?id_engineer=\(idEngineer ?? "")&bulan=\(month ?? "")"
        case .schedulePreventiveList(let idEngineer, date: let date, let page, let limit):
            return generateSchedulePreventiveURL(idEngineer: idEngineer ?? "", date: date ?? "", page: page ?? 0, limit: limit ?? 0)
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
                .uploadProfile,
                .workSheetDetail:
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
        case .uploadProfile(let file):
            let formData: MultipartFormData = MultipartFormData()
            formData.append(file, withName: "file", fileName: "filename.jpg", mimeType: "image/jpeg")
            
            let params: [String: Any] = [
                "file": formData
            ]
            
            for (key, value) in params {
                if let data = "\(value)".data(using: .utf8) {
                    formData.append(data, withName: key)
                }
            }
            
            return params
        case .workSheetDetail(let id, let action):
            let params: [String: Any] = [
                "id_lk": id,
                "aksi": action
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
        case .uploadProfile:
            let params: HTTPHeaders = [
                "Content-Type": "application/x-www-form-urlencoded",
                "Authorizations": Constants.token,
                "RequestType": "api",
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
        serial: String? = nil,
        locationID: String? = nil,
        limit: Int? = nil,
        page: Int? = nil,
        search: String? = nil,
        type: String? = nil,
        sttMedic: String? = nil) -> String {
            let queryString = [
                serial.map { "serial=\($0)" },
                locationID.map { "location_id=\($0)" },
                search.map { "search=\($0)" },
                type.map { "jenis=\($0)" },
                sttMedic.map { "stt_medik=\($0)" },
                limit.map { "limit=\($0)" },
                page.map { "page=\($0)" }
            ].compactMap { $0 }.joined(separator: "&")
            
            let url = "equipments" + (queryString.isEmpty ? "" : "?\(queryString)")
            
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
        keyword: String? = nil) -> String {
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
        keyboard: String? = nil,
        status: Int? = nil
    ) -> String {
        let queryString = [
            limit.map { "limit=\($0)" },
            page.map { "page=\($0)" },
            tipe.map { "tipe=\($0)" },
            keyboard.map { "keyboard\($0)" },
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
            sort.map { "sort\($0)" },
            hasObstacle.map { "has_obstacle=\($0)" },
            keyword.map { "keyword=\($0)" },
            page.map { "page=\($0)" }
        ].compactMap { $0 }.joined(separator: "&")
        
        let url = "lk/list" + (queryString.isEmpty ? "" : "?\(queryString)")
        
        return url.replacingOccurrences(of: "", with: "%20")
    }
    
    private func generateWorkSheetPreventiveURL(
        limit: Int? = nil,
        page: Int? = nil,
        engineer: Int? = nil
    ) -> String {
        let queryString = [
            limit.map { "limit=\($0)" },
            page.map { "page=\($0)" },
            engineer.map { "engineer=\($0)" }
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
        idEngineer: String? = nil,
        date: String? = nil,
        page: Int? = nil,
        limit: Int? = nil
    ) -> String {
        let queryString = [
            idEngineer.map { "id_engineer=\($0)" },
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
    
}
