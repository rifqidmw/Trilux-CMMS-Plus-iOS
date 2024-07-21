//
//  RegistrationHospitalEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 06/01/24.
//

struct Hospital: Codable {
    let data: HospitalData?
    let message: MessageStatusType?
    let status: Int?
    
    enum CodingKeys: String, CodingKey {
        case data
        case message
        case status
    }
}

struct HospitalData: Codable {
    let hospital: HospitalDetail?
    
    enum CodingKeys: String, CodingKey {
        case hospital
    }
}

struct HospitalDetail: Codable {
    let name: String?
    let url: String?
    let logo: String?
    let background: String?
    let tagline: String?
    let code: String?
    let banner: [String]?
    let jenis: String?
    let modules: Modules?
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
        case logo
        case background
        case tagline
        case code
        case banner
        case jenis
        case modules
    }
}

struct Modules: Codable {
    let plan: Bool
    let decom: Bool
    let mutate: Bool
    let assetplus: Bool
    
    enum CodingKeys: String, CodingKey {
        case plan
        case decom
        case mutate
        case assetplus
    }
}
