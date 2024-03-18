// 
//  LogBookRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 17/03/24.
//

import UIKit

class LogBookRouter: BaseRouter {
    
    func showView() -> LogBookView {
        let interactor = LogBookInteractor()
        let presenter = LogBookPresenter(interactor: interactor)
        let view = LogBookView(nibName: String(describing: LogBookView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
