//
//  AssetDetailEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 01/05/24.
//

import Foundation

struct AdditionalDocument {
    let id: Int
    let title: String
}

let documentData: [AdditionalDocument] = [
    AdditionalDocument(id: 1, title: "S. Garansi"),
    AdditionalDocument(id: 2, title: "Sertifikat Kalibrasi"),
    AdditionalDocument(id: 3, title: "Standard Operating Procedure"),
    AdditionalDocument(id: 4, title: "User Manual"),
    AdditionalDocument(id: 5, title: "Service Manual"),
    AdditionalDocument(id: 6, title: "SP Pemeliharaan"),
    AdditionalDocument(id: 7, title: "SP Perbaikan"),
    AdditionalDocument(id: 8, title: "Kontrak"),
    AdditionalDocument(id: 9, title: "BA. Penerimaan"),
    AdditionalDocument(id: 10, title: "Doc AKD / AKL"),
    AdditionalDocument(id: 11, title: "BA Uji Fungsi"),
    AdditionalDocument(id: 12, title: "BA Uji Coba"),
]
