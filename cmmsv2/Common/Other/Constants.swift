//
//  Constants.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import Foundation

struct Constants {
    
    public static var baseURL: String {
        return Bundle.main.infoDictionary?["BASE_URL"] as? String ?? ""
    }
    
    public static var rsURL: String {
        return Bundle.main.infoDictionary?["RS_URL"] as? String ?? ""
    }
    
    public static var token: String {
        return AppManager.getUserToken() ?? ""
    }
    
}
