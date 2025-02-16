//
//  AppManager.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 28/04/24.
//

import Foundation

enum AppManager {
    
    static let userKey = "userStored"
    static let hospitalKey = "hospitalStored"
    static let isRegisteredKey = "isRegistered"
    static let isLoggedInKey = "isLoggedIn"
    static let searchHistoryKey = "searchHistoryStored"
    static let userTokenKey = "valToken"
    static let userRoleKey = "currentUserRole"
    static let notificationKey = "notificationStored"
    static let isOpenedNotifKey = "isNotifOpened"
    
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
        if let dataObject = UserDefaults.standard.object(forKey: userKey) as? Data {
            if let data = try? JSONDecoder().decode(User.self, from: dataObject) {
                return data
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
        if let dataObject = UserDefaults.standard.object(forKey: hospitalKey) as? Data {
            if let data = try? JSONDecoder().decode(HospitalDetail.self, from: dataObject) {
                return data
            }
        }
        return nil
    }
    
    static func setUserToken(_ data: String?) {
        do {
            let encoder = JSONEncoder()
            let dataEncode = try encoder.encode(data)
            UserDefaults.standard.set(dataEncode, forKey: userTokenKey)
        } catch {
            AppLogger.log("-- Error encoding user token data: \(error)")
        }
    }
    
    static func getUserToken() -> String? {
        if let dataObject = UserDefaults.standard.object(forKey: userTokenKey) as? Data {
            if let data = try? JSONDecoder().decode(String.self, from: dataObject) {
                return data
            }
        }
        return nil
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
    
    static func setUserRole(_ data: String?) {
        do {
            let encoder = JSONEncoder()
            let dataEncode = try encoder.encode(data)
            UserDefaults.standard.set(dataEncode, forKey: userRoleKey)
        } catch {
            AppLogger.log("-- Error encoding user role data: \(error)")
        }
    }
    
    static func getUserRole() -> String? {
        if let dataObject = UserDefaults.standard.object(forKey: userRoleKey) as? Data {
            if let data = try? JSONDecoder().decode(String.self, from: dataObject) {
                return data
            }
        }
        return nil
    }
    
    static func setNotificationList(_ data: [NotificationList]) {
        var notificationList = getNotificationList() ?? []
        notificationList.append(contentsOf: data)
        
        do {
            let encoder = JSONEncoder()
            let dataEncode = try encoder.encode(notificationList)
            UserDefaults.standard.set(dataEncode, forKey: notificationKey)
        } catch {
            AppLogger.log("-- Error encoding  notification list data: \(error)")
        }
    }
    
    static func getNotificationList() -> [NotificationList]? {
        if let dataObject = UserDefaults.standard.data(forKey: notificationKey) {
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode([NotificationList].self, from: dataObject)
                return response
            } catch {
                AppLogger.log("-- Error decoding notification list data: \(error)")
            }
        }
        return nil
    }
    
    static func setIsRegistered(_ isRegistered: Bool) {
        UserDefaults.standard.setValue(isRegistered, forKey: isRegisteredKey)
    }
    
    static func getIsRegistered() -> Bool {
        return UserDefaults.standard.bool(forKey: isRegisteredKey)
    }
    
    static func setIsLoggedIn(_ isLoggedIn: Bool) {
        UserDefaults.standard.setValue(isLoggedIn, forKey: isLoggedInKey)
    }
    
    static func getIsLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: isLoggedInKey)
    }
    
    static func setIsOpenedNotification(_ isLoggedIn: Bool) {
        UserDefaults.standard.setValue(isLoggedIn, forKey: isOpenedNotifKey)
    }
    
    static func getIsOpenedNotification() -> Bool {
        return UserDefaults.standard.bool(forKey: isOpenedNotifKey)
    }
    
    static func deleteObject(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
}
