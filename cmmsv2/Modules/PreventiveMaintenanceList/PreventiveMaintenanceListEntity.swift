//
//  PreventiveMaintenanceListEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 11/03/24.
//

import Foundation

struct PreventiveCategoryEntity {
    var isSelected = false
    let title: String
    let description: String
    let selectDateTitle: String
    let selectDateTitlePlaceHolder: String
    var selectedDate: String? = nil
    var selectedMonth: String? = nil
}

protocol AddPreventiveBottomSheetDelegate: AnyObject {
    func didTapScheduling(from view: AddPreventiveBottomSheet)
    func didTapPlanning(from view: AddPreventiveBottomSheet)
    func didSavePreventive(from view: AddPreventiveBottomSheet, request: CreatePreventiveRequest)
}

protocol PreventiveCategoryCellDelegate: AnyObject {
    func didTapSelectDate(index: Int)
}

struct InstallationEntity: Codable {
    let data: [InstallationData]?
    let message: String?
    let status: Int?
}

struct InstallationData: Codable {
    let id: String?
    let name: String?
    let idGroup: String?
    let groupName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case idGroup = "id_group"
        case groupName = "group_name"
    }
}
