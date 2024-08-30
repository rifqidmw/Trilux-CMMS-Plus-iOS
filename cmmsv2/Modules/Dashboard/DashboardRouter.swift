// 
//  DashboardRouter.swift
//  cmmsv2
//
//  Created by macbook  on 28/08/24.
//

import UIKit

class DashboardRouter: BaseRouter {
    
    func showView() -> DashboardView {
        let interactor = DashboardInteractor()
        let presenter = DashboardPresenter(interactor: interactor)
        let view = DashboardView(nibName: String(describing: DashboardView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
