//
//  WorkSheetOnsitePreventiveListEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 22/01/24.
//

import Foundation

@objc protocol WorkSheetOnsitePreventiveDelegate: AnyObject {
    @objc optional func didTapDetail(title: String)
    @objc optional func didTapContinueWorking(title: String)
    @objc optional func didTapDownloadPDF(title: String)
}

let onsitePreventiveData: [WorkSheetListEntity] = [
    WorkSheetListEntity(
        id: "1",
        uniqueNumber: "LK.2021.11.PI010",
        workName: "Syringe Pump",
        workDesc: "Pelayanan Bedah Sentral (OK) - Ruangan Persia",
        serial: "72385234",
        installation: "Pelayanan Gawat Darurat",
        room: "Ruangan Triase(auto-room)",
        dateTime: "2024-04-04 12:13:14",
        brandName: "Acumalaka",
        category: .calibration,
        status: .done),
    WorkSheetListEntity(
        id: "1",
        uniqueNumber: "LK.2021.11.PI010",
        workName: "Syringe Pump",
        workDesc: "Pelayanan Bedah Sentral (OK) - Ruangan Persia",
        serial: "72385234",
        installation: "Pelayanan Gawat Darurat",
        room: "Ruangan Triase(auto-room)",
        dateTime: "2024-04-04 12:13:14",
        brandName: "Acumalaka",
        category: .calibration,
        status: .done),
    WorkSheetListEntity(
        id: "1",
        uniqueNumber: "LK.2021.11.PI010",
        workName: "Syringe Pump",
        workDesc: "Pelayanan Bedah Sentral (OK) - Ruangan Persia",
        serial: "72385234",
        installation: "Pelayanan Gawat Darurat",
        room: "Ruangan Triase(auto-room)",
        dateTime: "2024-04-04 12:13:14",
        brandName: "Acumalaka",
        category: .calibration,
        status: .done),
    WorkSheetListEntity(
        id: "1",
        uniqueNumber: "LK.2021.11.PI010",
        workName: "Syringe Pump",
        workDesc: "Pelayanan Bedah Sentral (OK) - Ruangan Persia",
        serial: "72385234",
        installation: "Pelayanan Gawat Darurat",
        room: "Ruangan Triase(auto-room)",
        dateTime: "2024-04-04 12:13:14",
        brandName: "Acumalaka",
        category: .calibration,
        status: .done),
    WorkSheetListEntity(
        id: "1",
        uniqueNumber: "LK.2021.11.PI010",
        workName: "Syringe Pump",
        workDesc: "Pelayanan Bedah Sentral (OK) - Ruangan Persia",
        serial: "72385234",
        installation: "Pelayanan Gawat Darurat",
        room: "Ruangan Triase(auto-room)",
        dateTime: "2024-04-04 12:13:14",
        brandName: "Acumalaka",
        category: .calibration,
        status: .done)
]
