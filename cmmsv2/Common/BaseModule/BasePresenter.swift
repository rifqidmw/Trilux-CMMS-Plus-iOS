//
//  BasePresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import Foundation
import Combine
import UIKit

class BasePresenter: NSObject {
    var anyCancellable = Set<AnyCancellable>()
    private let router = BaseRouter()
}

extension BasePresenter {
    
    func navigateToDetailPicture(navigation: UINavigationController, image: String) {
        router.navigateToDetailPicture(navigation: navigation, image: image)
    }
    
}
