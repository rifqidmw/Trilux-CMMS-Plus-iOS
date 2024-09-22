//
//  EditComplaintEntity.swift
//  cmmsv2
//
//  Created by macbook  on 22/09/24.
//

import Foundation

struct EditComplaintMediaEntity: Codable {
    let count: Int?
    let data: EditComplaintMediaData?
    let message: String?
    let status: Int?
    let reff: ReffData?
}

struct EditComplaintMediaData: Codable {
    let medias: [Media]?
}

struct UpdateComplaintRequestEntity: Codable {
    let equipmentId: String?
    let title: String?
    let descriptions: String?
    let imageId: [String]?
    let deleteImages: [String]?
    
    enum CodingKeys: String, CodingKey {
        case equipmentId = "equipment_id"
        case title
        case descriptions
        case imageId = "image_id"
        case deleteImages = "delete_images"
    }
}

struct UpdateComplaintResponseEntity: Codable {
    let count: Int?
    let data: UpdateComplaintData?
    let message: String?
    let status: Int?
    let reff: ReffData?
    
    enum CodingKeys: String, CodingKey {
        case count
        case data
        case message
        case status
        case reff
    }
}

struct UpdateComplaintData: Codable {
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}
