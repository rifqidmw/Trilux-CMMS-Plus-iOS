//
//  UIImageView+Ext.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 22/01/24.
//

import Foundation
import UIKit
import Kingfisher
import SDWebImage

extension UIImageView {
    func loadImageUrl(_ url: String, placeholder: String = "ic_trilux_logo_splash") {
        self.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: placeholder), options: [.continueInBackground])
    }
}

