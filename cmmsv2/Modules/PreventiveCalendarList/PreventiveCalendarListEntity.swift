//
//  PreventiveCalendarListEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 18/03/24.
//

import Foundation

struct PreventiveCalendarListEntity {
    let id = UUID()
    let uniqueNumber: String
    let title: String
    let status: WorkSheetStatus
    let roomCode: String
    let roomCategory: String
    let roomName: String
}

let preventiveCalendarList: [PreventiveCalendarListEntity] = [
    PreventiveCalendarListEntity(
        uniqueNumber: "LK.2021.11.PI010",
        title: "Therapeutic Vibrator",
        status: .open,
        roomCode: "5668",
        roomCategory: "Poliklinik Mata",
        roomName: "Poliklinik Execetuive Cendanas"),
    PreventiveCalendarListEntity(
        uniqueNumber: "LK.2021.11.PI010",
        title: "Elektrode Cable/Kable Elektroda",
        status: .open,
        roomCode: "5668",
        roomCategory: "Poliklinik Mata",
        roomName: "Poliklinik Execetuive Cendanas"),
    PreventiveCalendarListEntity(
        uniqueNumber: "LK.2021.11.PI010",
        title: "UV Sterilizier",
        status: .open,
        roomCode: "5668",
        roomCategory: "Poliklinik Mata",
        roomName: "Poliklinik Execetuive Cendanas")
]
