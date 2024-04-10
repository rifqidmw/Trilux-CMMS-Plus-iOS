// 
//  WorkSheetDetailEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 21/01/24.
//

import Foundation
import UIKit

protocol WorkSheetDetailDelegate: AnyObject {
    func didTapImage(titlePage: String, image: String)
    func didTapSeeAllEvidence()
}

struct WorkSheetCardEntity {
    let id = UUID()
    let image: String
    let title: String
    let description: String
    let code: String
}

struct EvidenceEquipmentEntity {
    let id = UUID()
    let image: String
}

struct WorkSheetDetailEntity {
    let id = UUID()
    let uniqueNumber: String
    let status: String
    let technician: String
    let date: String
}

let dummyImageCardData: WorkSheetCardEntity = WorkSheetCardEntity(image: "unsplash_yo01Z-9HQAw", title: "Steril Pouch (Sterilization)", description: "Poliklinik Executive Cendana", code: "07499 - Braun")

let dummyEvidenceEquipment: [EvidenceEquipmentEntity] = [
    EvidenceEquipmentEntity(image: "unsplash_cEzMOp5FtV4"),
    EvidenceEquipmentEntity(image: "unsplash_gKUC4TMhOiY"),
    EvidenceEquipmentEntity(image: "unsplash_m_HRfLhgABo"),
    EvidenceEquipmentEntity(image: "unsplash_cEzMOp5FtV4")
]

let dummyDetailWorkSheet: [WorkSheetDetailEntity] = [
    WorkSheetDetailEntity(uniqueNumber: "LK.2021.12.KAJS167", status: "Selesai, bisa digunakan kembali", technician: "Alex Bill", date: "15-Nov-2021"),
    WorkSheetDetailEntity(uniqueNumber: "LK.2021.12.KAJS167", status: "Selesai, bisa digunakan kembali", technician: "Bruce", date: "15-Nov-2021"),
    WorkSheetDetailEntity(uniqueNumber: "LK.2021.12.KAJS167", status: "Selesai, bisa digunakan kembali", technician: "Jack", date: "15-Nov-2021")
]
