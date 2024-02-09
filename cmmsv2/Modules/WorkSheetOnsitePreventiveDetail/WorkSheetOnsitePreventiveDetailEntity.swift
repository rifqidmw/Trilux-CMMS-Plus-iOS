//
//  WorkSheetOnsitePreventiveDetailEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/02/24.
//

import Foundation

enum WorkSheetOnsitePreventiveDetailType {
    case seeOnly
    case workContinue
}

struct TensimeterModel: Identifiable {
    let id = UUID()
    let uniqueNumber: String
    let user: String
    let date: String
    let firstStatus: String
    let secondStatus: String
    let serialNumber: String
    let brand: String
    let type: String
    let installation: String
    let room: String
}

struct PreparationModel: Identifiable {
    let id = UUID()
    let title: String
    let subTitle: String
    let status: PreparationStatus?
    var isSelected: Bool = false
}

struct MeasurementModel: Identifiable {
    let id = UUID()
    let title: String
    let value: Int
}

struct ElectricalMeasurementModel: Identifiable {
    let id = UUID()
    let value: Int
    let title: String
    let description: String
}

struct ActionModel: Identifiable {
    let id = UUID()
    let title: String
    let desc: String
}

struct SparePartModel: Identifiable {
    let id = UUID()
    let title: String
    let total: Int
}

let labelData: [String] = [
    "Badan/Selungkup",
    "Kabel & Kelenturannya",
    "Tombol & Saklar",
    "Display/Layar",
    "Indikator Bunyi",
    "Alarm & Sistme Interlock",
    "Sistem Pengunci",
    "Lable/Penandaan",
    "Aksesoris"
]

let physicalData: [PreparationStatus] = [
    PreparationStatus.good,
    PreparationStatus.good,
    PreparationStatus.damaged,
    PreparationStatus.damaged,
    PreparationStatus.damaged,
    PreparationStatus.damaged,
    PreparationStatus.damaged,
    PreparationStatus.damaged,
    PreparationStatus.good
]

let functionalData: [PreparationStatus] = [
    PreparationStatus.good,
    PreparationStatus.good,
    PreparationStatus.damaged,
    PreparationStatus.damaged,
    PreparationStatus.damaged,
    PreparationStatus.damaged,
    PreparationStatus.damaged,
    PreparationStatus.damaged,
    PreparationStatus.good
]

let tensimeterData: TensimeterModel = TensimeterModel(
    uniqueNumber: "LK.2021.11.PI010",
    user: "Dr. Rizal",
    date: "15-Nov-2021",
    firstStatus: "Dalam proses pengerjaan",
    secondStatus: "Selesai",
    serialNumber: "112234452537",
    brand: "Fukuda ME",
    type: "Cardisunny C120",
    installation: "Pelayanan Rawat Jalan",
    room: "Ruangan Klinik Spesialisasi Kesehatan Anak (auto-room)")

let multimeterData: [MeasurementModel] = [
    MeasurementModel(title: "Tegangan 12V", value: 71),
    MeasurementModel(title: "Tegangan 24V", value: 61),
    MeasurementModel(title: "Tegangan 220V", value: 62),
    MeasurementModel(title: "Arus 3A", value: 0),
    MeasurementModel(title: "Arus 10A", value: 0)
]

let phantomEGCData: [MeasurementModel] = [
    MeasurementModel(title: "Bpm 60", value: 71),
    MeasurementModel(title: "Bpm 80", value: 61),
    MeasurementModel(title: "Bpm 100", value: 62)
]

let preparationData: [PreparationModel] = [
    PreparationModel(title: "Hand Hygiene", subTitle: "Hand Hygiene telah selesai dilakukan persiapan", status: .yes),
    PreparationModel(title: "Alat Pelindung Diri", subTitle: "Alat pelindung diri telah selesai dilakukan persiapan", status: .yes),
    PreparationModel(title: "KTD", subTitle: "KTD telah selesai dilakukan persiapan", status: .yes),
    PreparationModel(title: "Menyiapkan Alat & Bahan Kerja", subTitle: "Gagal dalam menyiapkan alat dan bahan kerja", status: .no),
    PreparationModel(title: "Mengoperasikan Alat Kalibrasi", subTitle: "Selesai dalam mengoperasikan alat kalibrasi", status: .yes),
    PreparationModel(title: "Mengoperasikan Alat", subTitle: "Gagal dalam mengoperasikan alat", status: .no)
]

let preventiveMaintenanceData: [PreparationModel] = [
    PreparationModel(title: "Pembersihan", subTitle: "Pembersihan dalam kondisi baik", status: .good, isSelected: true),
    PreparationModel(title: "Pelumasan", subTitle: "Pelumasan dalam kondisi baik", status: .good, isSelected: true),
    PreparationModel(title: "Penggantian Bahan Habis Pakai", subTitle: "Penggantian bahan habis pakai dalam kondisi baik", status: .good, isSelected: true),
    PreparationModel(title: "Kalibrasi Berkala", subTitle: "Kalibrasi dalam kondisi baik", status: .good, isSelected: true),
    PreparationModel(title: "Pengencangan Bagian Alat", subTitle: "Pengencangan bagian alat dalam kondisi rusak. Segera lakukan preventif!", status: .damaged, isSelected: false),
]

let electricalMeasurementData: [ElectricalMeasurementModel] = [
    ElectricalMeasurementModel(value: 10, title: "Tegangan jala-jala(-+ 10%)", description: "Tegangan berkisar 10%"),
    ElectricalMeasurementModel(value: 788, title: "Tahanan protektif pembumian(0.5 omega)", description: "Berkisar diangka 700-800"),
    ElectricalMeasurementModel(value: 0, title: "Tahanan isolasi(> 2 mega)", description: "Tidak ada keterangan"),
    ElectricalMeasurementModel(value: 0, title: "Arus bocor pada alat(< 500)", description: "Tidak ada keterangan"),
    ElectricalMeasurementModel(value: 0, title: "Arus bocor pada bagian yang diaplikasikan ke pasien(< 100)", description: "Tidak ada keterangan")
]

let actionData: [ActionModel] = [
    ActionModel(title: "Ganti Sparepart", desc: "Ganti sparepart secara berkala"),
    ActionModel(title: "Perbaiki Ban Dalam", desc: "Perbaiki ban dalam secara berkala"),
    ActionModel(title: "Isi Tabung Oksigen", desc: "Isi tabung oksigen secara berkala"),
    ActionModel(title: "Kencangkan Sekrup Pada Kursi Roda", desc: "Kencangkan sekurp pada setiap kursi roda")
]

let sparePartData: [SparePartModel] = [
    SparePartModel(title: "Kabel Power", total: 18),
    SparePartModel(title: "Sekrup Kursi Roda", total: 124)
]
