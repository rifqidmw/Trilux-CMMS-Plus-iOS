//
//  NSNotification+Ext.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/01/24.
//

import Foundation

extension NSNotification.Name {
    
    static let popToRoot = Notification.Name("popToRoot")
    static let removeOverlay = Notification.Name("RemoveOverlay")
    static let dismissBottomSheet = Notification.Name("DismissBottomSheet")
}
