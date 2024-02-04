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
    case infoExpired
    case uploadProfile(file: ImageProfile)
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
        case .infoExpired:
            return "info/expired"
        case .uploadProfile:
            return "media/uploadprofile"
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
        case .uploadProfile(let ImageProfile):
            let formData: MultipartFormData = MultipartFormData()
            formData.append(ImageProfile.file, withName: "fileset", fileName: "file.jpg", mimeType: "image/jpg")
            
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
                "Content-Type": "multipart/form-data",
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
