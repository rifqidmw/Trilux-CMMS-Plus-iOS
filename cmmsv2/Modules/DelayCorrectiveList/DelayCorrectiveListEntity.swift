//
//  CorrectiveHoldListEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/03/24.
//

import Foundation

struct DelayCorrectiveListEntity {
    let id: Int
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
        id: 1,
        image: "unsplash_cEzMOp5FtV4",
        date: "23-Juni-2022",
        type: "Cendana",
        title: "Pulse Oxymeter / Oximeter",
        description: "Pulse Oxymeter / Oximeter",
        technician: "Alex Bill",
        damage: "Alat tidak hidup sama sekali"),
    DelayCorrectiveListEntity(
        id: 2,
        image: "unsplash_cEzMOp5FtV4",
        date: "26-Juni-2022",
        type: "Cendana",
        title: "Electrode Cable / Kabel Elektrik",
        description: "Poliklinik Executive Cendana",
        technician: "Alex Bill",
        damage: "Putus"),
    DelayCorrectiveListEntity(
        id: 3,
        image: "unsplash_gKUC4TMhOiY",
        date: "24-Juni-2022",
        type: "Inap",
        title: "Bed-side Monitor/Bed-patien",
        description: "Pelayanan Rawat Inap",
        technician: "Alex Bill",
        damage: "Mati total"),
    DelayCorrectiveListEntity(
        id: 4,
        image: "unsplash_m_HRfLhgABo",
        date: "25-Juni-2022",
        type: "Paridani",
        title: "Ventilator",
        description: "Pelayanan Perawatan Intensif Bayi",
        technician: "Maruf",
        damage: "Alat rusak total"),
    DelayCorrectiveListEntity(
        id: 5,
        image: "unsplash_cEzMOp5FtV4",
        date: "23-Juni-2022",
        type: "Cendana",
        title: "Pulse Oxymeter / Oximeter",
        description: "Pulse Oxymeter / Oximeter",
        technician: "Alex Bill",
        damage: "Alat tidak hidup sama sekali"),
    DelayCorrectiveListEntity(
        id: 6,
        image: "unsplash_cEzMOp5FtV4",
        date: "26-Juni-2022",
        type: "Cendana",
        title: "Electrode Cable / Kabel Elektrik",
        description: "Poliklinik Executive Cendana",
        technician: "Alex Bill",
        damage: "Putus"),
    DelayCorrectiveListEntity(
        id: 7,
        image: "unsplash_gKUC4TMhOiY",
        date: "24-Juni-2022",
        type: "Inap",
        title: "Bed-side Monitor/Bed-patien",
        description: "Pelayanan Rawat Inap",
        technician: "Alex Bill",
        damage: "Mati total"),
    DelayCorrectiveListEntity(
        id: 8,
        image: "unsplash_m_HRfLhgABo",
        date: "25-Juni-2022",
        type: "Paridani",
        title: "Ventilator",
        description: "Pelayanan Perawatan Intensif Bayi",
        technician: "Maruf",
        damage: "Alat rusak total")
]
