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
    
    static func getCurrentDateString(_ formatter: String? = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        return dateFormatter.string(from: Date())
    }
    
}
