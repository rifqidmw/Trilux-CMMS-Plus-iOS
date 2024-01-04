//
//  Endpoint.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import Foundation
import Alamofire

enum Endpoint {
    case list
    case post(params: ServiceTest)
}

// MARK: - PATH URL
extension Endpoint {
    // swiftlint:disable cyclomatic_complexity
    func path() -> String {
        switch self {
        case .list:
            return "list"
        case .post(let params):
            return "post/\(params)"
        }
    }
}

// MARK: - METHOD
extension Endpoint {
    func method() -> HTTPMethod {
        switch self {
        case .post:
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
        case .post(let param):
            let params: [String: Any] = [
                "createdAt": param.createdAt,
                "name": param.name,
                "avatar": param.avatar,
                "id": param.id,
                "count": param.count
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
        case .post:
            let params: HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            return params
        default:
            let params: HTTPHeaders = [
                // "token": token,
                // "Content-Type": "application/json"
                "Accept": "*/*"
            ]
            return params
        }
    }
}

extension Endpoint {
    func urlString() -> String {
        switch self {
        default:
            return Constants.baseURL + path()
        }
    }
}
