//
//  HistoryDetailRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 18/05/24.
//

import UIKit

class HistoryDetailRouter: BaseRouter {
    
    func showView(id: String?) -> HistoryDetailView {
        let interactor = HistoryDetailInteractor()
        let presenter = HistoryDetailPresenter(interactor: interactor, router: self, id: id ?? "")
        let view = HistoryDetailView(nibName: String(describing: HistoryDetailView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
