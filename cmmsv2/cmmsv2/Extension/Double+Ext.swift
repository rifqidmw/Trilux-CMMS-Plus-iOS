//
//  Double+Ext.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import Foundation

extension Double {
    func formatDoubleWithSeparator() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0

        return formatter.string(from: NSNumber(value: self))
    }
}

