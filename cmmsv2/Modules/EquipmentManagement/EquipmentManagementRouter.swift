//
//  EquipmentManagementRouter.swift
//  cmmsv2
//
//  Created by macbook  on 10/09/24.
//

import UIKit

class EquipmentManagementRouter: BaseRouter {
    
    func showView(type: EquipmentManagementType) -> EquipmentManagementView {
        let interactor = EquipmentManagementInteractor()
        let presenter = EquipmentManagementPresenter(interactor: interactor, router: self, type: type)
        let view = EquipmentManagementView(nibName: String(describing: EquipmentManagementView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
