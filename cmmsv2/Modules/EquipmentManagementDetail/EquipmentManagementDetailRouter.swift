//
//  EquipmentManagementDetailRouter.swift
//  cmmsv2
//
//  Created by macbook  on 16/09/24.
//

import UIKit

class EquipmentManagementDetailRouter: BaseRouter {
    
    func showView(type: EquipmentManagementType, _ id: String?) -> EquipmentManagementDetailView {
        let interactor = EquipmentManagementDetailInteractor()
        let presenter = EquipmentManagementDetailPresenter(interactor: interactor, router: self, type: type, id: id ?? "")
        let view = EquipmentManagementDetailView(nibName: String(describing: EquipmentManagementDetailView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
