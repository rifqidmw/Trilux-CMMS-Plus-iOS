//
//  DelayCorrectiveDetailRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 31/05/24.
//

import UIKit

class DelayCorrectiveDetailRouter: BaseRouter {
    
    func showView(data: ComplaintListEntity) -> DelayCorrectiveDetailView {
        let interactor = DelayCorrectiveDetailInteractor()
        let presenter = DelayCorrectiveDetailPresenter(interactor: interactor, router: self, data: data)
        let view = DelayCorrectiveDetailView(nibName: String(describing: DelayCorrectiveDetailView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
