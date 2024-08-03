//
//  AssetFilterRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 25/07/24.
//

import UIKit

class AssetFilterRouter: BaseRouter {
    
    func showView() -> AssetFilterView {
        let interactor = AssetFilterInteractor()
        let presenter = AssetFilterPresenter(interactor: interactor)
        let view = AssetFilterView(nibName: String(describing: AssetFilterView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
