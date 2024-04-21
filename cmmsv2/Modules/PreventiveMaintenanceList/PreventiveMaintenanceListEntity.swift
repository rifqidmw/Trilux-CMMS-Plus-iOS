//
//  PreventiveMaintenanceListEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 11/03/24.
//

import Foundation

struct PreventiveMaintenanceListEntity: Codable {
    var id: String?
    let uniqueNumber: String?
    let title: String?
    let description: String?
    let room: String?
    let approveStatus: Bool?
    let status: WorkSheetStatus?
    
    enum CodingKeys: CodingKey {
        case id
        case uniqueNumber
        case title
        case description
        case room
        case approveStatus
        case status
    }
}

struct PreventiveMaintenanceData: Codable {
    let data: [PreventiveMaintenanceWorkOrder]?
    let reff: Reff?
    let message: String?
    let status: Int?
    
    enum CodingKeys: CodingKey {
        case data
        case reff
        case message
        case status
    }
}

struct PreventiveMaintenanceWorkOrder: Codable {
    let idLk: String?
    let lkNumber: String?
    let lkJenis: String?
    let lkVarian: String?
    let lkDate: String?
    let lkEngineer: String?
    let lkAssign: String?
    let idAsset: String?
    let lkLabel: String?
    let lkInfo: String?
    let lkStatus: String?
    let lkFinishstt: String?
    let lkWebenable: String?
    let lkStart: String?
    let lkFinish: String?
    let lkContinue: String?
    let lkDurasireal: String?
    let lkRating: String?
    let createBy: String?
    let approveBy: String?
    let rateBy: String?
    let createAt: String?
    let expired: String?
    let lkGeneralflag: String?
    let extra: String?
    let txtJenis: String?
    let txtStatus: String?
    let txtFinishStatus: String?
    let txtEngineerName: String?
    let dateText: String?
    let assetimage: String?
    let assetname: String?
    let brandname: String?
    let typename: String?
    let serial: String?
    let instalasi: String?
    let ruangan: String?
    let isPendamping: String?
    let canPendamping: String?
    let infoLk: InfoLK?
    let nama_perating: String?
    
    enum CodingKeys: CodingKey {
        case idLk
        case lkNumber
        case lkJenis
        case lkVarian
        case lkDate
        case lkEngineer
        case lkAssign
        case idAsset
        case lkLabel
        case lkInfo
        case lkStatus
        case lkFinishstt
        case lkWebenable
        case lkStart
        case lkFinish
        case lkContinue
        case lkDurasireal
        case lkRating
        case createBy
        case approveBy
        case rateBy
        case createAt
        case expired
        case lkGeneralflag
        case extra
        case txtJenis
        case txtStatus
        case txtFinishStatus
        case txtEngineerName
        case dateText
        case assetimage
        case assetname
        case brandname
        case typename
        case serial
        case instalasi
        case ruangan
        case isPendamping
        case canPendamping
        case infoLk
        case nama_perating
    }
}

struct Reff: Codable {
    let page: String?
    let pageSize: String?
    let totalPage: String?
    let totalItem: String?
    
    enum CodingKeys: CodingKey {
        case page
        case pageSize
        case totalPage
        case totalItem
    }
}


let dataPreventiveMaintenance: [PreventiveMaintenanceListEntity] = [
    PreventiveMaintenanceListEntity(
        id: "1",
        uniqueNumber: "5685655",
        title: "Termometer digital",
        description: "Poliklinik Executive Cendana",
        room: "Poliklinik Mata",
        approveStatus: false,
        status: .open),
    PreventiveMaintenanceListEntity(
        id: "2",
        uniqueNumber: "LK.2021.11.PI010",
        title: "Ventilitator",
        description: "No#666787 - Pelayanan Bedah Sentral (OK)",
        room: "Ruangan Persia",
        approveStatus: false,
        status: .ongoing),
    PreventiveMaintenanceListEntity(
        id: "3",
        uniqueNumber: "LK.2021.11.PI010",
        title: "Tensimeter",
        description: "No#666787 - Pelayanan Bedah Sentral (OK)",
        room: "Poliklinik Mata",
        approveStatus: false,
        status: .ongoing),
    PreventiveMaintenanceListEntity(
        id: "4",
        uniqueNumber: "5685655",
        title: "Termometer digital",
        description: "Poliklinik Executive Cendana",
        room: "Poliklinik Mata",
        approveStatus: false,
        status: .open),
    PreventiveMaintenanceListEntity(
        id: "5",
        uniqueNumber: "LK.2021.11.PI010",
        title: "Syringe Pump",
        description: "No#666787 - Pelayanan Bedah Sentral (OK)",
        room: "Ruangan Persia",
        approveStatus: true,
        status: .done),
    PreventiveMaintenanceListEntity(
        id: "6",
        uniqueNumber: "LK.2021.11.PI010",
        title: "High Flow Nassal Cannula",
        description: "No#666787 - Pelayanan Rawat Inap",
        room: "Ruangan Persia",
        approveStatus: false,
        status: .ongoing),
    PreventiveMaintenanceListEntity(
        id: "7",
        uniqueNumber: "LK.2021.11.PI010",
        title: "X-Ray Film Viewer",
        description: "No#666787 - Pelayanan Rawat Inap",
        room: "Ruangan Persia",
        approveStatus: true,
        status: .done),
    PreventiveMaintenanceListEntity(
        id: "8",
        uniqueNumber: "5685655",
        title: "Termometer digital",
        description: "Poliklinik Executive Cendana",
        room: "Poliklinik Mata",
        approveStatus: false,
        status: .open)
]
