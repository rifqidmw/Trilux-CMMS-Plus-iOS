// 
//  LoginEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/01/24.
//

import Foundation

struct HospitalTheme: Codable {
    let logo: String?
    let tagline: String?
    
    enum CodingKeys: CodingKey {
        case logo
        case tagline
    }
}
