// 
//  WorkSheetOnsitePreventiveListRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 22/01/24.
//

import UIKit

class WorkSheetOnsitePreventiveListRouter: BaseRouter {
    
    func showView() -> WorkSheetOnsitePreventiveListView {
        let interactor = WorkSheetOnsitePreventiveListInteractor()
        let presenter = WorkSheetOnsitePreventiveListPresenter(interactor: interactor)
        let view = WorkSheetOnsitePreventiveListView(nibName: String(describing: WorkSheetOnsitePreventiveListView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
