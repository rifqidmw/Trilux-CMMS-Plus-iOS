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
    case updateProfile(name: String, position: String, workUnit: String, imageId: Int, phoneNumber: String)
    case changePassword(oldPassword: String, passwordConfirm: String, password: String)
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
        dateFilter: String? = nil)
    case workSheetMonitoringFunction(
        limit: Int? = nil,
        page: Int? = nil,
        tipe: Int? = nil,
        keyword: String? = nil,
        status: String? = nil
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
            let dateFilter):
            return generateComplaintListURL(
                page: page,
                limit: limit,
                equipmentId: equipmentId,
                status: status,
                dateFilter: dateFilter)
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
                .uploadProfile:
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
        dateFilter: String? = nil) -> String {
            let queryString = [
                page.map { "page=\($0)" },
                limit.map { "limit=\($0)" },
                equipmentId.map { "equipment_id=\($0)" },
                status.map { "status=\($0)" },
                dateFilter.map { "date_filter=\($0)" }
            ].compactMap { $0 }.joined(separator: "&")
            
            let url = "complains/list" + (queryString.isEmpty ? "" : "?\(queryString)")
            
            return url.replacingOccurrences(of: " ", with: "%20")
        }
    
    private func generateWorkSheetMonitoringFunctionURL(
        limit: Int? = nil,
        page: Int? = nil,
        tipe: Int? = nil,
        keyboard: String? = nil,
        status: String? = nil
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
    
}
