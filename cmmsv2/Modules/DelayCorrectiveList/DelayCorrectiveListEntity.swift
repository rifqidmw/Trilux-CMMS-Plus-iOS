//
//  CorrectiveHoldListEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/03/24.
//

import Foundation

struct DelayCorrectiveListEntity {
    let id = UUID()
    let image: String
    let date: String
    let type: String
    let title: String
    let description: String
    let technician: String
    let damage: String
}

let delayCorrectiveDataList: [DelayCorrectiveListEntity] = [
    DelayCorrectiveListEntity(
        image: "unsplash_cEzMOp5FtV4",
        date: "23-Juni-2022",
        type: "Cendana",
        title: "Pulse Oxymeter / Oximeter",
        description: "Pulse Oxymeter / Oximeter",
        technician: "Alex Bill",
        damage: "Alat tidak hidup sama sekali"),
    DelayCorrectiveListEntity(
        image: "unsplash_cEzMOp5FtV4",
        date: "26-Juni-2022",
        type: "Cendana",
        title: "Electrode Cable / Kabel Elektrik",
        description: "Poliklinik Executive Cendana",
        technician: "Alex Bill",
        damage: "Putus"),
    DelayCorrectiveListEntity(
        image: "unsplash_gKUC4TMhOiY",
        date: "24-Juni-2022",
        type: "Inap",
        title: "Bed-side Monitor/Bed-patien",
        description: "Pelayanan Rawat Inap",
        technician: "Alex Bill",
        damage: "Mati total"),
    DelayCorrectiveListEntity(
        image: "unsplash_m_HRfLhgABo",
        date: "25-Juni-2022",
        type: "Paridani",
        title: "Ventilator",
        description: "Pelayanan Perawatan Intensif Bayi",
        technician: "Maruf",
        damage: "Alat rusak total"),
    DelayCorrectiveListEntity(
        image: "unsplash_cEzMOp5FtV4",
        date: "23-Juni-2022",
        type: "Cendana",
        title: "Pulse Oxymeter / Oximeter",
        description: "Pulse Oxymeter / Oximeter",
        technician: "Alex Bill",
        damage: "Alat tidak hidup sama sekali"),
    DelayCorrectiveListEntity(
        image: "unsplash_cEzMOp5FtV4",
        date: "26-Juni-2022",
        type: "Cendana",
        title: "Electrode Cable / Kabel Elektrik",
        description: "Poliklinik Executive Cendana",
        technician: "Alex Bill",
        damage: "Putus"),
    DelayCorrectiveListEntity(
        image: "unsplash_gKUC4TMhOiY",
        date: "24-Juni-2022",
        type: "Inap",
        title: "Bed-side Monitor/Bed-patien",
        description: "Pelayanan Rawat Inap",
        technician: "Alex Bill",
        damage: "Mati total"),
    DelayCorrectiveListEntity(
        image: "unsplash_m_HRfLhgABo",
        date: "25-Juni-2022",
        type: "Paridani",
        title: "Ventilator",
        description: "Pelayanan Perawatan Intensif Bayi",
        technician: "Maruf",
        damage: "Alat rusak total")
]
