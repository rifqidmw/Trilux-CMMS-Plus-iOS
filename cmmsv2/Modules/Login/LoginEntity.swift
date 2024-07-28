//
//  LoginEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/01/24.
//

import Foundation

struct UserProfileEntity: Codable {
    let count: Int?
    let data: UserData?
    let message: MessageStatusType?
    let status: Int?
    let reff: [String: String]?
    
    enum CodingKeys: CodingKey {
        case count
        case data
        case message
        case status
        case reff
    }
}

struct UserData: Codable {
    let user: User?
    
    enum CodingKeys: CodingKey {
        case user
    }
}

struct User: Codable {
    let txtName: String?
    let txtUsername: String?
    let valImageThumbnail: String?
    let valImage: String?
    let valImageId: String?
    let valPosition: String?
    let txtJob: String?
    let txtDescriptions: String?
    let txtJabatan: String?
    let txtUnitKerja: String?
    let txtTelepon: String?
    let valToken: String?
    let valScope: ValScope?
    let valPeringkat: [Int]?
    let valDeviceToken: String?
    let isPolisi: String?
    var ttd: String?
    
    enum CodingKeys: CodingKey {
        case txtName
        case txtUsername
        case valImageThumbnail
        case valImage
        case valImageId
        case valPosition
        case txtJob
        case txtDescriptions
        case txtJabatan
        case txtUnitKerja
        case txtTelepon
        case valToken
        case valScope
        case valPeringkat
        case valDeviceToken
        case isPolisi
        case ttd
    }
    
    enum ValScope: Codable {
        case strings([String])
        case ints([Int])
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let strings = try? container.decode([String].self) {
                self = .strings(strings)
                return
            }
            if let ints = try? container.decode([Int].self) {
                self = .ints(ints)
                return
            }
            throw DecodingError.typeMismatch(
                ValScope.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected [String] or [Int]")
            )
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .strings(let strings):
                try container.encode(strings)
            case .ints(let ints):
                try container.encode(ints)
            }
        }
    }
}

struct HospitalTheme: Codable {
    let logo: String?
    let tagline: String?
    
    enum CodingKeys: CodingKey {
        case logo
        case tagline
    }
}
