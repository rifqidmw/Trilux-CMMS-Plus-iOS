// 
//  PreventiveCalendarListRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 18/03/24.
//

import UIKit

class PreventiveCalendarListRouter: BaseRouter {
    
    func showView() -> PreventiveCalendarListView {
        let interactor = PreventiveCalendarListInteractor()
        let presenter = PreventiveCalendarListPresenter(interactor: interactor)
        let view = PreventiveCalendarListView(nibName: String(describing: PreventiveCalendarListView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
