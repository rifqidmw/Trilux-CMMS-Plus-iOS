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
    
    enum CodingKeys: String, CodingKey {
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        txtName = try container.decodeIfPresent(String.self, forKey: .txtName)
        txtUsername = try container.decodeIfPresent(String.self, forKey: .txtUsername)
        valImageThumbnail = try container.decodeIfPresent(String.self, forKey: .valImageThumbnail)
        valImage = try container.decodeIfPresent(String.self, forKey: .valImage)
        
        if let intValue = try? container.decode(Int.self, forKey: .valImageId) {
            valImageId = String(intValue)
        } else if let stringValue = try? container.decode(String.self, forKey: .valImageId) {
            valImageId = stringValue
        } else {
            valImageId = nil
        }
        
        valPosition = try container.decodeIfPresent(String.self, forKey: .valPosition)
        txtJob = try container.decodeIfPresent(String.self, forKey: .txtJob)
        txtDescriptions = try container.decodeIfPresent(String.self, forKey: .txtDescriptions)
        txtJabatan = try container.decodeIfPresent(String.self, forKey: .txtJabatan)
        txtUnitKerja = try container.decodeIfPresent(String.self, forKey: .txtUnitKerja)
        txtTelepon = try container.decodeIfPresent(String.self, forKey: .txtTelepon)
        valToken = try container.decodeIfPresent(String.self, forKey: .valToken)
        valScope = try container.decodeIfPresent(ValScope.self, forKey: .valScope)
        valPeringkat = try container.decodeIfPresent([Int].self, forKey: .valPeringkat)
        valDeviceToken = try container.decodeIfPresent(String.self, forKey: .valDeviceToken)
        isPolisi = try container.decodeIfPresent(String.self, forKey: .isPolisi)
        ttd = try container.decodeIfPresent(String.self, forKey: .ttd)
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
