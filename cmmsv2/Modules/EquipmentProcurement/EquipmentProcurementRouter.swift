//
//  EquipmentProcurementRouter.swift
//  cmmsv2
//
//  Created by macbook  on 05/10/24.
//

import UIKit

class EquipmentProcurementRouter {
    
    func showView() -> EquipmentProcurementView {
        let interactor = EquipmentProcurementInteractor()
        let presenter = EquipmentProcurementPresenter(interactor: interactor)
        let view = EquipmentProcurementView(nibName: String(describing: EquipmentProcurementView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
