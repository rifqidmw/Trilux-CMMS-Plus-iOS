// 
//  WorkSheetOnsitePreventiveListEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 22/01/24.
//

import Foundation

enum WorkSheetActionType {
    case work
    case see
}

let onsitePreventiveData: [WorkSheetListEntity] = [
    WorkSheetListEntity(
        uniqueNumber: "LK.2021.11.PI010",
        workName: "Ventilitator",
        workDesc: "No#666787 - Pelayanan Bedah Sentral (OK) - Ruangan Persia",
        isApproved: false,
        category: .none,
        status: .ongoing),
    WorkSheetListEntity(
        uniqueNumber: "LK.2021.11.PI011",
        workName: "Tensimeter",
        workDesc: "No#666787 - Pelayanan Bedah Sentral (OK) - Ruangan Persia",
        isApproved: false,
        category: .none,
        status: .ongoing),
    WorkSheetListEntity(
        uniqueNumber: "LK.2021.11.PI012",
        workName: "Syringe Pump",
        workDesc: "No#666787 - Pelayanan Bedah Sentral (OK) - Ruangan Persia",
        isApproved: false,
        category: .none,
        status: .done),
    WorkSheetListEntity(
        uniqueNumber: "LK.2021.11.PI013",
        workName: "High Flow Nassal Cannula",
        workDesc: "No#666787 - Pelayanan Rawat Inap - Ruangan Persia",
        isApproved: false,
        category: .none,
        status: .ongoing),
    WorkSheetListEntity(
        uniqueNumber: "LK.2021.11.PI014",
        workName: "X-Ray Film Viewer",
        workDesc: "No#666787 - Pelayanan Rawat Inap - Ruangan Persia",
        isApproved: false,
        category: .none,
        status: .done)
]
