//
//  BaseRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import Foundation
import UIKit

class BaseRouter {
    func backToPreviousPage(navigation: UINavigationController) {
        navigation.popViewController(animated: true)
    }
    
    func backToHomeScreen() {
        let vc = HomeScreenRouter().showView()
        let rootController = UINavigationController(rootViewController: vc)
        UIApplication.shared.windows.first?.rootViewController = rootController
    }
}
