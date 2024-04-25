//
//  LogBookRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 17/03/24.
//

import UIKit

class LogBookListRouter: BaseRouter {
    
    func showView() -> LogBookListView {
        let interactor = LogBookListInteractor()
        let presenter = LogBookListPresenter(interactor: interactor)
        let view = LogBookListView(nibName: String(describing: LogBookListView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
