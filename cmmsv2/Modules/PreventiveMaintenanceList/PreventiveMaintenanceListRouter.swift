// 
//  PreventiveMaintenanceListRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 11/03/24.
//

import UIKit

class PreventiveMaintenanceListRouter: BaseRouter {
    
    func showView() -> PreventiveMaintenanceListView {
        let interactor = PreventiveMaintenanceListInteractor()
        let presenter = PreventiveMaintenanceListPresenter(interactor: interactor)
        let view = PreventiveMaintenanceListView(nibName: String(describing: PreventiveMaintenanceListView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
