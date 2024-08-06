//
//  LoadPreventiveRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 29/05/24.
//

import UIKit

class LoadPreventiveRouter: BaseRouter {
    
    func showView(idAsset: String?, idLk: String?) -> LoadPreventiveView {
        let interactor = LoadPreventiveInteractor()
        let presenter = LoadPreventivePresenter(interactor: interactor, router: self, idAsset: idAsset ?? "", idLk: idLk ?? "")
        let view = LoadPreventiveView(nibName: String(describing: LoadPreventiveView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
