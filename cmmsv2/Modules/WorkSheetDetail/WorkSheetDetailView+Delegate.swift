//
//  WorkSheetDetailView+Delegate.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 02/06/24.
//

import UIKit

extension WorkSheetDetailView: SparePartSectionDelegate {
    
    func didTapDeleteSparePart(id: String) {
        AppLogger.log("-- THIS IS ID: \(id)")
    }
    
}
