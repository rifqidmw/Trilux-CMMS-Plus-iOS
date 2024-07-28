//
//  RoleManager.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 28/07/24.
//

import Foundation

class RoleManager {
    
    static let shared = RoleManager()
    
    private init() {}
    
    var currentUserRole: UserRole = .unknown
    
    func updateRole(with valPosition: String) {
        currentUserRole = UserRole(valPosition: valPosition)
    }
    
}

enum UserRole {
    case ipsrs
    case engineer
    case unknown
    
    init(valPosition: String) {
        switch valPosition {
        case "1":
            self = .ipsrs
        case "2":
            self = .engineer
        default:
            self = .unknown
        }
    }
}