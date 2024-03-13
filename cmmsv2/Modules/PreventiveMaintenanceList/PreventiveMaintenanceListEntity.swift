//
//  PreventiveMaintenanceListEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 11/03/24.
//

import Foundation

struct PreventiveMaintenanceListEntity {
    var id = UUID()
    let uniqueNumber: String
    let title: String
    let description: String
    let room: String
    let approveStatus: Bool
    let status: WorkSheetStatus
}

let dataPreventiveMaintenance: [PreventiveMaintenanceListEntity] = [
    PreventiveMaintenanceListEntity(
        uniqueNumber: "5685655",
        title: "Termometer digital",
        description: "Poliklinik Executive Cendana",
        room: "Poliklinik Mata",
        approveStatus: false,
        status: .open),
    PreventiveMaintenanceListEntity(
        uniqueNumber: "LK.2021.11.PI010",
        title: "Ventilitator",
        description: "No#666787 - Pelayanan Bedah Sentral (OK)",
        room: "Ruangan Persia",
        approveStatus: false,
        status: .ongoing),
    PreventiveMaintenanceListEntity(
        uniqueNumber: "LK.2021.11.PI010",
        title: "Tensimeter",
        description: "No#666787 - Pelayanan Bedah Sentral (OK)",
        room: "Poliklinik Mata",
        approveStatus: false, 
        status: .ongoing),
    PreventiveMaintenanceListEntity(
        uniqueNumber: "5685655",
        title: "Termometer digital",
        description: "Poliklinik Executive Cendana",
        room: "Poliklinik Mata",
        approveStatus: false,
        status: .open),
    PreventiveMaintenanceListEntity(
        uniqueNumber: "LK.2021.11.PI010",
        title: "Syringe Pump",
        description: "No#666787 - Pelayanan Bedah Sentral (OK)",
        room: "Ruangan Persia",
        approveStatus: true, 
        status: .done),
    PreventiveMaintenanceListEntity(
        uniqueNumber: "LK.2021.11.PI010",
        title: "High Flow Nassal Cannula",
        description: "No#666787 - Pelayanan Rawat Inap",
        room: "Ruangan Persia",
        approveStatus: false,
        status: .ongoing),
    PreventiveMaintenanceListEntity(
        uniqueNumber: "LK.2021.11.PI010",
        title: "X-Ray Film Viewer",
        description: "No#666787 - Pelayanan Rawat Inap",
        room: "Ruangan Persia",
        approveStatus: true,
        status: .done),
    PreventiveMaintenanceListEntity(
        uniqueNumber: "5685655",
        title: "Termometer digital",
        description: "Poliklinik Executive Cendana",
        room: "Poliklinik Mata",
        approveStatus: false,
        status: .open)
]
