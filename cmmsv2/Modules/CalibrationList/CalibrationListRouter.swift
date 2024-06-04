//
//  CalibrationListRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 12/03/24.
//

import UIKit

class CalibrationListRouter: BaseRouter {
    
    func showView() -> CalibrationListView {
        let interactor = CalibrationListInteractor()
        let presenter = CalibrationListPresenter(interactor: interactor)
        let view = CalibrationListView(nibName: String(describing: CalibrationListView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
