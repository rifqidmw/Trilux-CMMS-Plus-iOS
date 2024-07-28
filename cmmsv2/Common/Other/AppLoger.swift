//
//  AppLoger.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import Foundation
import os

class AppLogger {
    
    static let log = AppLogger()
    
    var isLogEnabled: Bool {
#if DEBUG
        return true
#else
        return true
#endif
    }
    
    class var sharedLogger: AppLogger {
        struct DefaultSingleton {
            static let loggerInstance = AppLogger()
        }
        return DefaultSingleton.loggerInstance
    }
    
    class func log(_ logString: Any, logType: LogType? = .kTrace, isColorEnabled: Bool? = false) {
        if AppLogger.sharedLogger.isLogEnabled == false && logType != .kImportant {
            return
        } else {
            switch logType {
            case .kDebug?:
                print("CMMS: \(isColorEnabled! ? PrintColors.magenta.rawValue : "")\(logString)")
            case .kInfo?:
                print("CMMS: \(isColorEnabled! ? PrintColors.green.rawValue : "")\(logString)")
            case .kWarning?:
                print("CMMS: \(isColorEnabled! ? PrintColors.blue.rawValue : "")\(logString)")
            case .kError?:
                print("CMMS: \(isColorEnabled! ? PrintColors.red.rawValue : "")\(logString)")
            case .kImportant?:
                print("CMMS: \(isColorEnabled! ? PrintColors.black.rawValue : "")\(logString)")
            case .kNetworkRequest?:
                print("CMMS-NETWORK-REQUEST: \(Date.init()) \(isColorEnabled! ? PrintColors.black.rawValue : "📔:")\(logString)")
            case .kNetworkResponseSuccess?:
                print("CMMS-NETWORK-RESPONSE: \(Date.init()) \(isColorEnabled! ? PrintColors.black.rawValue : "📗:")\(logString)")
            case .kNetworkResponseError?:
                print("CMMS-NETWORK-ERROR: \(Date.init()) \(isColorEnabled! ? PrintColors.black.rawValue : "🛑:")\(logString)")
            case .kNavigation?:
                print("CMMS-ROUTE: \(isColorEnabled! ? PrintColors.green.rawValue : "🟣: ")\(logString)")
            case .kDeinit?:
                print("CMMS-DEINIT: \(isColorEnabled! ? PrintColors.magenta.rawValue : "🔘: ")\(logString)")
            default:
                print("CMMS: \(isColorEnabled! ? PrintColors.black.rawValue : "")\(logString)")
            }
        }
    }
    
}

enum LogType: Int {
    case kTrace = 1
    case kDebug = 2
    case kInfo = 3
    case kWarning = 4
    case kError = 5
    case kImportant = 6
    case kVeryImportant = 7
    case kNetworkRequest = 8
    case kNetworkResponseSuccess = 9
    case kNetworkResponseError = 10
    case kNavigation = 11
    case kDeinit = 12
}

enum PrintColors: String {
    case black = "\u{001B}[0;30m"
    case red = "\u{001B}[0;31m"
    case green = "\u{001B}[0;32m"
    case yellow = "\u{001B}[0;33m"
    case blue = "\u{001B}[0;34m"
    case magenta = "\u{001B}[0;35m"
    case cyan = "\u{001B}[0;36m"
    case white = "\u{001B}[0;37m"
    
    func name() -> String {
        switch self {
        case .black: return "Black"
        case .red: return "Red"
        case .green: return "Green"
        case .yellow: return "Yellow"
        case .blue: return "Blue"
        case .magenta: return "Magenta"
        case .cyan: return "Cyan"
        case .white: return "White"
        }
    }
}
