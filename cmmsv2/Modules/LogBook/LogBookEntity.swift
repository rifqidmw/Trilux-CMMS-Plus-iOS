// 
//  LogBookEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 17/03/24.
//

import Foundation

struct LogBookEntity {
    let id = UUID()
    let uniqueNumber: String
    let time: String
    let action: String
    let evaluation: String
}

let logBookDataList: [LogBookEntity] = [
    LogBookEntity(
        uniqueNumber: "LK.2021.11.PI010",
        time: "07:01 AM",
        action: "Kalibrasi",
        evaluation: "Lorem Ipsum is simply dummy text of the printing and..."),
    LogBookEntity(
        uniqueNumber: "LK.2021.11.PI010",
        time: "07:02 AM",
        action: "Preventif",
        evaluation: "Lorem Ipsum is simply dummy text of the printing and..."),
    LogBookEntity(
        uniqueNumber: "LK.2021.11.PI010",
        time: "07:03 AM",
        action: "Kalibrasi",
        evaluation: "Lorem Ipsum is simply dummy text of the printing and...")
]
