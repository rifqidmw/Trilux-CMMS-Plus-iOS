//
//  WorkSheetListEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/01/24.
//

import Foundation

protocol WorkSheetListDelegate: AnyObject {
    func didTapDetailWorkSheet()
}

struct WorkSheetMonitoringFunctionListEntity {
    let id = UUID()
    let uniqueNumber: String
    let workName: String
    let workDesc: String
    var isApproved: Bool
    let category: WorkSheetCategory
    let status: WorkSheetStatus
}

// MARK: - DUMMY DATA
let workSheetData: [WorkSheetMonitoringFunctionListEntity] = [
    WorkSheetMonitoringFunctionListEntity(
        uniqueNumber: "LK.2021.11.PI010",
        workName: "Syringe Pump",
        workDesc: "Pelayanan Bedah Sentral (OK) - Ruangan Persia",
        isApproved: false,
        category: .calibration,
        status: .done),
    WorkSheetMonitoringFunctionListEntity(
        uniqueNumber: "LK.2021.11.PI010",
        workName: "Bed-side Monitor / Bed-patient Monitor / Patient Monit...",
        workDesc: "Pelayanan Bedah Sentral (OK) - Ruangan Persia",
        isApproved: true,
        category: .preventive,
        status: .open),
    WorkSheetMonitoringFunctionListEntity(
        uniqueNumber: "LK.2021.11.PI010",
        workName: "X-Ray Film Viewer",
        workDesc: "Pelayanan Rawat Inap - Ruangan Persia",
        isApproved: true,
        category: .corrective,
        status: .done),
    WorkSheetMonitoringFunctionListEntity(
        uniqueNumber: "LK.2021.11.PI010",
        workName: "LK.2021.11.PI010",
        workDesc: "Pelayanan Bedah Sentral (OK) - Ruangan Persia",
        isApproved: false,
        category: .preventive,
        status: .open),
    WorkSheetMonitoringFunctionListEntity(
        uniqueNumber: "LK.2021.11.PI010",
        workName: "Ventilitator",
        workDesc: "No#666787 - Pelayanan Bedah Sentral (OK) - Ruangan Persia",
        isApproved: false,
        category: .corrective,
        status: .ongoing),
    WorkSheetMonitoringFunctionListEntity(
        uniqueNumber: "LK.2021.11.PI010",
        workName: "Bronchoscope and Accessories",
        workDesc: "Pelayanan Rawat Inap - Ruangan Persia",
        isApproved: false,
        category: .corrective,
        status: .open),
    WorkSheetMonitoringFunctionListEntity(
        uniqueNumber: "LK.2021.11.PI010",
        workName: "Tensimeter",
        workDesc: "No#666787 - Pelayanan Bedah Sentral (OK) - Ruangan Persia",
        isApproved: true,
        category: .calibration,
        status: .ongoing)
]
