//
//  Array+Ext.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 10/02/24.
//

import Foundation

extension Array {
    func atIndex(_ index: Int) -> Element? {
        guard index >= 0 && index < count else { return nil }
        return self[index]
    }
}
