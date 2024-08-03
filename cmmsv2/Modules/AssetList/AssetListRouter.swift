//
//  AssetListRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/02/24.
//

import UIKit

class AssetListRouter: BaseRouter {
    
    func showView(type: AssetType) -> AssetListView {
        let interactor = AssetListInteractor()
        let presenter = AssetListPresenter(interactor: interactor, router: self, type: type)
        let view = AssetListView(nibName: String(describing: AssetListView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
