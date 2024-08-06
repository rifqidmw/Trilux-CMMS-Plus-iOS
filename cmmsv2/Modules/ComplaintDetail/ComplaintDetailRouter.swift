//
//  ComplaintDetailRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/05/24.
//

import UIKit

class ComplaintDetailRouter: BaseRouter {
    
    func showView(id: String?) -> ComplaintDetailView {
        let interactor = ComplaintDetailInteractor()
        let presenter = ComplaintDetailPresenter(interactor: interactor, id: id ?? "")
        let view = ComplaintDetailView(nibName: String(describing: ComplaintDetailView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
