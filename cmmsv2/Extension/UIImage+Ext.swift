//
//  UIImage+Ext.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 28/04/24.
//

import Foundation
import UIKit

extension UIImage {
    convenience init?(base64String: String) {
        guard let imageData = Data(base64Encoded: base64String) else { return nil }
        self.init(data: imageData)
    }
}
