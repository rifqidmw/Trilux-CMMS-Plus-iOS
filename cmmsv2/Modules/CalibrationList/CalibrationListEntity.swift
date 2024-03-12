//
//  CalibrationListEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 12/03/24.
//

import Foundation

struct CalibrationListEntity {
    var id = UUID()
    let uniqueNumber: String
    let title: String
    let description: String
    let room: String
    let correctionStatus: Bool
    let status: WorkSheetStatus
}

let dataCalibrationList: [CalibrationListEntity] = [
    CalibrationListEntity(
        uniqueNumber: "LK.2023.LK001",
        title: "Bed-side Monitor/Bed-patient monitoring",
        description: "No#cbpm002",
        room: "Pelayanan rawat intensif",
        correctionStatus: false,
        status: .ongoing),
    CalibrationListEntity(
        uniqueNumber: "LK.2021.11.PI010",
        title: "Ventilitator",
        description: "No#666787 - Pelayanan Bedah Sentral (OK)",
        room: "Ruangan Persia",
        correctionStatus: false,
        status: .ongoing),
    CalibrationListEntity(
        uniqueNumber: "LK.2021.11.PI010",
        title: "Tensimeter",
        description: "No#666787 - Pelayanan Bedah Sentral (OK)",
        room: "Poliklinik Mata",
        correctionStatus: false,
        status: .ongoing),
    CalibrationListEntity(
        uniqueNumber: "5685655",
        title: "Termometer digital",
        description: "Poliklinik Executive Cendana",
        room: "Poliklinik Mata",
        correctionStatus: false,
        status: .open),
    CalibrationListEntity(
        uniqueNumber: "LK.2021.11.PI010",
        title: "Syringe Pump",
        description: "No#666787 - Pelayanan Bedah Sentral (OK)",
        room: "Ruangan Persia",
        correctionStatus: true,
        status: .done),
    CalibrationListEntity(
        uniqueNumber: "LK.2021.11.PI010",
        title: "High Flow Nassal Cannula",
        description: "No#666787 - Pelayanan Rawat Inap",
        room: "Ruangan Persia",
        correctionStatus: false,
        status: .ongoing),
    CalibrationListEntity(
        uniqueNumber: "LK.2021.11.PI010",
        title: "X-Ray Film Viewer",
        description: "No#666787 - Pelayanan Rawat Inap",
        room: "Ruangan Persia",
        correctionStatus: true,
        status: .done),
    CalibrationListEntity(
        uniqueNumber: "5685655",
        title: "Termometer digital",
        description: "Poliklinik Executive Cendana",
        room: "Poliklinik Mata",
        correctionStatus: false,
        status: .open)
]
