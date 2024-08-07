//
//  NotificationListEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 18/02/24.
//

import Foundation

struct NotificationListEntity: Codable {
    let count: Int?
    let data: NotificationListData?
    let message: String?
    let status: Int?
    let reff: NotificationListReff?
    
    enum CodingKeys: CodingKey {
        case count
        case data
        case message
        case status
        case reff
    }
}

struct NotificationListData: Codable {
    let notifications: [NotificationList]?
    
    enum CodingKeys: CodingKey {
        case notifications
    }
}

struct NotificationList: Codable, Equatable {
    let id: String?
    let title: String?
    let short_title: String?
    let type: String?
    let type_string: NotificationType?
    let link: String?
    let time: String?
    let item_id: String?
    let equipment_id: String? = nil
    let content: String?
    let is_read: String?
    let id_notif_recipient: String?
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case short_title
        case type
        case type_string
        case link
        case time
        case item_id
        case equipment_id
        case content
        case is_read
        case id_notif_recipient
    }
    
    static func ==(lhs: NotificationList, rhs: NotificationList) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.short_title == rhs.short_title &&
        lhs.type == rhs.type &&
        lhs.type_string == rhs.type_string &&
        lhs.link == rhs.link &&
        lhs.time == rhs.time &&
        lhs.item_id == rhs.item_id &&
        lhs.equipment_id == rhs.equipment_id &&
        lhs.content == rhs.content &&
        lhs.is_read == rhs.is_read &&
        lhs.id_notif_recipient == rhs.id_notif_recipient
    }
}

struct NotificationListReff: Codable {
    let page: String?
    let pageSize: String?
    let totalPage: String?
    let totalItem: String?
    
    enum CodingKeys: CodingKey {
        case page
        case pageSize
        case totalPage
        case totalItem
    }
}

struct NotificationSection {
    var timeCategory: String
    var notifications: [NotificationList]
}

extension Array where Element == NotificationList {
    func isEqual(to other: [NotificationList]) -> Bool {
        guard self.count == other.count else {
            return false
        }
        for (index, element) in self.enumerated() {
            if element != other[index] {
                return false
            }
        }
        return true
    }
}
