//
//  EditProfileEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/01/24.
//

import Foundation

struct EditProfileEntity: Codable {
    let count: Int?
    let data: EditProfileData?
    let message: MessageType?
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

struct EditProfileData: Codable {
    let user: EditProfileUser?
    
    enum CodingKeys: CodingKey {
        case user
    }
}

struct EditProfileUser: Codable {
    let txtName: String?
    let txtUsername: String?
    let valImageThumbnail: String?
    let valImage: String?
    let valImageId: Int?
    let valPosition: String?
    let txtJob: String?
    let txtDescriptions: String?
    let txtJabatan: String?
    let txtUnitKerja: String?
    let txtTelepon: String?
    let valToken: String?
    let valScope: [Int]?
    let valPeringkat: [Int]?
    let valDeviceToken: String?
    let isPolisi: String?
    let ttd: String?
    
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
}
