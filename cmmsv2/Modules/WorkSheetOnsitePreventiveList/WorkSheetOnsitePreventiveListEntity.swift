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
    @objc optional func didTapDownloadPDF()
    @objc optional func didTapCorrection(title: String)
}

let onsitePreventiveData: [WorkSheetListEntity] = [
    WorkSheetListEntity(idLK: "1", idAsset: "1", brandName: "ICU", category: WorkSheetCategory.calibration, status: WorkSheetStatus.done)
]
