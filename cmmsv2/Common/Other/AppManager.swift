//
//  AppManager.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 28/04/24.
//

import Foundation

enum AppManager {
    
    private static let userKey = "user"
    private static let hospitalKey = "hospital"
    private static let isRegisteredKey = "isRegistered"
    private static let isLoggedInKey = "isLoggedIn"
    private static let searchHistoryKey = "searchHistory"
    
    static func setUser(_ data: User?) {
        do {
            let encoder = JSONEncoder()
            let dataEncode = try encoder.encode(data)
            UserDefaults.standard.set(dataEncode, forKey: userKey)
        } catch {
            AppLogger.log("-- Error encoding user data: \(error)")
        }
    }
    
    static func getUser() -> User? {
        if let dataObject = UserDefaults.standard.data(forKey: userKey) {
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(User.self, from: dataObject)
                return response
            } catch {
                AppLogger.log("-- Error decoding user data: \(error)")
            }
        }
        return nil
    }
    
    static func setHospital(_ data: HospitalDetail?) {
        do {
            let encoder = JSONEncoder()
            let dataEncode = try encoder.encode(data)
            UserDefaults.standard.set(dataEncode, forKey: hospitalKey)
        } catch {
            AppLogger.log("-- Error encoding hospital data: \(error)")
        }
    }
    
    static func getHospital() -> HospitalDetail? {
        if let dataObject = UserDefaults.standard.data(forKey: hospitalKey) {
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(HospitalDetail.self, from: dataObject)
                return response
            } catch {
                AppLogger.log("-- Error decoding hospital data: \(error)")
            }
        }
        return nil
    }
    
    static func setIsRegistered(_ isRegistered: Bool) {
        UserDefaults.standard.setValue(isRegistered, forKey: isRegisteredKey)
    }
    
    static func getIsRegistered() {
        UserDefaults.standard.bool(forKey: isRegisteredKey)
    }
    
    static func setIsLoggedIn(_ isLoggedIn: Bool) {
        UserDefaults.standard.setValue(isLoggedIn, forKey: isLoggedInKey)
    }
    
    static func getIsLoggedIn() {
        UserDefaults.standard.bool(forKey: isLoggedInKey)
    }
    
    static func deleteObject(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    static func setSearchHistory(_ data: AssetFilterEntity) {
        var searchHistory = getSearchHistory() ?? []
        searchHistory.append(data)
        
        do {
            let encoder = JSONEncoder()
            let dataEncode = try encoder.encode(searchHistory)
            UserDefaults.standard.set(dataEncode, forKey: searchHistoryKey)
        } catch {
            AppLogger.log("-- Error encoding search history data: \(error)")
        }
    }
    
    static func getSearchHistory() -> [AssetFilterEntity]? {
        if let dataObject = UserDefaults.standard.data(forKey: searchHistoryKey) {
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode([AssetFilterEntity].self, from: dataObject)
                return response
            } catch {
                AppLogger.log("-- Error decoding search history data: \(error)")
            }
        }
        return nil
    }
    
    static func deleteSearchHistory(by id: UUID) {
        var searchHistory = getSearchHistory() ?? []
        searchHistory.removeAll { $0.id == id }
        
        do {
            let encoder = JSONEncoder()
            let dataEncode = try encoder.encode(searchHistory)
            UserDefaults.standard.set(dataEncode, forKey: searchHistoryKey)
        } catch {
            AppLogger.log("-- Error encoding search history data: \(error)")
        }
    }
    
    static func clearAllSearchHistory() {
        UserDefaults.standard.removeObject(forKey: searchHistoryKey)
    }
    
}
