//
//  WorkSheetOnsitePreventiveDetailRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/02/24.
//

import UIKit

class WorkSheetOnsitePreventiveDetailRouter: BaseRouter {
    
    func showView(type: WorkSheetOnsitePreventiveDetailType) -> WorkSheetOnsitePreventiveDetailView {
        let interactor = WorkSheetOnsitePreventiveDetailInteractor()
        let router = WorkSheetOnsitePreventiveDetailRouter()
        let presenter = WorkSheetOnsitePreventiveDetailPresenter(interactor: interactor, router: router, type: type)
        let view = WorkSheetOnsitePreventiveDetailView(nibName: String(describing: WorkSheetOnsitePreventiveDetailView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
