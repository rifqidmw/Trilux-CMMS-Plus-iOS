//
//  String+Ext.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 10/02/24.
//

import Foundation
import UIKit

extension String {
    
    func formatToRupiah() -> String {
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencySymbol = "Rp"
            return formatter.string(from: NSNumber(value: value)) ?? ""
        } else {
            return self
        }
    }
    
    static func getCurrentDateString(_ formatter: String? = "yyyy-MM-dd", localization: String? = "id_ID") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: localization ?? "")
        dateFormatter.dateFormat = formatter
        return dateFormatter.string(from: Date())
    }
    
    static func parseDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.date(from: dateString)
    }
    
    static func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MMMM dd"
        return dateFormatter.string(from: date)
    }
    
    static func formattedTime(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
}
