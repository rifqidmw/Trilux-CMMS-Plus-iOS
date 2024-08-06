//
//  EquipmentMaintenanceRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/08/24.
//

import UIKit

class EquipmentMaintenanceRouter: BaseRouter {
    
    func showView(idAsset: String?) -> EquipmentMaintenanceView {
        let interactor = EquipmentMaintenanceInteractor()
        let presenter = EquipmentMaintenancePresenter(interactor: interactor, router: self, idAsset: idAsset ?? "")
        let view = EquipmentMaintenanceView(nibName: String(describing: EquipmentMaintenanceView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
